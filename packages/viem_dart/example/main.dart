// A minimal usage example — see the `examples/` directory in the
// repository root (cli_example/flutter_example/jaspr_example) for fuller,
// runnable apps.
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

Future<void> main() async {
  final client = createPublicClient(
    transport: HttpTransport(Uri.parse('https://ethereum-rpc.publicnode.com')),
    chain: mainnet,
  );

  const vitalikAddress = '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045';
  final balance = await client.getBalance(vitalikAddress);
  print('${formatEther(balance)} ETH');
}
