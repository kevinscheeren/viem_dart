// Vendored from package:ens_normalize (github.com/vaariance/ens-dart),
// BSD-3-Clause — see LICENSE and ATTRIBUTION.md in this directory.
//
// Stripped: the `fromSpecJsonPath` factory and its `dart:io` import were
// removed (dead code on the path viem_dart actually uses — normalization
// data loads from the embedded `spec` constant in spec.dart, not from a
// file on disk) so this compiles on every platform, including web/wasm.
//
// Modernized: `class NORMALIZATION` -> `abstract class NORMALIZATION`,
// matching the interface-mixin shape freezed 3.0+ generates (upstream
// targeted freezed 2.x's concrete-mixin shape).

import 'package:freezed_annotation/freezed_annotation.dart';

import 'ens_normalize_base.dart';

part 'normalization.freezed.dart';
part 'normalization.g.dart';

@freezed
abstract class NORMALIZATION with _$NORMALIZATION {
  const factory NORMALIZATION({
    required String unicodeVersion,
    required Set<int> ignored,
    required Map<int, List<int>> mapped,
    required Set<int> cm,
    required List<List<int>> emoji,
    required Set<int> nfcCheck,
    required Map<int, String> fenced,
    required List<int> escape,
    required List<Group> groups,
    required Set<int> valid,
    @WholeMapConverter() required Map<int, dynamic> wholeMap,
    required int nsmMax,
    required Set<int> nsm,
    required Map<String, String> emojiFe0fLookup,
    @RegExpConverter() required RegExp emojiRegex,
  }) = _NORMALIZATION;

  factory NORMALIZATION.fromJson(Map<String, dynamic> json) =>
      _$NORMALIZATIONFromJson(json);
}

class RegExpConverter implements JsonConverter<RegExp, String> {
  const RegExpConverter();

  @override
  RegExp fromJson(String json) => RegExp(json);

  @override
  String toJson(RegExp data) => data.pattern;
}

class WholeMapConverter
    implements JsonConverter<Map<int, dynamic>, Map<String, dynamic>> {
  const WholeMapConverter();

  @override
  Map<int, dynamic> fromJson(Map<String, dynamic> json) =>
      Map<int, dynamic>.from(dictKeysToInt(json));

  @override
  Map<String, dynamic> toJson(Map<int, dynamic> data) =>
      Map<String, dynamic>.from(dictKeysToString(data));
}
