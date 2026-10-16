import 'package:code_builder/code_builder.dart';
import 'package:viem_dart/abi.dart';

import 'abi_literal.dart';
import 'name_utils.dart';
import 'type_mapping.dart';

/// Builds, for each ABI event in [events]: a typed event-data [Class]
/// (`<Event>Event`, one field per event param — see [buildEventClass]),
/// plus a `get<Event>Events`/`watch<Event>Event` method pair on the
/// read-only `<Name>Contract` class (both are `PublicClient`-only
/// capabilities — `getContractEvents`/`watchContractEvent` live on
/// `ContractActions`, not `ContractWalletActions` — so both land on the
/// read side, same split as the runtime API). Replaces
/// `getContractEvents`/`watchContractEvent`'s untyped `Map<String,
/// Object?>` shape.
class EventMethodsResult {
  const EventMethodsResult({
    required this.eventClasses,
    required this.contractMethods,
  });

  /// One generated `<Event>Event` class per ABI event in [events].
  final List<Class> eventClasses;

  /// The `get<Event>Events`/`watch<Event>Event` method pairs, added to
  /// `<Name>Contract`'s own `methods`.
  final List<Method> contractMethods;
}

EventMethodsResult buildEventMethods(List<AbiEvent> events, TypeMapper mapper) {
  final classNames = uniqueNames(
    events.map((e) => '${e.name}Event').toList(),
  ).map(pascalCase).toList();

  final eventClasses = <Class>[];
  final contractMethods = <Method>[];
  for (var i = 0; i < events.length; i++) {
    final event = events[i];
    final className = classNames[i];
    eventClasses.add(buildEventClass(className, event, mapper));
    contractMethods.add(buildGetEventsMethod(className, event, mapper));
    contractMethods.add(buildWatchEventMethod(className, event, mapper));
  }
  return EventMethodsResult(
    eventClasses: eventClasses,
    contractMethods: contractMethods,
  );
}

/// The typed data class for one ABI [event]: one field per param.
///
/// An **indexed dynamic-type** param (`string`/`bytes`/any array/tuple —
/// see `isEventTopicValueType`) is typed `String` here, not its "real"
/// mapped type: `decodeEventLog` can only recover that field's
/// `keccak256` topic hash from a log, never the original value (a
/// fundamental EVM log limitation, not a viem_dart gap — see
/// `event_log.dart`'s own doc comment). Every other field (non-indexed, or
/// indexed *value*-type) gets its normal [TypeMapper]-mapped type, decoded
/// the same way a read method's output is (see [TypeMapper.convertFromDecoded]).
Class buildEventClass(String className, AbiEvent event, TypeMapper mapper) {
  final fieldNames = uniqueNames(event.inputs.map((p) => p.name).toList());
  final fieldTypes = event.inputs
      .map(
        (p) => (p.indexed == true && !isEventTopicValueType(p))
            ? TypeReference((b) => b..symbol = 'String')
            : mapper.dartType(p),
      )
      .toList();

  return Class(
    (b) => b
      ..name = className
      ..docs.add(
        "/// Generated typed event-data class for the `${event.name}` "
        'event — see `TypeMapper`/`buildEventMethods`.',
      )
      ..constructors.add(
        Constructor(
          (c) => c
            ..constant = true
            ..optionalParameters.addAll(
              fieldNames.map(
                (f) => Parameter(
                  (p) => p
                    ..name = f
                    ..named = true
                    ..required = true
                    ..toThis = true,
                ),
              ),
            ),
        ),
      )
      ..fields.addAll(
        List.generate(
          fieldNames.length,
          (i) => Field(
            (f) => f
              ..name = fieldNames[i]
              ..type = fieldTypes[i]
              ..modifier = FieldModifier.final$,
          ),
        ),
      )
      ..methods.add(_equalsMethod(className, fieldNames))
      ..methods.add(_hashCodeMethod(fieldNames))
      ..methods.add(_toStringMethod(className, fieldNames)),
  );
}

Method _equalsMethod(String className, List<String> fieldNames) => Method(
  (m) => m
    ..name = 'operator =='
    ..returns = refer('bool')
    ..annotations.add(refer('override'))
    ..requiredParameters.add(
      Parameter(
        (p) => p
          ..name = 'other'
          ..type = refer('Object'),
      ),
    )
    ..body = Code(
      'return identical(this, other) || '
      '(other is $className${fieldNames.isEmpty ? '' : ' && '}'
      '${fieldNames.map((f) => '$deepEqualsFunctionName(other.$f, $f)').join(' && ')});',
    ),
);

Method _hashCodeMethod(List<String> fieldNames) => Method(
  (m) => m
    ..name = 'hashCode'
    ..type = MethodType.getter
    ..returns = refer('int')
    ..annotations.add(refer('override'))
    ..body = Code(
      fieldNames.isEmpty
          ? 'return 0;'
          : 'return Object.hashAll('
                '[${fieldNames.map((f) => '$deepHashFunctionName($f)').join(', ')}]);',
    ),
);

Method _toStringMethod(String className, List<String> fieldNames) => Method(
  (m) => m
    ..name = 'toString'
    ..returns = refer('String')
    ..annotations.add(refer('override'))
    ..body = Code(
      "return '$className(${fieldNames.map((f) => '$f: \$$f').join(', ')})';",
    ),
);

/// Indexed event params — the only ones a log filter can act on
/// (`eth_getLogs`/`eth_newFilter` filter by topic, and only indexed params
/// become topics at all).
List<AbiParameter> _indexedParams(AbiEvent event) =>
    event.inputs.where((p) => p.indexed == true).toList();

