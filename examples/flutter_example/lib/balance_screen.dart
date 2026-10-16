import 'package:flutter/material.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

/// A vitalik.eth-owned address, used as the default so the screen has
/// something to look up on first load.
const String defaultBalanceAddress =
    '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045';

/// Demos viem_dart end to end: a text field for an address and a live
/// `eth_getBalance` lookup on submit, via [PublicClient.getBalance] over a
/// plain HTTP transport.
///
/// Pass [client] to read from another node (the tests pass one backed by a
/// fake transport); by default it reads from a public Ethereum mainnet RPC.
class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key, this.client});

  final PublicClient? client;

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

enum _Status { idle, loading, success, error }

class _BalanceScreenState extends State<BalanceScreen> {
  late final PublicClient _client =
      widget.client ??
      createPublicClient(
        transport: HttpTransport(
          Uri.parse('https://ethereum-rpc.publicnode.com'),
        ),
        chain: mainnet,
      );
  final _address = TextEditingController(text: defaultBalanceAddress);

  _Status _status = _Status.idle;
  BigInt? _balanceWei;
  String? _error;

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  Future<void> _fetchBalance() async {
    final address = _address.text.trim();
    if (!isAddress(address)) {
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
      final balance = await _client.getBalance(address);
      if (!mounted) return;
      setState(() {
        _status = _Status.success;
        _balanceWei = balance;
      });
    } on ViemError catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _Status.error;
        _error = e.shortMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('ETH Balance', style: theme.textTheme.headlineLarge),
        const SizedBox(height: 12),
        Text(
          "Reads a live balance via viem_dart's PublicClient.getBalance over a "
          'plain HTTP transport.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _address,
          decoration: const InputDecoration(
            labelText: 'Address',
            hintText: '0x...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _fetchBalance(),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: _status == _Status.loading ? null : _fetchBalance,
            icon: const Icon(Icons.search),
            label: const Text('Fetch balance'),
          ),
        ),
        const SizedBox(height: 24),
        switch (_status) {
          _Status.idle => const SizedBox.shrink(),
          _Status.loading => const Center(child: CircularProgressIndicator()),
          _Status.success => Text(
            '${formatEther(_balanceWei ?? BigInt.zero)} ETH',
            style: theme.textTheme.displaySmall,
          ),
          _Status.error => Card(
            color: theme.colorScheme.errorContainer,
            child: ListTile(
              leading: Icon(
                Icons.error_outline,
                color: theme.colorScheme.onErrorContainer,
              ),
              title: const Text('Could not fetch balance'),
              subtitle: Text(_error ?? 'Unknown error.'),
            ),
          ),
        },
      ],
    );
  }
}
