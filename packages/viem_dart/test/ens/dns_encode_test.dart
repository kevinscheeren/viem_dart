import 'package:test/test.dart';
import 'package:viem_dart/ens.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('dnsEncodeName', () {
    test('encodes a single label', () {
      expect(bytesToHex(dnsEncodeName('eth')), '0x0365746800');
    });

    test('encodes multiple labels in original left-to-right order', () {
      expect(
        bytesToHex(dnsEncodeName('vitalik.eth')),
        '0x07766974616c696b0365746800',
      );
    });

    test('a three-label name', () {
      expect(bytesToHex(dnsEncodeName('a.b.c')), '0x01610162016300');
    });

    test('the empty/root name is a single zero byte', () {
      expect(bytesToHex(dnsEncodeName('')), '0x00');
    });

    test('strips leading and trailing dots', () {
      expect(
        bytesToHex(dnsEncodeName('.eth.')),
        bytesToHex(dnsEncodeName('eth')),
      );
    });
  });
}
