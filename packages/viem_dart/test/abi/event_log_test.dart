import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/utils.dart';

void main() {
  final transferEvent =
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

  const from = '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed';
  const to = '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359';

  group('encodeEventTopics', () {
    // Universally-known ERC-20 Transfer event signature hash, verified
    // independently.
    test(
      'topics[0] is the Transfer(address,address,uint256) signature hash',
      () {
        final topics = encodeEventTopics(transferEvent, {
          'from': from,
          'to': to,
        });
        expect(
          topics[0],
          '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
        );
      },
    );

    test('indexed value-type params encode directly (left-padded)', () {
      final topics = encodeEventTopics(transferEvent, {'from': from, 'to': to});
      expect(topics[1], padHex(from.toLowerCase()));
      expect(topics[2], padHex(to.toLowerCase()));
    });

    test('an omitted indexed param becomes a null (wildcard) topic', () {
      final topics = encodeEventTopics(transferEvent, {'from': from});
      expect(topics[1], isNotNull);
      expect(topics[2], isNull);
    });

    test('anonymous events omit the signature-hash topic', () {
      final anonymousEvent =
          AbiItem.fromJson({
                'type': 'event',
                'name': 'Anon',
                'inputs': [
                  {'name': 'x', 'type': 'address', 'indexed': true},
                ],
                'anonymous': true,
              })
              as AbiEvent;
      final topics = encodeEventTopics(anonymousEvent, {'x': from});
      expect(topics, hasLength(1));
      expect(topics[0], padHex(from.toLowerCase()));
    });

    test(
      'a dynamic indexed param (string) is keccak256 of the raw UTF-8 bytes',
      () {
        final event =
            AbiItem.fromJson({
                  'type': 'event',
                  'name': 'Named',
                  'inputs': [
                    {'name': 'label', 'type': 'string', 'indexed': true},
                  ],
                  'anonymous': false,
                })
                as AbiEvent;
        final topics = encodeEventTopics(event, {'label': 'hello'});
        expect(
          topics[1],
          bytesToHex(keccak256(Uint8List.fromList(utf8.encode('hello')))),
        );
      },
    );
  });

  group('decodeEventLog', () {
    test('decodes indexed and non-indexed params from topics + data', () {
      final topics = encodeEventTopics(transferEvent, {
        'from': from,
        'to': to,
      }).cast<String>();
      final data = encodeAbiParameters(
        [const AbiParameter(name: 'value', type: 'uint256')],
        [BigInt.from(1000)],
      );

      final decoded = decodeEventLog(transferEvent, topics: topics, data: data);
      expect(decoded['from'], from);
      expect(decoded['to'], to);
      expect(decoded['value'], BigInt.from(1000));
    });

    test(
      'rejects a log whose topics[0] does not match the event signature',
      () {
        final data = Uint8List(0);
        expect(
          () => decodeEventLog(
            transferEvent,
            topics: [
              '0x${'00' * 32}',
              padHex(from.toLowerCase()),
              padHex(to.toLowerCase()),
            ],
            data: data,
          ),
          throwsFormatException,
        );
      },
    );

    test(
      'a dynamic indexed param decodes to its topic hash, not the original value',
      () {
        final event =
            AbiItem.fromJson({
                  'type': 'event',
                  'name': 'Named',
                  'inputs': [
                    {'name': 'label', 'type': 'string', 'indexed': true},
                  ],
                  'anonymous': false,
                })
                as AbiEvent;
        final topics = encodeEventTopics(event, {
          'label': 'hello',
        }).cast<String>();
        final decoded = decodeEventLog(
          event,
          topics: topics,
          data: Uint8List(0),
        );
        expect(
          decoded['label'],
          bytesToHex(keccak256(Uint8List.fromList(utf8.encode('hello')))),
        );
      },
    );
  });
}
