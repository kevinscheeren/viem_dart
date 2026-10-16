import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('RpcError.fromResponse', () {
    test('returns UserRejectedRequestError for code 4001', () {
      final error = RpcError.fromResponse(code: 4001, rpcMessage: 'ignored');
      expect(error, isA<UserRejectedRequestError>());
      expect(error.code, 4001);
      expect(error.shortMessage, contains('User rejected the request.'));
    });

    test('returns MethodNotFoundRpcError for code -32601', () {
      final error = RpcError.fromResponse(code: -32601, rpcMessage: 'ignored');
      expect(error, isA<MethodNotFoundRpcError>());
      expect(error.code, -32601);
    });

    test('returns InvalidParamsRpcError for code -32602', () {
      final error = RpcError.fromResponse(code: -32602, rpcMessage: 'ignored');
      expect(error, isA<InvalidParamsRpcError>());
      expect(error.code, -32602);
    });

    test('returns InternalRpcError for code -32603', () {
      final error = RpcError.fromResponse(code: -32603, rpcMessage: 'ignored');
      expect(error, isA<InternalRpcError>());
      expect(error.code, -32603);
    });

    test('falls back to a plain RpcError for unrecognized codes', () {
      final error = RpcError.fromResponse(
        code: -32000,
        rpcMessage: 'execution reverted',
      );
      expect(error.runtimeType, RpcError);
      expect(error.code, -32000);
      expect(error.shortMessage, 'RPC Error: execution reverted');
    });

    test('preserves attached data', () {
      final error = RpcError.fromResponse(
        code: -32000,
        rpcMessage: 'boom',
        data: {'foo': 'bar'},
      );
      expect(error.data, {'foo': 'bar'});
    });
  });
}
