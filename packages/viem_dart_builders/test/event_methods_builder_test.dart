import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/event_methods_builder.dart';
import 'package:viem_dart_builders/src/read_contract_builder.dart';
import 'package:viem_dart_builders/src/type_mapping.dart';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

String _emit(Spec spec) =>
    _formatter.format('${spec.accept(DartEmitter(useNullSafetySyntax: true))}');

AbiParameter _p(
  String name,
  String type, {
  List<AbiParameter>? components,
  bool? indexed,
}) => AbiParameter(
  name: name,
  type: type,
  components: components,
  indexed: indexed,
);

AbiEvent _erc20Transfer() => AbiEvent(
  name: 'Transfer',
  inputs: [
    _p('from', 'address', indexed: true),
    _p('to', 'address', indexed: true),
    _p('value', 'uint256'),
  ],
);

void main() {
  test('the event class has one field per param, typed appropriately', () {
    final mapper = TypeMapper();
    final eventClass = buildEventClass(
      'TransferEvent',
      _erc20Transfer(),
      mapper,
    );
    final source = _emit(eventClass);

    expect(source, contains('class TransferEvent'));
    expect(source, contains('final String from;'));
    expect(source, contains('final String to;'));
    expect(source, contains('final BigInt value;'));
    expect(source, contains('bool operator ==('));
    expect(source, contains('int get hashCode'));
    expect(source, contains('String toString()'));
  });

  test(
    'an indexed dynamic-type field is typed String (the topic hash), not its real type',
    () {
      final mapper = TypeMapper();
      final event = AbiEvent(
        name: 'Announced',
        inputs: [
          _p(
            'message',
            'string',
            indexed: true,
          ), // dynamic + indexed -> hash-only
          _p(
            'sender',
            'address',
            indexed: true,
          ), // value-type + indexed -> real type
          _p('data', 'bytes'), // non-indexed dynamic -> real type
        ],
      );
      final eventClass = buildEventClass('AnnouncedEvent', event, mapper);
      final source = _emit(eventClass);

      expect(source, contains('final String message;'));
      expect(source, contains('final String sender;'));
      expect(source, contains('final Uint8List data;'));
    },
  );

  test('getEvents fetches past logs and decodes them into the typed class', () {
    final method = buildGetEventsMethod(
      'TransferEvent',
      _erc20Transfer(),
      TypeMapper(),
    );
    final source = _emit(method);

    expect(source, contains('Future<List<TransferEvent>> getTransferEvents({'));
    expect(source, contains('String? from,'));
    expect(source, contains('String? to,'));
    expect(source, contains("String fromBlockTag = 'earliest',"));
    expect(source, contains("String toBlockTag = 'latest',"));
    expect(source, contains('client.getContractEvents('));
    expect(source, contains("'from': ?from"));
    expect(source, contains("'to': ?to"));
    expect(source, contains('TransferEvent('));
    expect(source, contains("from: m['from'] as String,"));
    expect(source, contains("to: m['to'] as String,"));
    expect(source, contains("value: m['value'] as BigInt,"));
  });

  test('watchEvent streams new logs decoded into the typed class', () {
    final method = buildWatchEventMethod(
      'TransferEvent',
      _erc20Transfer(),
      TypeMapper(),
    );
    final source = _emit(method);

    expect(source, contains('Stream<TransferEvent> watchTransferEvent({'));
    expect(
      source,
      contains('Duration pollingInterval = const Duration(seconds: 4),'),
    );
    expect(source, contains('client.watchContractEvent('));
    expect(source, contains('await for (final m in'));
    expect(source, contains('yield TransferEvent('));
  });

  test('only indexed params become filter parameters', () {
    final event = AbiEvent(
      name: 'Swap',
      inputs: [
        _p('sender', 'address', indexed: true),
        _p('amountIn', 'uint256'),
        _p('amountOut', 'uint256'),
      ],
    );
    final getMethod = buildGetEventsMethod('SwapEvent', event, TypeMapper());
    final source = _emit(getMethod);

    expect(source, contains('String? sender,'));
    expect(source, isNot(contains('amountIn,')));
    expect(source, isNot(contains('amountOut,')));
  });

  test('overloaded event names get disambiguated class/method names', () {
    final mapper = TypeMapper();
    final events = [
      AbiEvent(name: 'Log', inputs: [_p('a', 'address')]),
      AbiEvent(name: 'Log', inputs: [_p('a', 'address'), _p('b', 'uint256')]),
    ];
    final result = buildEventMethods(events, mapper);

    expect(result.eventClasses.map((c) => c.name), ['LogEvent', 'LogEvent2']);
    expect(result.contractMethods.map((m) => m.name), [
      'getLogEvents',
      'watchLogEvent',
      'getLogEvent2s',
      'watchLogEvent2',
    ]);
  });

  test(
    'the full generated Contract + event classes are valid, analyzable Dart',
    () async {
      final mapper = TypeMapper();
      final events = [
        _erc20Transfer(),
        AbiEvent(
          name: 'Approval',
          inputs: [
            _p('owner', 'address', indexed: true),
            _p('spender', 'address', indexed: true),
            _p('value', 'uint256'),
          ],
        ),
      ];
      final result = buildReadContractClass(
        className: 'Erc20',
        functions: [
          AbiFunction(
            name: 'balanceOf',
            inputs: [_p('owner', 'address')],
            outputs: [_p('', 'uint256')],
            stateMutability: 'view',
          ),
        ],
        events: events,
        typeMapper: mapper,
      );

      final library = Library(
        (b) => b
          ..directives.addAll([
            Directive.import('package:viem_dart/viem_dart.dart'),
            Directive.import('package:viem_dart/abi.dart'),
          ])
          ..body.addAll(mapper.tupleClasses)
          ..body.addAll(mapper.fromDecodedFunctions)
          ..body.addAll(deepEqualsHelperFunctions())
          ..body.addAll(result.eventClasses)
          ..body.add(result.contractClass),
      );
      final source =
          DartFormatter(
            languageVersion: DartFormatter.latestLanguageVersion,
          ).format(
            '${library.accept(DartEmitter.scoped(useNullSafetySyntax: true))}',
          );

      final probeDir = Directory('test/.generated_probe/event_methods');
      await probeDir.create(recursive: true);
      addTearDown(() => probeDir.delete(recursive: true));
      final file = File('${probeDir.path}/generated_event_probe.dart');
      await file.writeAsString(source);

      final result2 = await Process.run('dart', [
        'analyze',
        '--fatal-infos',
        file.path,
      ]);
      expect(
        result2.exitCode,
        0,
        reason:
            'Generated source failed `dart analyze`:\n$source\n\n'
            '${result2.stdout}\n${result2.stderr}',
      );
    },
  );
}
