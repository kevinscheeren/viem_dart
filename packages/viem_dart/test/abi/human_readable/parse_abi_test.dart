import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('parseAbiItem — function', () {
    test('parses a simple function with named params and a return type', () {
      final item = parseAbiItem(
        'function transfer(address to, uint256 amount) returns (bool)',
      );
      final fn = item as AbiFunction;
      expect(fn.name, 'transfer');
      expect(fn.inputs, [
        const AbiParameter(name: 'to', type: 'address'),
        const AbiParameter(name: 'amount', type: 'uint256'),
      ]);
      expect(fn.outputs, [const AbiParameter(name: '', type: 'bool')]);
      expect(fn.stateMutability, 'nonpayable');
    });

    test(
      'matches the JSON-constructed equivalent exactly (including selector)',
      () {
        final parsed =
            parseAbiItem(
                  'function transfer(address to, uint256 amount) returns (bool)',
                )
                as AbiFunction;
        final fromJson =
            AbiItem.fromJson({
                  'type': 'function',
                  'name': 'transfer',
                  'inputs': [
                    {'name': 'to', 'type': 'address'},
                    {'name': 'amount', 'type': 'uint256'},
                  ],
                  'outputs': [
                    {'name': '', 'type': 'bool'},
                  ],
                  'stateMutability': 'nonpayable',
                })
                as AbiFunction;
        expect(parsed, fromJson);
        expect(
          bytesToHex(abiSelector(parsed.name, parsed.inputs)),
          bytesToHex(abiSelector(fromJson.name, fromJson.inputs)),
        );
        expect(
          bytesToHex(abiSelector(parsed.name, parsed.inputs)),
          '0xa9059cbb',
        );
      },
    );

    test('parses stateMutability and ignores visibility keywords', () {
      expect(
        (parseAbiItem('function totalSupply() public view returns (uint256)')
                as AbiFunction)
            .stateMutability,
        'view',
      );
      expect(
        (parseAbiItem('function deposit() external payable') as AbiFunction)
            .stateMutability,
        'payable',
      );
      expect(
        (parseAbiItem('function noop() external') as AbiFunction)
            .stateMutability,
        'nonpayable',
      );
    });

    test('normalizes bare uint/int to uint256/int256', () {
      final fn = parseAbiItem('function f(uint a, int b)') as AbiFunction;
      expect(fn.inputs[0].type, 'uint256');
      expect(fn.inputs[1].type, 'int256');
    });

    test('strips storage-location keywords', () {
      final fn =
          parseAbiItem('function f(bytes calldata data, string memory label)')
              as AbiFunction;
      expect(fn.inputs[0].type, 'bytes');
      expect(fn.inputs[0].name, 'data');
      expect(fn.inputs[1].name, 'label');
    });

    test('parses array types, including fixed and multi-dimensional', () {
      final fn =
          parseAbiItem('function f(uint256[] a, uint256[3] b, uint256[][2] c)')
              as AbiFunction;
      expect(fn.inputs[0].type, 'uint256[]');
      expect(fn.inputs[1].type, 'uint256[3]');
      expect(fn.inputs[2].type, 'uint256[][2]');
    });

    test('parses multiple return values', () {
      final fn =
          parseAbiItem('function f() returns (uint256 a, bool b)')
              as AbiFunction;
      expect(fn.outputs, [
        const AbiParameter(name: 'a', type: 'uint256'),
        const AbiParameter(name: 'b', type: 'bool'),
      ]);
    });
  });

  group('parseAbiItem — inline tuples', () {
    test('parses a struct-shaped tuple parameter', () {
      final fn =
          parseAbiItem('function setConfig((address owner, uint96 fee) config)')
              as AbiFunction;
      final param = fn.inputs.single;
      expect(param.type, 'tuple');
      expect(param.name, 'config');
      expect(param.components, [
        const AbiParameter(name: 'owner', type: 'address'),
        const AbiParameter(name: 'fee', type: 'uint96'),
      ]);
    });

    test('parses a tuple array parameter', () {
      final fn = parseAbiItem('function f((uint256 x)[] items)') as AbiFunction;
      final param = fn.inputs.single;
      expect(param.type, 'tuple[]');
      expect(param.components!.single.type, 'uint256');
    });

    test('parses a fixed-size tuple array parameter', () {
      final fn =
          parseAbiItem('function f((uint256 x)[3] items)') as AbiFunction;
      expect(fn.inputs.single.type, 'tuple[3]');
    });

    test('parses nested tuples', () {
      final fn =
          parseAbiItem(
                'function f((uint256 x, (bool y, string z) inner) outer)',
              )
              as AbiFunction;
      final outer = fn.inputs.single;
      expect(outer.components![0].type, 'uint256');
      final inner = outer.components![1];
      expect(inner.type, 'tuple');
      expect(inner.components, [
        const AbiParameter(name: 'y', type: 'bool'),
        const AbiParameter(name: 'z', type: 'string'),
      ]);
    });
  });

  group('parseAbiItem — event/error/constructor/fallback/receive', () {
    test('parses an event with indexed params, matching the JSON equivalent', () {
      final parsed =
          parseAbiItem(
                'event Transfer(address indexed from, address indexed to, uint256 value)',
              )
              as AbiEvent;
      final fromJson =
          AbiItem.fromJson({
                'type': 'event',
                'name': 'Transfer',
                'inputs': [
                  {'name': 'from', 'type': 'address', 'indexed': true},
                  {'name': 'to', 'type': 'address', 'indexed': true},
                  {'name': 'value', 'type': 'uint256', 'indexed': false},
                ],
                'anonymous': false,
              })
              as AbiEvent;
      expect(parsed.name, fromJson.name);
      expect(parsed.inputs[0].indexed, isTrue);
      expect(parsed.inputs[2].indexed, isNull);
      expect(
        abiSignature(parsed.name, parsed.inputs),
        abiSignature(fromJson.name, fromJson.inputs),
      );
      expect(
        abiSignature(parsed.name, parsed.inputs),
        'Transfer(address,address,uint256)',
      );
    });

    test('parses an error', () {
      final err =
          parseAbiItem(
                'error InsufficientBalance(uint256 available, uint256 required)',
              )
              as AbiError;
      expect(err.name, 'InsufficientBalance');
      expect(err.inputs, hasLength(2));
    });

    test('parses a constructor', () {
      final ctor =
          parseAbiItem('constructor(uint256 initialSupply)') as AbiConstructor;
      expect(ctor.inputs.single.type, 'uint256');
      expect(ctor.stateMutability, 'nonpayable');
    });

    test('parses a payable constructor', () {
      final ctor =
          parseAbiItem('constructor(uint256 initialSupply) payable')
              as AbiConstructor;
      expect(ctor.stateMutability, 'payable');
    });

    test('parses fallback and receive', () {
      expect(
        (parseAbiItem('fallback() external') as AbiFallback).stateMutability,
        'nonpayable',
      );
      expect(
        (parseAbiItem('fallback() external payable') as AbiFallback)
            .stateMutability,
        'payable',
      );
      expect(parseAbiItem('receive() external payable'), isA<AbiReceive>());
    });

    test('rejects named struct declarations with a clear error', () {
      expect(
        () => parseAbiItem('struct Foo { uint256 a; bool b; }'),
        throwsFormatException,
      );
    });

    test('rejects an unrecognized signature', () {
      expect(() => parseAbiItem('nonsense signature'), throwsFormatException);
    });
  });

  group('parseAbi', () {
    test('parses a list of mixed item kinds', () {
      final abi = parseAbi([
        'function transfer(address to, uint256 amount) returns (bool)',
        'function balanceOf(address owner) view returns (uint256)',
        'event Transfer(address indexed from, address indexed to, uint256 value)',
        'error InsufficientBalance(uint256 available, uint256 required)',
      ]);
      expect(abi, hasLength(4));
      expect(abi[0], isA<AbiFunction>());
      expect(abi[1], isA<AbiFunction>());
      expect(abi[2], isA<AbiEvent>());
      expect(abi[3], isA<AbiError>());
    });

    test('skips blank entries', () {
      expect(parseAbi(['function f()', '', '  ']), hasLength(1));
    });
  });

  group('parseAbiParameter', () {
    test('parses a standalone parameter declaration', () {
      final param = parseAbiParameter('address indexed from');
      expect(param.type, 'address');
      expect(param.name, 'from');
      expect(param.indexed, isTrue);
    });
  });
}
