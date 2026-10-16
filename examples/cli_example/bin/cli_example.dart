import 'dart:async';

import 'package:cli_example/weth.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

/// A well-known, long-deployed contract to demo `call`/`multicall` against:
/// WETH9 on Ethereum mainnet.
const String _wethAddress = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2';

Future<void> main(List<String> args) async {
  final rpcUrl = args.isNotEmpty ? args.first : mainnet.rpcUrls.first;
  final client = createPublicClient(
    transport: HttpTransport(Uri.parse(rpcUrl)),
    chain: mainnet,
  );

  print('Connected to ${mainnet.name} via $rpcUrl\n');

  await _demoBalance(client);
  await _demoCall(client);
  await _demoMulticall(client);
  await _demoGeneratedContract(client);
  await _demoWatchBlocks(client);
}

/// `getBalance` — reads a single account's native-currency balance.
Future<void> _demoBalance(PublicClient client) async {
  const vitalikAddress = '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045';
  final balance = await client.getBalance(vitalikAddress);
  print('[getBalance] $vitalikAddress: ${formatEther(balance)} ETH');
}

/// `call` — a raw `eth_call` against WETH9's `totalSupply()`.
Future<void> _demoCall(PublicClient client) async {
  final totalSupplyFn =
      parseAbiItem('function totalSupply() view returns (uint256)')
          as AbiFunction;
  final result = await client.call(
    to: _wethAddress,
    data: bytesToHex(encodeFunctionData(totalSupplyFn, const [])),
  );
  final totalSupply =
      decodeFunctionResult(totalSupplyFn, hexToBytes(result)).single as BigInt;
  print('[call] WETH totalSupply: ${formatEther(totalSupply)} WETH');
}

/// `multicall` — batches WETH9's `name`/`symbol`/`decimals` into one
/// `eth_call` via Multicall3.
Future<void> _demoMulticall(PublicClient client) async {
  final nameFn =
      parseAbiItem('function name() view returns (string)') as AbiFunction;
  final symbolFn =
      parseAbiItem('function symbol() view returns (string)') as AbiFunction;
  final decimalsFn =
      parseAbiItem('function decimals() view returns (uint8)') as AbiFunction;

  final results = await client.multicall(
    calls: [
      (address: _wethAddress, abi: nameFn, args: const [], allowFailure: false),
      (
        address: _wethAddress,
        abi: symbolFn,
        args: const [],
        allowFailure: false,
      ),
      (
        address: _wethAddress,
        abi: decimalsFn,
        args: const [],
        allowFailure: false,
      ),
    ],
  );

  final name = results[0].result;
  final symbol = results[1].result;
  final decimals = results[2].result;
  print('[multicall] WETH: name=$name symbol=$symbol decimals=$decimals');
}

/// The end-to-end proof of contract code generation: calls
/// real read methods and fetches real past events through `WethContract`
/// (`lib/weth.g.dart`, generated from `lib/weth.dart`'s `@GenerateAbi`
/// annotation by `viem_dart_builders`) instead of the
/// runtime, string-keyed ABI calls the demos above use.
Future<void> _demoGeneratedContract(PublicClient client) async {
  final weth = WethContract(client: client, address: _wethAddress);

  final name = await weth.name();
  final symbol = await weth.symbol();
  final decimals = await weth.decimals();
  print('[generated] WETH: name=$name symbol=$symbol decimals=$decimals');

  const vitalikAddress = '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045';
  final balance = await weth.balanceOf(owner: vitalikAddress);
  print('[generated] WETH balanceOf($vitalikAddress): $balance wei');

  final latestBlock = await client.getBlockNumber();
  final transfers = await weth.getTransferEvents(
    fromBlockNumber: latestBlock - BigInt.from(5),
    toBlockNumber: latestBlock,
  );
  print(
    '[generated] ${transfers.length} typed Transfer event(s) in the last 5 blocks',
  );
  for (final transfer in transfers.take(3)) {
    print('[generated]   $transfer');
  }
}

/// `watchBlocks` — polls for new blocks and prints the first 3, then stops.
Future<void> _demoWatchBlocks(PublicClient client) async {
  print('[watchBlocks] waiting for up to 3 new blocks...');
  var seen = 0;
  await for (final block in client.watchBlocks()) {
    seen++;
    print('[watchBlocks] block #${block.number}: ${block.hash}');
    if (seen >= 3) break;
  }
}
