import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

import '../constants/theme.dart';

/// A vitalik.eth-owned address, used as the default so there's something to
/// look up on first load.
const String _defaultAddress = '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045';

enum _Status { idle, loading, success, error }

/// Reads a live ETH balance via viem_dart's [PublicClient.getBalance] over
/// a plain HTTP transport — proves viem_dart runs correctly once compiled
/// to JS/Wasm and executed in the browser.
class BalanceLookup extends StatefulComponent {
  const BalanceLookup({super.key});

  @override
  State<BalanceLookup> createState() => BalanceLookupState();
}

class BalanceLookupState extends State<BalanceLookup> {
  final PublicClient _client = createPublicClient(
    transport: HttpTransport(
      Uri.parse('https://ethereum-rpc.publicnode.com'),
    ),
    chain: mainnet,
  );

  String _address = _defaultAddress;
  _Status _status = _Status.idle;
  String? _result;
  String? _error;

  Future<void> _fetch() async {
    if (!isAddress(_address)) {
      setState(() {
        _status = _Status.error;
        _error = 'Not a valid Ethereum address.';
      });
      return;
    }
    setState(() {
      _status = _Status.loading;
      _error = null;
    });
    try {
      final balance = await _client.getBalance(_address);
      setState(() {
        _status = _Status.success;
        _result = '${formatEther(balance)} ETH';
      });
    } on ViemError catch (e) {
      setState(() {
        _status = _Status.error;
        _error = e.shortMessage;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'balance-lookup', [
      h2([.text('viem_dart: ETH Balance')]),
      p([
        .text(
          "Reads a live balance via viem_dart's Client.getBalance — "
          'compiled to JS/Wasm with zero reachable dart:io.',
        ),
      ]),
      div(classes: 'balance-form', [
        input<String>(
          value: _address,
          onInput: (v) => setState(() => _address = v),
        ),
        button(onClick: _fetch, [.text('Fetch balance')]),
      ]),
      div(classes: 'balance-result', [
        switch (_status) {
          _Status.idle => .text(''),
          _Status.loading => .text('Loading…'),
          _Status.success => .text(_result!),
          _Status.error => .text(_error!),
        },
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.balance-lookup', [
      css('&').styles(maxWidth: 500.px),
      css('.balance-form', [
        css('&').styles(
          display: .flex,
          padding: .symmetric(vertical: 10.px),
          gap: Gap.all(8.px),
        ),
        css('input').styles(flex: const Flex(grow: 1)),
      ]),
      css('.balance-result').styles(
        minHeight: 2.rem,
        color: primaryColor,
        fontSize: 1.5.rem,
      ),
    ]),
  ];
}