/// `get<Event>Events`: past-log fetch + typed decode, wrapping
/// `ContractActions.getContractEvents`.
Method buildGetEventsMethod(
  String className,
  AbiEvent event,
  TypeMapper mapper,
) {
  final indexed = _indexedParams(event);
  final filterNames = uniqueNames(indexed.map((p) => p.name).toList());

  return Method(
    (m) => m
      ..name = 'get${className}s'
      ..modifier = MethodModifier.async
      ..docs.add('/// Fetches past `${event.name}` events.')
      ..returns = TypeReference(
        (t) => t
          ..symbol = 'Future'
          ..types.add(
            TypeReference(
              (t2) => t2
                ..symbol = 'List'
                ..types.add(refer(className)),
            ),
          ),
      )
      ..optionalParameters.addAll([
        for (var i = 0; i < indexed.length; i++)
          Parameter(
            (p) => p
              ..name = filterNames[i]
              ..named = true
              ..type = mapper
                  .dartType(indexed[i])
                  .rebuild((t) => t.isNullable = true),
          ),
        Parameter(
          (p) => p
            ..name = 'fromBlockNumber'
            ..named = true
            ..type = refer('BigInt?'),
        ),
        Parameter(
          (p) => p
            ..name = 'fromBlockTag'
            ..named = true
            ..type = refer('String')
            ..defaultTo = literalString('earliest').code,
        ),
        Parameter(
          (p) => p
            ..name = 'toBlockNumber'
            ..named = true
            ..type = refer('BigInt?'),
        ),
        Parameter(
          (p) => p
            ..name = 'toBlockTag'
            ..named = true
            ..type = refer('String')
            ..defaultTo = literalString('latest').code,
        ),
      ])
      ..body = Code(
        'final maps = await client.getContractEvents('
        'address: address, '
        'event: ${_abiEventExprSource(event)}, '
        'args: ${_filterArgsMapSource(filterNames, indexed)}, '
        'fromBlockNumber: fromBlockNumber, '
        'fromBlockTag: fromBlockTag, '
        'toBlockNumber: toBlockNumber, '
        'toBlockTag: toBlockTag);\n'
        'return maps.map((m) => ${_eventFromMapSource(className, event, mapper)}).toList();',
      ),
  );
}

/// `watch<Event>Event`: live-log subscription + typed decode, wrapping
/// `ContractActions.watchContractEvent`.
Method buildWatchEventMethod(
  String className,
  AbiEvent event,
  TypeMapper mapper,
) {
  final indexed = _indexedParams(event);
  final filterNames = uniqueNames(indexed.map((p) => p.name).toList());

  return Method(
    (m) => m
      ..name = 'watch$className'
      ..modifier = MethodModifier.asyncStar
      ..docs.add('/// Watches for new `${event.name}` events.')
      ..returns = TypeReference(
        (t) => t
          ..symbol = 'Stream'
          ..types.add(refer(className)),
      )
      ..optionalParameters.addAll([
        for (var i = 0; i < indexed.length; i++)
          Parameter(
            (p) => p
              ..name = filterNames[i]
              ..named = true
              ..type = mapper
                  .dartType(indexed[i])
                  .rebuild((t) => t.isNullable = true),
          ),
        Parameter(
          (p) => p
            ..name = 'pollingInterval'
            ..named = true
            ..type = refer('Duration')
            ..defaultTo = const Code('const Duration(seconds: 4)'),
        ),
      ])
      ..body = Code(
        'await for (final m in client.watchContractEvent('
        'address: address, '
        'event: ${_abiEventExprSource(event)}, '
        'args: ${_filterArgsMapSource(filterNames, indexed)}, '
        'pollingInterval: pollingInterval)) {\n'
        '  yield ${_eventFromMapSource(className, event, mapper)};\n'
        '}',
      ),
  );
}

/// `{'abiName': ?dartName, ...}` — Dart's null-aware map-entry syntax
/// (`?value`, entry omitted when the value is null) — only includes a
/// filter arg when the caller actually passed one, matching
/// `encodeEventTopics`'s own "omitted -> match any value" convention.
///
/// The map *key* must be the event param's original ABI name
/// (`encodeEventTopics` looks values up by `param.name`), which can differ
/// from [dartNames]' disambiguated/camelCased Dart parameter name —
/// getting this wrong would silently produce "match any value" for every
/// filter whenever a param's raw ABI name isn't already valid, unique
/// camelCase Dart (an easy bug to miss, since it fails silently rather
/// than throwing).
String _filterArgsMapSource(
  List<String> dartNames,
  List<AbiParameter> abiParams,
) {
  if (dartNames.isEmpty) return '{}';
  final entries = List.generate(
    dartNames.length,
    (i) => "'${abiParams[i].name}': ?${dartNames[i]}",
  ).join(', ');
  return '{$entries}';
}

String _eventFromMapSource(
  String className,
  AbiEvent event,
  TypeMapper mapper,
) {
  final fieldNames = uniqueNames(event.inputs.map((p) => p.name).toList());
  final args = List.generate(event.inputs.length, (i) {
    final param = event.inputs[i];
    final mapAccess = "m['${param.name}']";
    final conversion = (param.indexed == true && !isEventTopicValueType(param))
        ? '$mapAccess as String'
        : mapper.convertFromDecoded(mapAccess, param);
    return '${fieldNames[i]}: $conversion';
  });
  return '$className(${args.join(', ')})';
}

String _abiEventExprSource(AbiEvent event) => abiEventLiteral(
  event,
).accept(DartEmitter(useNullSafetySyntax: true)).toString();
