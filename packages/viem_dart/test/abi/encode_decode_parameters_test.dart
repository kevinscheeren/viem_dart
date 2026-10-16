import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/utils.dart';

Uint8List _bytesOf(String s) => Uint8List.fromList(utf8.encode(s));

const _uint256 = AbiParameter(name: '', type: 'uint256');
const _int256 = AbiParameter(name: '', type: 'int256');
const _address = AbiParameter(name: '', type: 'address');
const _bool = AbiParameter(name: '', type: 'bool');
const _string = AbiParameter(name: '', type: 'string');
const _bytes = AbiParameter(name: '', type: 'bytes');

void main() {
  group('encodeAbiParameters — canonical Solidity ABI spec vectors', () {
    // https://docs.soliditylang.org/en/latest/abi-spec.html — baz(uint32,bool)
    // called as baz(69, true). Vector is the spec's encoding minus the
    // 4-byte function selector (encodeAbiParameters doesn't add one).
    test('baz(uint32,bool) called with (69, true)', () {
      final encoded = encodeAbiParameters(
        [const AbiParameter(name: '', type: 'uint32'), _bool],
        [69, true],
      );
      expect(
        bytesToHex(encoded),
        '0x'
        '0000000000000000000000000000000000000000000000000000000000000045'
        '0000000000000000000000000000000000000000000000000000000000000001',
      );
    });

    // Same page — sam(bytes,bool,uint256[]) called as
    // sam("dave", true, [1,2,3]). This is the canonical mixed
    // static+dynamic, dynamic-array example from the spec.
    test('sam(bytes,bool,uint256[]) called with ("dave", true, [1,2,3])', () {
      final encoded = encodeAbiParameters(
        [_bytes, _bool, const AbiParameter(name: '', type: 'uint256[]')],
        [
          _bytesOf('dave'),
          true,
          [BigInt.one, BigInt.two, BigInt.from(3)],
        ],
      );
      expect(
        bytesToHex(encoded),
        '0x'
        '0000000000000000000000000000000000000000000000000000000000000060'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '00000000000000000000000000000000000000000000000000000000000000a0'
        '0000000000000000000000000000000000000000000000000000000000000004'
        '6461766500000000000000000000000000000000000000000000000000000000'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '0000000000000000000000000000000000000000000000000000000000000002'
        '0000000000000000000000000000000000000000000000000000000000000003',
      );
    });
  });

  group('encode/decode round trips — scalars', () {
    test('uint256', () {
      final encoded = encodeAbiParameters(
        [_uint256],
        [BigInt.from(1234567890)],
      );
      expect(decodeAbiParameters([_uint256], encoded), [
        BigInt.from(1234567890),
      ]);
    });

    test('uint256 accepts a plain int', () {
      final encoded = encodeAbiParameters([_uint256], [42]);
      expect(decodeAbiParameters([_uint256], encoded), [BigInt.from(42)]);
    });

    test('int256 negative value round-trips via two\'s complement', () {
      final value = BigInt.from(-1234567890);
      final encoded = encodeAbiParameters([_int256], [value]);
      expect(decodeAbiParameters([_int256], encoded), [value]);
    });

    test('address round-trips and is checksummed on decode', () {
      const address = '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed';
      final encoded = encodeAbiParameters([_address], [address]);
      expect(decodeAbiParameters([_address], encoded), [address]);
    });

    test('bool round-trips', () {
      expect(
        decodeAbiParameters([_bool], encodeAbiParameters([_bool], [true])),
        [true],
      );
      expect(
        decodeAbiParameters([_bool], encodeAbiParameters([_bool], [false])),
        [false],
      );
    });

    test('bytes32 round-trips', () {
      final value = Uint8List(32)..[0] = 0xff;
      const param = AbiParameter(name: '', type: 'bytes32');
      final encoded = encodeAbiParameters([param], [value]);
      expect(decodeAbiParameters([param], encoded), [value]);
    });

    test('dynamic bytes round-trips', () {
      final value = Uint8List.fromList([1, 2, 3, 4, 5]);
      final encoded = encodeAbiParameters([_bytes], [value]);
      expect(decodeAbiParameters([_bytes], encoded), [value]);
    });

    test('string round-trips', () {
      final encoded = encodeAbiParameters([_string], ['hello, ABI']);
      expect(decodeAbiParameters([_string], encoded), ['hello, ABI']);
    });
  });

  group('encode/decode round trips — arrays', () {
    test('dynamic uint256[] round-trips', () {
      const param = AbiParameter(name: '', type: 'uint256[]');
      final values = [BigInt.one, BigInt.two, BigInt.from(3)];
      final encoded = encodeAbiParameters([param], [values]);
      expect(decodeAbiParameters([param], encoded), [values]);
    });

    test('static fixed array uint256[3] round-trips', () {
      const param = AbiParameter(name: '', type: 'uint256[3]');
      final values = [BigInt.one, BigInt.two, BigInt.from(3)];
      final encoded = encodeAbiParameters([param], [values]);
      expect(decodeAbiParameters([param], encoded), [values]);
    });

    test('fixed array with wrong length throws', () {
      const param = AbiParameter(name: '', type: 'uint256[3]');
      expect(
        () => encodeAbiParameters(
          [param],
          [
            [BigInt.one, BigInt.two],
          ],
        ),
        throwsFormatException,
      );
    });

    test('dynamic array of dynamic elements (string[]) round-trips', () {
      const param = AbiParameter(name: '', type: 'string[]');
      final values = ['alpha', 'beta', 'gamma'];
      final encoded = encodeAbiParameters([param], [values]);
      expect(decodeAbiParameters([param], encoded), [values]);
    });

    test('fixed array of dynamic elements (string[2]) round-trips', () {
      const param = AbiParameter(name: '', type: 'string[2]');
      final values = ['alpha', 'beta'];
      final encoded = encodeAbiParameters([param], [values]);
      expect(decodeAbiParameters([param], encoded), [values]);
    });
  });

  group('encode/decode round trips — tuples', () {
    test('static tuple round-trips', () {
      const param = AbiParameter(
        name: '',
        type: 'tuple',
        components: [
          AbiParameter(name: 'a', type: 'uint256'),
          AbiParameter(name: 'b', type: 'bool'),
        ],
      );
      final encoded = encodeAbiParameters(
        [param],
        [
          [BigInt.from(42), true],
        ],
      );
      expect(decodeAbiParameters([param], encoded), [
        [BigInt.from(42), true],
      ]);
    });

    test('static tuple accepts a name-keyed map on encode', () {
      const param = AbiParameter(
        name: '',
        type: 'tuple',
        components: [
          AbiParameter(name: 'a', type: 'uint256'),
          AbiParameter(name: 'b', type: 'bool'),
        ],
      );
      final encoded = encodeAbiParameters(
        [param],
        [
          {'a': BigInt.from(42), 'b': true},
        ],
      );
      expect(decodeAbiParameters([param], encoded), [
        [BigInt.from(42), true],
      ]);
    });

    test('dynamic tuple (containing a string) round-trips', () {
      const param = AbiParameter(
        name: '',
        type: 'tuple',
        components: [
          AbiParameter(name: 'name', type: 'string'),
          AbiParameter(name: 'id', type: 'uint256'),
        ],
      );
      final encoded = encodeAbiParameters(
        [param],
        [
          ['token', BigInt.one],
        ],
      );
      expect(decodeAbiParameters([param], encoded), [
        ['token', BigInt.one],
      ]);
    });

    test('nested tuple round-trips', () {
      const inner = AbiParameter(
        name: 'inner',
        type: 'tuple',
        components: [AbiParameter(name: 'x', type: 'uint256')],
      );
      const outer = AbiParameter(
        name: '',
        type: 'tuple',
        components: [
          inner,
          AbiParameter(name: 'y', type: 'string'),
        ],
      );
      final encoded = encodeAbiParameters(
        [outer],
        [
          [
            [BigInt.from(7)],
            'hi',
          ],
        ],
      );
      expect(decodeAbiParameters([outer], encoded), [
        [
          [BigInt.from(7)],
          'hi',
        ],
      ]);
    });
  });

  group('range/shape validation', () {
    test('uint8 overflow throws', () {
      const param = AbiParameter(name: '', type: 'uint8');
      expect(
        () => encodeAbiParameters([param], [BigInt.from(256)]),
        throwsFormatException,
      );
    });

    test('int8 out of range throws', () {
      const param = AbiParameter(name: '', type: 'int8');
      expect(
        () => encodeAbiParameters([param], [BigInt.from(128)]),
        throwsFormatException,
      );
      expect(
        () => encodeAbiParameters([param], [BigInt.from(-129)]),
        throwsFormatException,
      );
    });

    test('invalid address throws', () {
      expect(
        () => encodeAbiParameters([_address], ['not-an-address']),
        throwsFormatException,
      );
    });

    test('fixed bytes with wrong length throws', () {
      const param = AbiParameter(name: '', type: 'bytes4');
      expect(
        () => encodeAbiParameters(
          [param],
          [
            Uint8List.fromList([1, 2, 3]),
          ],
        ),
        throwsFormatException,
      );
    });

    test('parameter/value count mismatch throws', () {
      expect(
        () => encodeAbiParameters([_uint256, _bool], [BigInt.one]),
        throwsA(isA<AbiEncodingLengthMismatchError>()),
      );
    });
  });
}
