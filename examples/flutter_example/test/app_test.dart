import 'package:flutter/material.dart';
import 'package:flutter_example/balance_screen.dart';
import 'package:flutter_example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viem_dart/viem_dart.dart';

/// A client whose node answers `eth_getBalance` with [onBalance].
PublicClient _clientAnswering(JsonRpcResponse Function(int id) onBalance) =>
    PublicClient(
      transport: CustomTransport((request) async => onBalance(request.id)),
    );

void main() {
  testWidgets('boots to home and navigates to the balance tab', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Welcome'), findsOneWidget);
    await tester.tap(find.text('Balance'));
    await tester.pumpAndSettle();
    expect(find.text('ETH Balance'), findsOneWidget);
  });

  group('BalanceScreen', () {
    Future<void> pump(WidgetTester tester, PublicClient client) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: BalanceScreen(client: client)),
          ),
        );

    testWidgets('shows the balance the node returns', (tester) async {
      await pump(
        tester,
        // 1.5 ETH in wei, hex.
        _clientAnswering(
          (id) => JsonRpcResponse(id: id, result: '0x14d1120d7b160000'),
        ),
      );
      await tester.tap(find.text('Fetch balance'));
      await tester.pumpAndSettle();
      expect(find.text('1.5 ETH'), findsOneWidget);
    });

    testWidgets('shows the error when the node fails', (tester) async {
      await pump(
        tester,
        _clientAnswering(
          (id) => JsonRpcResponse(
            id: id,
            error: const JsonRpcErrorPayload(code: -32005, message: 'busy'),
          ),
        ),
      );
      await tester.tap(find.text('Fetch balance'));
      await tester.pumpAndSettle();
      expect(find.text('Could not fetch balance'), findsOneWidget);
      expect(find.textContaining('busy'), findsOneWidget);
    });

    testWidgets('rejects an invalid address without calling the node', (
      tester,
    ) async {
      var calls = 0;
      await pump(
        tester,
        _clientAnswering((id) {
          calls++;
          return JsonRpcResponse(id: id, result: '0x0');
        }),
      );
      await tester.enterText(find.byType(TextField), 'vitalik.eth');
      await tester.tap(find.text('Fetch balance'));
      await tester.pumpAndSettle();
      expect(find.text('Not a valid Ethereum address.'), findsOneWidget);
      expect(calls, 0);
    });
  });
}
