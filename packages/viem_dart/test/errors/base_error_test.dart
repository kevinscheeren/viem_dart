import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('ViemError', () {
    test('toString includes the short message', () {
      const error = ViemError('Something went wrong.');
      expect(error.toString(), 'Something went wrong.');
    });

    test('toString appends meta messages and the cause', () {
      const error = ViemError(
        'Something went wrong.',
        metaMessages: ['Details: foo', 'Details: bar'],
        cause: 'underlying failure',
      );
      final rendered = error.toString();
      expect(rendered, contains('Something went wrong.'));
      expect(rendered, contains('Details: foo'));
      expect(rendered, contains('Details: bar'));
      expect(rendered, contains('Caused by: underlying failure'));
    });
  });
}
