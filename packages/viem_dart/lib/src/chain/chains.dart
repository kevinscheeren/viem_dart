// Chain definitions for ~700 EVM-compatible chains.
//
// These are mechanically ported from viem's own chain definitions
// (https://github.com/wevm/viem, MIT License, `src/chains/definitions/`).
// See `ATTRIBUTION.md` in this directory for details on what was and was
// not carried over from viem's richer per-chain data.
//
// This file is generated — do not hand-edit individual chain entries.
// Regenerate by re-running the extraction against viem's
// `src/chains/definitions/` directory and re-running `dart format`.

import 'chain.dart';

/// ABEY Mainnet (chain id 179).
final Chain abey = Chain(
  id: 179,
  name: 'ABEY Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ABEY',
    symbol: 'ABEY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.abeychain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Abey Scan',
    url: 'https://abeyscan.com',
  ),
);

/// Abstract (chain id 2741).
final Chain abstract = Chain(
  id: 2741,
  name: 'Abstract',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.mainnet.abs.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://abscan.org',
  ),
  contracts: const {
    'erc6492Verifier': ChainContract(
      address: '0xfB688330379976DA81eB64Fe4BF50d7401763B9C',
      blockCreated: 5263,
    ),
    'multicall3': ChainContract(
      address: '0xAa4De41dba0Ca5dCBb288b7cC6b708F3aaC759E7',
      blockCreated: 5288,
    ),
  },
);

/// Abstract Testnet (chain id 11124).
final Chain abstractTestnet = Chain(
  id: 11124,
  name: 'Abstract Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.testnet.abs.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://sepolia.abscan.org',
  ),
  contracts: const {
    'erc6492Verifier': ChainContract(
      address: '0xfB688330379976DA81eB64Fe4BF50d7401763B9C',
      blockCreated: 431682,
    ),
    'multicall3': ChainContract(
      address: '0xF9cda624FBC7e059355ce98a31693d299FACd963',
      blockCreated: 358349,
    ),
  },
);

/// Acala (chain id 787).
final Chain acala = Chain(
  id: 787,
  name: 'Acala',
  nativeCurrency: const NativeCurrency(
    name: 'Acala',
    symbol: 'ACA',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc-acala.aca-api.network'],
  blockExplorer: const BlockExplorer(
    name: 'Acala Blockscout',
    url: 'https://blockscout.acala.network',
  ),
);

/// Acria IntelliChain (chain id 47).
final Chain acria = Chain(
  id: 47,
  name: 'Acria IntelliChain',
  nativeCurrency: const NativeCurrency(
    name: 'ACRIA',
    symbol: 'ACRIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://aic.acria.ai'],
  blockExplorer: const BlockExplorer(
    name: 'Acria Explorer',
    url: 'https://explorer.acria.ai',
  ),
);

/// ADF Chain (chain id 1215).
final Chain adf = Chain(
  id: 1215,
  name: 'ADF Chain',
  nativeCurrency: const NativeCurrency(
    name: 'ADDFILL',
    symbol: 'ADF',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.adftechnology.com'],
  blockExplorer: const BlockExplorer(
    name: 'ADF Mainnet Explorer',
    url: 'https://explorer.adftechnology.com',
  ),
);

/// ADI_Chain (chain id 36900).
final Chain adi = Chain(
  id: 36900,
  name: 'ADI_Chain',
  nativeCurrency: const NativeCurrency(
    name: 'ADI',
    symbol: 'ADI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.adifoundation.ai'],
  blockExplorer: const BlockExplorer(
    name: 'ADI Explorer',
    url: 'https://explorer.adifoundation.ai',
  ),
);

/// Agung Network (chain id 9990).
final Chain agungTestnet = Chain(
  id: 9990,
  name: 'Agung Network',
  nativeCurrency: const NativeCurrency(
    name: 'Agung',
    symbol: 'AGNG',
    decimals: 18,
  ),
  rpcUrls: const ['https://wss-async.agung.peaq.network'],
  blockExplorer: const BlockExplorer(
    name: 'Subscan',
    url: 'https://agung-testnet.subscan.io',
  ),
);

/// AIOZ Network (chain id 168).
final Chain aioz = Chain(
  id: 168,
  name: 'AIOZ Network',
  nativeCurrency: const NativeCurrency(
    name: 'AIOZ',
    symbol: 'AIOZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-dataseed.aioz.network'],
  blockExplorer: const BlockExplorer(
    name: 'AIOZ Explorer',
    url: 'https://explorer.aioz.network',
  ),
);

/// Aleph Zero (chain id 41455).
final Chain alephZero = Chain(
  id: 41455,
  name: 'Aleph Zero',
  nativeCurrency: const NativeCurrency(
    name: 'Aleph Zero',
    symbol: 'AZERO',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.alephzero.raas.gelato.cloud'],
  blockExplorer: const BlockExplorer(
    name: 'Aleph Zero EVM Explorer',
    url: 'https://evm-explorer.alephzero.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 4603377,
    ),
  },
);

/// Aleph Zero Testnet (chain id 2039).
final Chain alephZeroTestnet = Chain(
  id: 2039,
  name: 'Aleph Zero Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'TZERO',
    symbol: 'TZERO',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.alephzero-testnet.gelato.digital'],
  blockExplorer: const BlockExplorer(
    name: 'Aleph Zero EVM Testnet explorer',
    url: 'https://evm-explorer-testnet.alephzero.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 2861745,
    ),
  },
);

/// AlienX Mainnet (chain id 10241024).
final Chain alienx = Chain(
  id: 10241024,
  name: 'AlienX Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.alienxchain.io/http'],
  blockExplorer: const BlockExplorer(
    name: 'AlienX Explorer',
    url: 'https://explorer.alienxchain.io',
  ),
);

/// ALIENX Hal Testnet (chain id 10241025).
final Chain alienxHalTestnet = Chain(
  id: 10241025,
  name: 'ALIENX Hal Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://hal-rpc.alienxchain.io/http'],
  blockExplorer: const BlockExplorer(
    name: 'AlienX Explorer',
    url: 'https://hal-explorer.alienxchain.io',
  ),
);

/// Alpen Testnet (chain id 8150).
final Chain alpenTestnet = Chain(
  id: 8150,
  name: 'Alpen Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Signet BTC',
    symbol: 'sBTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.alpenlabs.io'],
  blockExplorer: const BlockExplorer(
    name: 'Alpen Explorer',
    url: 'https://explorer.testnet.alpenlabs.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 290408,
    ),
  },
);

/// Ancient8 (chain id 888888888).
final Chain ancient8 = Chain(
  id: 888888888,
  name: 'Ancient8',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.ancient8.gg'],
  blockExplorer: const BlockExplorer(
    name: 'Ancient8 explorer',
    url: 'https://scan.ancient8.gg',
  ),
);

/// Ancient8 Testnet (chain id 28122024).
final Chain ancient8Sepolia = Chain(
  id: 28122024,
  name: 'Ancient8 Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpcv2-testnet.ancient8.gg'],
  blockExplorer: const BlockExplorer(
    name: 'Ancient8 Celestia Testnet explorer',
    url: 'https://scanv2-testnet.ancient8.gg',
  ),
);

/// Anvil (chain id 31337).
final Chain anvil = Chain(
  id: 31337,
  name: 'Anvil',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://127.0.0.1:8545'],
);

/// ApeChain (chain id 33139).
final Chain apeChain = Chain(
  id: 33139,
  name: 'ApeChain',
  nativeCurrency: const NativeCurrency(
    name: 'ApeCoin',
    symbol: 'APE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.apechain.com/http'],
  blockExplorer: const BlockExplorer(
    name: 'Apescan',
    url: 'https://apescan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 20889,
    ),
  },
);

/// APEX Testnet (chain id 3993).
final Chain apexTestnet = Chain(
  id: 3993,
  name: 'APEX Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.apexlayer.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://exp-testnet.apexlayer.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xf7642be33a6b18D16a995657adb5a68CD0438aE2',
      blockCreated: 283775,
    ),
  },
);

/// Apollo (chain id 62606).
final Chain apollo = Chain(
  id: 62606,
  name: 'Apollo',
  nativeCurrency: const NativeCurrency(
    name: 'Apollo',
    symbol: 'APOLLO',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.apolloscan.io'],
  blockExplorer: const BlockExplorer(
    name: 'Apollo Explorer',
    url: 'https://apolloscan.io',
  ),
);

/// Arbitrum One (chain id 42161).
final Chain arbitrum = Chain(
  id: 42161,
  name: 'Arbitrum One',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://arb1.arbitrum.io/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Arbiscan',
    url: 'https://arbiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 7654707,
    ),
  },
);

/// Arbitrum Goerli (chain id 421613).
final Chain arbitrumGoerli = Chain(
  id: 421613,
  name: 'Arbitrum Goerli',
  nativeCurrency: const NativeCurrency(
    name: 'Arbitrum Goerli Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://goerli-rollup.arbitrum.io/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Arbiscan',
    url: 'https://goerli.arbiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 88114,
    ),
  },
);

/// Arbitrum Nova (chain id 42170).
final Chain arbitrumNova = Chain(
  id: 42170,
  name: 'Arbitrum Nova',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://nova.arbitrum.io/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Arbiscan',
    url: 'https://nova.arbiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1746963,
    ),
  },
);

/// Arbitrum Sepolia (chain id 421614).
final Chain arbitrumSepolia = Chain(
  id: 421614,
  name: 'Arbitrum Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Arbitrum Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia-rollup.arbitrum.io/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Arbiscan',
    url: 'https://sepolia.arbiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 81930,
    ),
  },
);

/// Arc (chain id 5042).
final Chain arc = Chain(
  id: 5042,
  name: 'Arc',
  nativeCurrency: const NativeCurrency(
    name: 'USDC',
    symbol: 'USDC',
    decimals: 18,
  ),
  rpcUrls: const [],
);

/// Arc Testnet (chain id 5042002).
final Chain arcTestnet = Chain(
  id: 5042002,
  name: 'Arc Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'USDC',
    symbol: 'USDC',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc.testnet.arc.network',
    'https://rpc.quicknode.testnet.arc.network',
    'https://rpc.blockdaemon.testnet.arc.network',
  ],
  blockExplorer: const BlockExplorer(
    name: 'ArcScan',
    url: 'https://testnet.arcscan.app',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Arena-Z (chain id 7897).
final Chain arenaz = Chain(
  id: 7897,
  name: 'Arena-Z',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.arena-z.gg'],
  blockExplorer: const BlockExplorer(
    name: 'Arena-Z Explorer',
    url: 'https://explorer.arena-z.gg',
  ),
);

/// Areon Network (chain id 463).
final Chain areonNetwork = Chain(
  id: 463,
  name: 'Areon Network',
  nativeCurrency: const NativeCurrency(
    name: 'AREA',
    symbol: 'AREA',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.areon.network'],
  blockExplorer: const BlockExplorer(
    name: 'Areonscan',
    url: 'https://areonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 353286,
    ),
  },
);

/// Areon Network Testnet (chain id 462).
final Chain areonNetworkTestnet = Chain(
  id: 462,
  name: 'Areon Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'TAREA',
    symbol: 'TAREA',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.areon.network'],
  blockExplorer: const BlockExplorer(
    name: 'Areonscan',
    url: 'https://areonscan.com',
  ),
);

/// Areum (chain id 463).
final Chain areum = Chain(
  id: 463,
  name: 'Areum',
  nativeCurrency: const NativeCurrency(
    name: 'AREA',
    symbol: 'AREA',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.areum.network'],
  blockExplorer: const BlockExplorer(
    name: 'Areum Explorer',
    url: 'https://explorer.areum.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 353286,
    ),
  },
);

/// Artela Testnet (chain id 11822).
final Chain artelaTestnet = Chain(
  id: 11822,
  name: 'Artela Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ART',
    symbol: 'ART',
    decimals: 18,
  ),
  rpcUrls: const ['https://betanet-rpc1.artela.network'],
  blockExplorer: const BlockExplorer(
    name: 'Artela',
    url: 'https://betanet-scan.artela.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xd07c8635f76e8745Ee7092fbb6e8fbc5FeF09DD7',
      blockCreated: 7001871,
    ),
  },
);

/// Arthera (chain id 10242).
final Chain arthera = Chain(
  id: 10242,
  name: 'Arthera',
  nativeCurrency: const NativeCurrency(
    name: 'Arthera',
    symbol: 'AA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.arthera.net'],
  blockExplorer: const BlockExplorer(
    name: 'Arthera EVM Explorer',
    url: 'https://explorer.arthera.net',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 4502791,
    ),
  },
);

/// Arthera Testnet (chain id 10243).
final Chain artheraTestnet = Chain(
  id: 10243,
  name: 'Arthera Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Arthera',
    symbol: 'AA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-test.arthera.net'],
  blockExplorer: const BlockExplorer(
    name: 'Arthera EVM Explorer',
    url: 'https://explorer-test.arthera.net',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 22051,
    ),
  },
);

/// AssetChain Mainnet (chain id 42420).
final Chain assetChain = Chain(
  id: 42420,
  name: 'AssetChain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Real World Asset',
    symbol: 'RWA',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.assetchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'Asset Chain Explorer',
    url: 'https://scan.assetchain.org',
  ),
);

/// AssetChain Testnet (chain id 42421).
final Chain assetChainTestnet = Chain(
  id: 42421,
  name: 'AssetChain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Real World Asset',
    symbol: 'RWA',
    decimals: 18,
  ),
  rpcUrls: const ['https://enugu-rpc.assetchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'Asset Chain Testnet Explorer',
    url: 'https://scan-testnet.assetchain.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x989F832D35988cb5e3eB001Fa2Fe789469EC31Ea',
      blockCreated: 17177,
    ),
  },
);

/// Astar (chain id 592).
final Chain astar = Chain(
  id: 592,
  name: 'Astar',
  nativeCurrency: const NativeCurrency(
    name: 'Astar',
    symbol: 'ASTR',
    decimals: 18,
  ),
  rpcUrls: const ['https://astar.api.onfinality.io/public'],
  blockExplorer: const BlockExplorer(
    name: 'Astar Subscan',
    url: 'https://astar.subscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 761794,
    ),
  },
);

/// Astar zkEVM (chain id 3776).
final Chain astarZkEVM = Chain(
  id: 3776,
  name: 'Astar zkEVM',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-zkevm.astar.network'],
  blockExplorer: const BlockExplorer(
    name: 'Astar zkEVM Explorer',
    url: 'https://astar-zkevm.explorer.startale.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 93528,
    ),
  },
);

/// Astar zkEVM Testnet zKyoto (chain id 6038361).
final Chain astarZkyoto = Chain(
  id: 6038361,
  name: 'Astar zkEVM Testnet zKyoto',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.startale.com/zkyoto'],
  blockExplorer: const BlockExplorer(
    name: 'zKyoto Explorer',
    url: 'https://zkyoto.explorer.startale.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 196153,
    ),
  },
);

/// Atleta Olympia (chain id 2340).
final Chain atletaOlympia = Chain(
  id: 2340,
  name: 'Atleta Olympia',
  nativeCurrency: const NativeCurrency(
    name: 'Atla',
    symbol: 'ATLA',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://testnet-rpc.atleta.network:9944',
    'https://testnet-rpc.atleta.network',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Atleta Olympia Explorer',
    url: 'https://blockscout.atleta.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x1472ec6392180fb84F345d2455bCC75B26577115',
      blockCreated: 1076473,
    ),
  },
);

/// Aurora (chain id 1313161554).
final Chain aurora = Chain(
  id: 1313161554,
  name: 'Aurora',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.aurora.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Aurorascan',
    url: 'https://aurorascan.dev',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 62907816,
    ),
  },
);

/// Aurora Testnet (chain id 1313161555).
final Chain auroraTestnet = Chain(
  id: 1313161555,
  name: 'Aurora Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.aurora.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Aurorascan',
    url: 'https://testnet.aurorascan.dev',
  ),
);

/// Auroria Testnet (chain id 205205).
final Chain auroria = Chain(
  id: 205205,
  name: 'Auroria Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Auroria Stratis',
    symbol: 'tSTRAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://auroria.rpc.stratisevm.com'],
  blockExplorer: const BlockExplorer(
    name: 'Auroria Testnet Explorer',
    url: 'https://auroria.explorer.stratisevm.com',
  ),
);

/// Autheo Testnet (chain id 785).
final Chain autheoTestnet = Chain(
  id: 785,
  name: 'Autheo Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Autheo',
    symbol: 'THEO',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://testnet-rpc1.autheo.com',
    'https://testnet-rpc2.autheo.com',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Autheo Testnet Block Explorer',
    url: 'https://testnet-explorer.autheo.com/',
  ),
);

/// Avalanche (chain id 43114).
final Chain avalanche = Chain(
  id: 43114,
  name: 'Avalanche',
  nativeCurrency: const NativeCurrency(
    name: 'Avalanche',
    symbol: 'AVAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.avax.network/ext/bc/C/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'SnowTrace',
    url: 'https://snowtrace.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 11907934,
    ),
  },
);

/// Avalanche Fuji (chain id 43113).
final Chain avalancheFuji = Chain(
  id: 43113,
  name: 'Avalanche Fuji',
  nativeCurrency: const NativeCurrency(
    name: 'Avalanche Fuji',
    symbol: 'AVAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.avax-test.network/ext/bc/C/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'SnowTrace',
    url: 'https://testnet.snowtrace.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 7096959,
    ),
  },
);

/// B3 (chain id 8333).
final Chain b3 = Chain(
  id: 8333,
  name: 'B3',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.b3.fun/http'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.b3.fun',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// B3 Sepolia (chain id 1993).
final Chain b3Sepolia = Chain(
  id: 1993,
  name: 'B3 Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.b3.fun/http'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://sepolia.explorer.b3.fun',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// Bahamut (chain id 5165).
final Chain bahamut = Chain(
  id: 5165,
  name: 'Bahamut',
  nativeCurrency: const NativeCurrency(
    name: 'Fasttoken',
    symbol: 'FTN',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc1.bahamut.io',
    'https://bahamut-rpc.publicnode.com',
    'https://rpc2.bahamut.io',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Ftnscan',
    url: 'https://www.ftnscan.com',
  ),
);

/// Base (chain id 8453).
final Chain base = Chain(
  id: 8453,
  name: 'Base',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.base.org'],
  blockExplorer: const BlockExplorer(
    name: 'Basescan',
    url: 'https://basescan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 5022,
    ),
  },
);

/// Base Goerli (chain id 84531).
final Chain baseGoerli = Chain(
  id: 84531,
  name: 'Base Goerli',
  nativeCurrency: const NativeCurrency(
    name: 'Goerli Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://goerli.base.org'],
  blockExplorer: const BlockExplorer(
    name: 'Basescan',
    url: 'https://goerli.basescan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1376988,
    ),
  },
);

/// Base Sepolia (chain id 84532).
final Chain baseSepolia = Chain(
  id: 84532,
  name: 'Base Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.base.org'],
  blockExplorer: const BlockExplorer(
    name: 'Basescan',
    url: 'https://sepolia.basescan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1059647,
    ),
  },
);

/// Basecamp Testnet (chain id 123420001114).
final Chain basecampTestnet = Chain(
  id: 123420001114,
  name: 'Basecamp Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Camp',
    symbol: 'CAMP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.basecamp.t.raas.gelato.cloud'],
  blockExplorer: const BlockExplorer(
    name: 'basecamp',
    url: 'https://basecamp.cloud.blockscout.com',
  ),
);

/// BattleChain Mainnet (chain id 626).
final Chain battlechain = Chain(
  id: 626,
  name: 'BattleChain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.battlechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'BattleChain Explorer',
    url: 'https://explorer.battlechain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 40,
    ),
  },
);

/// BattleChain Testnet (chain id 627).
final Chain battlechainTestnet = Chain(
  id: 627,
  name: 'BattleChain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.battlechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'BattleChain Explorer',
    url: 'https://explorer.testnet.battlechain.com',
  ),
);

/// Beam (chain id 4337).
final Chain beam = Chain(
  id: 4337,
  name: 'Beam',
  nativeCurrency: const NativeCurrency(
    name: 'Beam',
    symbol: 'BEAM',
    decimals: 18,
  ),
  rpcUrls: const ['https://build.onbeam.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Beam Explorer',
    url: 'https://subnets.avax.network/beam',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x4956f15efdc3dc16645e90cc356eafa65ffc65ec',
      blockCreated: 1,
    ),
  },
);

/// Beam Testnet (chain id 13337).
final Chain beamTestnet = Chain(
  id: 13337,
  name: 'Beam Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Beam',
    symbol: 'BEAM',
    decimals: 18,
  ),
  rpcUrls: const ['https://build.onbeam.com/rpc/testnet'],
  blockExplorer: const BlockExplorer(
    name: 'Beam Explorer',
    url: 'https://subnets-test.avax.network/beam',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x9bf49b704ee2a095b95c1f2d4eb9010510c41c9e',
      blockCreated: 3,
    ),
  },
);

/// Bear Network Chain Mainnet (chain id 641230).
final Chain bearNetworkChainMainnet = Chain(
  id: 641230,
  name: 'Bear Network Chain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BearNetworkChain',
    symbol: 'BRNKC',
    decimals: 18,
  ),
  rpcUrls: const ['https://brnkc-mainnet.bearnetwork.net'],
  blockExplorer: const BlockExplorer(
    name: 'BrnkScan',
    url: 'https://brnkscan.bearnetwork.net',
  ),
);

/// Bear Network Chain Testnet (chain id 751230).
final Chain bearNetworkChainTestnet = Chain(
  id: 751230,
  name: 'Bear Network Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tBRNKC',
    symbol: 'tBRNKC',
    decimals: 18,
  ),
  rpcUrls: const ['https://brnkc-test.bearnetwork.net'],
  blockExplorer: const BlockExplorer(
    name: 'BrnkTestScan',
    url: 'https://brnktest-scan.bearnetwork.net',
  ),
);

/// Berachain (chain id 80094).
final Chain berachain = Chain(
  id: 80094,
  name: 'Berachain',
  nativeCurrency: const NativeCurrency(
    name: 'BERA Token',
    symbol: 'BERA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.berachain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Berascan',
    url: 'https://berascan.com',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x5b22280886a2f5e09a49bea7e320eab0e5320e28',
      blockCreated: 877007,
    ),
    'ensUniversalResolver': ChainContract(
      address: '0x4D41762915F83c76EcaF6776d9b08076aA32b492',
      blockCreated: 9310021,
    ),
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Berachain Bepolia (chain id 80069).
final Chain berachainBepolia = Chain(
  id: 80069,
  name: 'Berachain Bepolia',
  nativeCurrency: const NativeCurrency(
    name: 'BERA Token',
    symbol: 'BERA',
    decimals: 18,
  ),
  rpcUrls: const ['https://bepolia.rpc.berachain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Berascan',
    url: 'https://bepolia.beratrail.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Berachain Artio (chain id 80085).
final Chain berachainTestnet = Chain(
  id: 80085,
  name: 'Berachain Artio',
  nativeCurrency: const NativeCurrency(
    name: 'BERA Token',
    symbol: 'BERA',
    decimals: 18,
  ),
  rpcUrls: const ['https://artio.rpc.berachain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Berachain',
    url: 'https://artio.beratrail.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 866924,
    ),
  },
);

/// Berachain bArtio (chain id 80084).
final Chain berachainTestnetbArtio = Chain(
  id: 80084,
  name: 'Berachain bArtio',
  nativeCurrency: const NativeCurrency(
    name: 'BERA Token',
    symbol: 'BERA',
    decimals: 18,
  ),
  rpcUrls: const ['https://bartio.rpc.berachain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Berachain bArtio Beratrail',
    url: 'https://bartio.beratrail.io',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0xB0eef18971290b333450586D33dcA6cE122651D2',
      blockCreated: 7736794,
    ),
    'ensUniversalResolver': ChainContract(
      address: '0x41692Ef1EA0C79E6b73077E4A67572D2BDbD7057',
      blockCreated: 7736795,
    ),
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 109269,
    ),
  },
);

/// BEVM Mainnet (chain id 11501).
final Chain bevmMainnet = Chain(
  id: 11501,
  name: 'BEVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-mainnet-1.bevm.io'],
  blockExplorer: const BlockExplorer(
    name: 'Bevmscan',
    url: 'https://scan-mainnet.bevm.io',
  ),
);

/// Bifrost Mainnet (chain id 3068).
final Chain bifrost = Chain(
  id: 3068,
  name: 'Bifrost Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BFC',
    symbol: 'BFC',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-01.mainnet.bifrostnetwork.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Bifrost Blockscout',
    url: 'https://explorer.mainnet.bifrostnetwork.com',
  ),
);

/// BirdLayer (chain id 53456).
final Chain birdlayer = Chain(
  id: 53456,
  name: 'BirdLayer',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.birdlayer.xyz', 'https://rpc1.birdlayer.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'BirdLayer Explorer',
    url: 'https://scan.birdlayer.xyz',
  ),
);

/// BitTorrent (chain id 199).
final Chain bitTorrent = Chain(
  id: 199,
  name: 'BitTorrent',
  nativeCurrency: const NativeCurrency(
    name: 'BitTorrent',
    symbol: 'BTT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.bittorrentchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Bttcscan',
    url: 'https://bttcscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 31078552,
    ),
  },
);

/// BitTorrent Chain Testnet (chain id 1028).
final Chain bitTorrentTestnet = Chain(
  id: 1028,
  name: 'BitTorrent Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BitTorrent',
    symbol: 'BTT',
    decimals: 18,
  ),
  rpcUrls: const ['https://testrpc.bittorrentchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Bttcscan',
    url: 'https://testnet.bttcscan.com',
  ),
);

/// Bitgert Mainnet (chain id 32520).
final Chain bitgert = Chain(
  id: 32520,
  name: 'Bitgert Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Brise',
    symbol: 'Brise',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-bitgert.icecreamswap.com'],
  blockExplorer: const BlockExplorer(
    name: 'Bitgert Scan',
    url: 'https://brisescan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2118034,
    ),
  },
);

/// KUB Mainnet (chain id 96).
final Chain bitkub = Chain(
  id: 96,
  name: 'KUB Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'KUB Coin',
    symbol: 'KUB',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.bitkubchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'KUB Chain Mainnet Explorer',
    url: 'https://www.bkcscan.com',
  ),
);

/// Bitkub Testnet (chain id 25925).
final Chain bitkubTestnet = Chain(
  id: 25925,
  name: 'Bitkub Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitkub Test',
    symbol: 'tKUB',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.bitkubchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Bitkub Chain Testnet Explorer',
    url: 'https://testnet.bkcscan.com',
  ),
);

/// Bitlayer Mainnet (chain id 200901).
final Chain bitlayer = Chain(
  id: 200901,
  name: 'Bitlayer Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.bitlayer.org'],
  blockExplorer: const BlockExplorer(
    name: 'bitlayer mainnet scan',
    url: 'https://www.btrscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x5B256fE9e993902eCe49D138a5b1162cBb529474',
      blockCreated: 2421963,
    ),
  },
);

/// Bitlayer Testnet (chain id 200810).
final Chain bitlayerTestnet = Chain(
  id: 200810,
  name: 'Bitlayer Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.bitlayer.org'],
  blockExplorer: const BlockExplorer(
    name: 'bitlayer testnet scan',
    url: 'https://testnet.btrscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x5B256fE9e993902eCe49D138a5b1162cBb529474',
      blockCreated: 4135671,
    ),
  },
);

/// Bitrock Mainnet (chain id 7171).
final Chain bitrock = Chain(
  id: 7171,
  name: 'Bitrock Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BROCK',
    symbol: 'BROCK',
    decimals: 18,
  ),
  rpcUrls: const ['https://brockrpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Bitrock Explorer',
    url: 'https://explorer.bit-rock.io',
  ),
);

/// Blast (chain id 81457).
final Chain blast = Chain(
  id: 81457,
  name: 'Blast',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.blast.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blastscan',
    url: 'https://blastscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 212929,
    ),
  },
);

/// Blast Sepolia (chain id 168587773).
final Chain blastSepolia = Chain(
  id: 168587773,
  name: 'Blast Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.blast.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blastscan',
    url: 'https://sepolia.blastscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 756690,
    ),
  },
);

/// BOB (chain id 60808).
final Chain bob = Chain(
  id: 60808,
  name: 'BOB',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.gobob.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'BOB Explorer',
    url: 'https://explorer.gobob.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 23131,
    ),
  },
);

/// BOB Sepolia (chain id 808813).
final Chain bobSepolia = Chain(
  id: 808813,
  name: 'BOB Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://bob-sepolia.rpc.gobob.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'BOB Sepolia Explorer',
    url: 'https://bob-sepolia.explorer.gobob.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 35677,
    ),
  },
);

/// Boba Network (chain id 288).
final Chain boba = Chain(
  id: 288,
  name: 'Boba Network',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.boba.network'],
  blockExplorer: const BlockExplorer(
    name: 'BOBAScan',
    url: 'https://bobascan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 446859,
    ),
  },
);

/// Boba Sepolia (chain id 28882).
final Chain bobaSepolia = Chain(
  id: 28882,
  name: 'Boba Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.boba.network'],
  blockExplorer: const BlockExplorer(
    name: 'BOBAScan',
    url: 'https://testnet.bobascan.com',
  ),
);

/// Bool Beta Mainnet (chain id 11100).
final Chain boolBetaMainnet = Chain(
  id: 11100,
  name: 'Bool Beta Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BOL',
    symbol: 'BOL',
    decimals: 18,
  ),
  rpcUrls: const ['https://beta-rpc-node-http.bool.network'],
  blockExplorer: const BlockExplorer(
    name: 'BoolScan',
    url: 'https://beta-mainnet.boolscan.com/',
  ),
);

/// Botanix (chain id 3637).
final Chain botanix = Chain(
  id: 3637,
  name: 'Botanix',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.botanixlabs.com'],
  blockExplorer: const BlockExplorer(
    name: 'Botanixscan',
    url: 'https://botanixscan.io',
  ),
);

/// Botanix Testnet (chain id 3636).
final Chain botanixTestnet = Chain(
  id: 3636,
  name: 'Botanix Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://node.botanixlabs.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Botanix Testnet Explorer',
    url: 'https://testnet.botanixscan.io',
  ),
);

/// BounceBit Mainnet (chain id 6001).
final Chain bounceBit = Chain(
  id: 6001,
  name: 'BounceBit Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BounceBit',
    symbol: 'BB',
    decimals: 18,
  ),
  rpcUrls: const ['https://fullnode-mainnet.bouncebitapi.com'],
  blockExplorer: const BlockExplorer(name: 'BB Scan', url: 'https://bbscan.io'),
);

/// BounceBit Testnet (chain id 6000).
final Chain bounceBitTestnet = Chain(
  id: 6000,
  name: 'BounceBit Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BounceBit',
    symbol: 'BB',
    decimals: 18,
  ),
  rpcUrls: const ['https://fullnode-testnet.bouncebitapi.com'],
  blockExplorer: const BlockExplorer(
    name: 'BB Scan',
    url: 'https://testnet.bbscan.io',
  ),
);

/// Bronos (chain id 1039).
final Chain bronos = Chain(
  id: 1039,
  name: 'Bronos',
  nativeCurrency: const NativeCurrency(
    name: 'BRO',
    symbol: 'BRO',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.bronos.org'],
  blockExplorer: const BlockExplorer(
    name: 'BronoScan',
    url: 'https://broscan.bronos.org',
  ),
);

/// Bronos Testnet (chain id 1038).
final Chain bronosTestnet = Chain(
  id: 1038,
  name: 'Bronos Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bronos Coin',
    symbol: 'tBRO',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm-testnet.bronos.org'],
  blockExplorer: const BlockExplorer(
    name: 'BronoScan',
    url: 'https://tbroscan.bronos.org',
  ),
);

/// BNB Smart Chain (chain id 56).
final Chain bsc = Chain(
  id: 56,
  name: 'BNB Smart Chain',
  nativeCurrency: const NativeCurrency(
    name: 'BNB',
    symbol: 'BNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://56.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'BscScan',
    url: 'https://bscscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 15921452,
    ),
  },
);

/// BNB Greenfield Chain (chain id 1017).
final Chain bscGreenfield = Chain(
  id: 1017,
  name: 'BNB Greenfield Chain',
  nativeCurrency: const NativeCurrency(
    name: 'BNB',
    symbol: 'BNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://greenfield-chain.bnbchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'BNB Greenfield Mainnet Scan',
    url: 'https://greenfieldscan.com',
  ),
);

/// BNB Smart Chain Testnet (chain id 97).
final Chain bscTestnet = Chain(
  id: 97,
  name: 'BNB Smart Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BNB',
    symbol: 'tBNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://data-seed-prebsc-1-s1.bnbchain.org:8545'],
  blockExplorer: const BlockExplorer(
    name: 'BscScan',
    url: 'https://testnet.bscscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 17422483,
    ),
  },
);

/// B2 (chain id 223).
final Chain bsquared = Chain(
  id: 223,
  name: 'B2',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.bsquared.network'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.bsquared.network',
  ),
);

/// B2 Testnet (chain id 1123).
final Chain bsquaredTestnet = Chain(
  id: 1123,
  name: 'B2 Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.bsquared.network'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://testnet-explorer.bsquared.network',
  ),
);

/// Bitlayer (chain id 200901).
final Chain btr = Chain(
  id: 200901,
  name: 'Bitlayer',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.bitlayer.org', 'https://rpc.bitlayer-rpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'Bitlayer(BTR) Scan',
    url: 'https://www.btrscan.com',
  ),
);

/// Bitlayer Testnet (chain id 200810).
final Chain btrTestnet = Chain(
  id: 200810,
  name: 'Bitlayer Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.bitlayer.org'],
  blockExplorer: const BlockExplorer(
    name: 'Bitlayer(BTR) Scan',
    url: 'https://testnet.btrscan.com',
  ),
);

/// BlackFort Exchange Network (chain id 4999).
final Chain bxn = Chain(
  id: 4999,
  name: 'BlackFort Exchange Network',
  nativeCurrency: const NativeCurrency(
    name: 'BlackFort Token',
    symbol: 'BXN',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.blackfort.network/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.blackfort.network',
  ),
);

/// BlackFort Exchange Network Testnet (chain id 4777).
final Chain bxnTestnet = Chain(
  id: 4777,
  name: 'BlackFort Exchange Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BlackFort Testnet Token',
    symbol: 'TBXN',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.blackfort.network/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://testnet-explorer.blackfort.network',
  ),
);

/// Cannon (chain id 13370).
final Chain cannon = Chain(
  id: 13370,
  name: 'Cannon',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://127.0.0.1:8545'],
);

/// Canto (chain id 7700).
final Chain canto = Chain(
  id: 7700,
  name: 'Canto',
  nativeCurrency: const NativeCurrency(
    name: 'Canto',
    symbol: 'CANTO',
    decimals: 18,
  ),
  rpcUrls: const ['https://canto.gravitychain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Tuber.Build (Blockscout)',
    url: 'https://tuber.build',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 2905789,
    ),
  },
);

/// Celo (chain id 42220).
final Chain celo = Chain(
  id: 42220,
  name: 'Celo',
  nativeCurrency: const NativeCurrency(
    name: 'CELO',
    symbol: 'CELO',
    decimals: 18,
  ),
  rpcUrls: const ['https://forno.celo.org'],
  blockExplorer: const BlockExplorer(
    name: 'Celo Explorer',
    url: 'https://celoscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 13112599,
    ),
  },
);

/// Alfajores (chain id 44787).
final Chain celoAlfajores = Chain(
  id: 44787,
  name: 'Alfajores',
  nativeCurrency: const NativeCurrency(
    name: 'CELO',
    symbol: 'A-CELO',
    decimals: 18,
  ),
  rpcUrls: const ['https://alfajores-forno.celo-testnet.org'],
  blockExplorer: const BlockExplorer(
    name: 'Celo Alfajores Explorer',
    url: 'https://celo-alfajores.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 14569001,
    ),
  },
);

/// Celo Sepolia Testnet (chain id 11142220).
final Chain celoSepolia = Chain(
  id: 11142220,
  name: 'Celo Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'CELO',
    symbol: 'S-CELO',
    decimals: 18,
  ),
  rpcUrls: const ['https://forno.celo-sepolia.celo-testnet.org'],
  blockExplorer: const BlockExplorer(
    name: 'Celo Sepolia Explorer',
    url: 'https://celo-sepolia.blockscout.com/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1,
    ),
  },
);

/// Chang Chain Foundation Mainnet (chain id 5858).
final Chain chang = Chain(
  id: 5858,
  name: 'Chang Chain Foundation Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'CTH',
    symbol: 'CTH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.cthscan.com'],
  blockExplorer: const BlockExplorer(
    name: 'Chang Chain explorer',
    url: 'https://cthscan.com',
  ),
);

/// Chiliz Chain (chain id 88888).
final Chain chiliz = Chain(
  id: 88888,
  name: 'Chiliz Chain',
  nativeCurrency: const NativeCurrency(
    name: 'CHZ',
    symbol: 'CHZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.chiliz.com'],
  blockExplorer: const BlockExplorer(
    name: 'Chiliz Explorer',
    url: 'https://scan.chiliz.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 8080847,
    ),
  },
);

/// Chips Network (chain id 2882).
final Chain chips = Chain(
  id: 2882,
  name: 'Chips Network',
  nativeCurrency: const NativeCurrency(
    name: 'IOTA',
    symbol: 'IOTA',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://node.chips.ooo/wasp/api/v1/chains/iota1pp3d3mnap3ufmgqnjsnw344sqmf5svjh26y2khnmc89sv6788y3r207a8fn/evm',
  ],
);

/// Citrate (chain id 40204).
final Chain citrate = Chain(
  id: 40204,
  name: 'Citrate',
  nativeCurrency: const NativeCurrency(
    name: 'SALT',
    symbol: 'SALT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.citrate.ai'],
);

/// Citrea Mainnet (chain id 4114).
final Chain citrea = Chain(
  id: 4114,
  name: 'Citrea Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Citrea Bitcoin',
    symbol: 'cBTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.citrea.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Citrea Explorer',
    url: 'https://explorer.mainnet.citrea.xyz',
  ),
);

/// Citrea Testnet (chain id 5115).
final Chain citreaTestnet = Chain(
  id: 5115,
  name: 'Citrea Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'cBTC',
    symbol: 'cBTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.citrea.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Citrea Explorer',
    url: 'https://explorer.testnet.citrea.xyz',
  ),
);

/// Ethereum Classic (chain id 61).
final Chain classic = Chain(
  id: 61,
  name: 'Ethereum Classic',
  nativeCurrency: const NativeCurrency(
    name: 'ETC',
    symbol: 'ETC',
    decimals: 18,
  ),
  rpcUrls: const ['https://etc.rivet.link'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout.com/etc/mainnet',
  ),
);

/// Codex (chain id 81224).
final Chain codex = Chain(
  id: 81224,
  name: 'Codex',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.codex.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Codex Explorer',
    url: 'https://explorer.codex.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Codex Testnet (chain id 812242).
final Chain codexTestnet = Chain(
  id: 812242,
  name: 'Codex Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.codex-stg.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Codex Testnet Explorer',
    url: 'https://explorer.codex-stg.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Coinbit Mainnet (chain id 112).
final Chain coinbit = Chain(
  id: 112,
  name: 'Coinbit Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'GIDR',
    symbol: 'GIDR',
    decimals: 18,
  ),
  rpcUrls: const ['https://coinbit-rpc-mainnet.chain.sbcrypto.app'],
  blockExplorer: const BlockExplorer(
    name: 'Coinbit Explorer',
    url: 'https://coinbit-explorer.chain.sbcrypto.app',
  ),
);

/// CoinEx Mainnet (chain id 52).
final Chain coinex = Chain(
  id: 52,
  name: 'CoinEx Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'cet',
    symbol: 'cet',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.coinex.net'],
  blockExplorer: const BlockExplorer(
    name: 'CoinEx Explorer',
    url: 'https://www.coinex.net',
  ),
);

/// Conflux eSpace (chain id 1030).
final Chain confluxESpace = Chain(
  id: 1030,
  name: 'Conflux eSpace',
  nativeCurrency: const NativeCurrency(
    name: 'Conflux',
    symbol: 'CFX',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.confluxrpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'ConfluxScan',
    url: 'https://evm.confluxscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xEFf0078910f638cd81996cc117bccD3eDf2B072F',
      blockCreated: 68602935,
    ),
  },
);

/// Conflux eSpace Testnet (chain id 71).
final Chain confluxESpaceTestnet = Chain(
  id: 71,
  name: 'Conflux eSpace Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Conflux',
    symbol: 'CFX',
    decimals: 18,
  ),
  rpcUrls: const ['https://evmtestnet.confluxrpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'ConfluxScan',
    url: 'https://evmtestnet.confluxscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xEFf0078910f638cd81996cc117bccD3eDf2B072F',
      blockCreated: 117499050,
    ),
  },
);

/// Core Dao (chain id 1116).
final Chain coreDao = Chain(
  id: 1116,
  name: 'Core Dao',
  nativeCurrency: const NativeCurrency(
    name: 'Core',
    symbol: 'CORE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.coredao.org'],
  blockExplorer: const BlockExplorer(
    name: 'CoreDao',
    url: 'https://scan.coredao.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 11907934,
    ),
  },
);

/// Core Testnet (chain id 1115).
final Chain coreTestnet1 = Chain(
  id: 1115,
  name: 'Core Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tCore',
    symbol: 'TCORE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.test.btcs.network'],
  blockExplorer: const BlockExplorer(
    name: 'Core Testnet',
    url: 'https://scan.test.btcs.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xCcddF20A1932537123C2E48Bd8e00b108B8f7569',
      blockCreated: 29350509,
    ),
  },
);

/// Core Testnet2 (chain id 1114).
final Chain coreTestnet2 = Chain(
  id: 1114,
  name: 'Core Testnet2',
  nativeCurrency: const NativeCurrency(
    name: 'tCore2',
    symbol: 'TCORE2',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.test2.btcs.network'],
  blockExplorer: const BlockExplorer(
    name: 'Core Testnet2',
    url: 'https://scan.test2.btcs.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x3CB285ff3Cd5C7C7e570b1E7DE3De17A0f985e56',
      blockCreated: 3838600,
    ),
  },
);

/// Corn (chain id 21000000).
final Chain corn = Chain(
  id: 21000000,
  name: 'Corn',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcorn',
    symbol: 'BTCN',
    decimals: 18,
  ),
  rpcUrls: const ['https://21000000.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'Corn Explorer',
    url: 'https://cornscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3228,
    ),
  },
);

/// Corn Testnet (chain id 21000001).
final Chain cornTestnet = Chain(
  id: 21000001,
  name: 'Corn Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcorn',
    symbol: 'BTCN',
    decimals: 18,
  ),
  rpcUrls: const ['https://21000001.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'Corn Testnet Explorer',
    url: 'https://testnet.cornscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 4886,
    ),
  },
);

/// CpChain (chain id 86608).
final Chain cpchain = Chain(
  id: 86608,
  name: 'CpChain',
  nativeCurrency: const NativeCurrency(
    name: 'CpChain',
    symbol: 'CP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.cpchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'CpChain Explorer',
    url: 'https://explorer.cpchain.com',
  ),
);

/// Crab Network (chain id 44).
final Chain crab = Chain(
  id: 44,
  name: 'Crab Network',
  nativeCurrency: const NativeCurrency(
    name: 'Crab Network Native Token',
    symbol: 'CRAB',
    decimals: 18,
  ),
  rpcUrls: const ['https://crab-rpc.darwinia.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://crab-scan.darwinia.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 3032593,
    ),
  },
);

/// Creator (chain id 66665).
final Chain creatorTestnet = Chain(
  id: 66665,
  name: 'Creator',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.creatorchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://explorer.creatorchain.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Creditcoin Devnet (chain id 102032).
final Chain creditCoin3Devnet = Chain(
  id: 102032,
  name: 'Creditcoin Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'Devnet CTC',
    symbol: 'devCTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.cc3-devnet.creditcoin.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://creditcoin-devnet.blockscout.com',
  ),
);

/// Creditcoin (chain id 102030).
final Chain creditCoin3Mainnet = Chain(
  id: 102030,
  name: 'Creditcoin',
  nativeCurrency: const NativeCurrency(
    name: 'Creditcoin',
    symbol: 'CTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet3.creditcoin.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://creditcoin.blockscout.com',
  ),
);

/// Creditcoin Testnet (chain id 102031).
final Chain creditCoin3Testnet = Chain(
  id: 102031,
  name: 'Creditcoin Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Creditcoin Testnet',
    symbol: 'tCTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.cc3-testnet.creditcoin.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://creditcoin-testnet.blockscout.com',
  ),
);

/// Cronos Mainnet (chain id 25).
final Chain cronos = Chain(
  id: 25,
  name: 'Cronos Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Cronos',
    symbol: 'CRO',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.cronos.org'],
  blockExplorer: const BlockExplorer(
    name: 'Cronos Explorer',
    url: 'https://explorer.cronos.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1963112,
    ),
  },
);

/// Cronos Testnet (chain id 338).
final Chain cronosTestnet = Chain(
  id: 338,
  name: 'Cronos Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'CRO',
    symbol: 'tCRO',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm-t3.cronos.org'],
  blockExplorer: const BlockExplorer(
    name: 'Cronos Explorer (Testnet)',
    url: 'https://explorer.cronos.org/testnet',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 10191251,
    ),
  },
);

/// Cronos zkEVM Mainnet (chain id 388).
final Chain cronoszkEVM = Chain(
  id: 388,
  name: 'Cronos zkEVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Cronos zkEVM CRO',
    symbol: 'zkCRO',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.zkevm.cronos.org'],
  blockExplorer: const BlockExplorer(
    name: 'Cronos zkEVM (Mainnet) Chain Explorer',
    url: 'https://explorer.zkevm.cronos.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x06f4487d7c4a5983d2660db965cc6d2565e4cfaa',
      blockCreated: 72,
    ),
  },
);

/// Cronos zkEVM Testnet (chain id 282).
final Chain cronoszkEVMTestnet = Chain(
  id: 282,
  name: 'Cronos zkEVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Cronos zkEVM Test Coin',
    symbol: 'zkTCRO',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.zkevm.cronos.org'],
  blockExplorer: const BlockExplorer(
    name: 'Cronos zkEVM Testnet Explorer',
    url: 'https://explorer.zkevm.cronos.org/testnet',
  ),
);

/// Crossbell (chain id 3737).
final Chain crossbell = Chain(
  id: 3737,
  name: 'Crossbell',
  nativeCurrency: const NativeCurrency(
    name: 'CSB',
    symbol: 'CSB',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.crossbell.io'],
  blockExplorer: const BlockExplorer(
    name: 'CrossScan',
    url: 'https://scan.crossbell.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 38246031,
    ),
  },
);

/// CrossFi Mainnet (chain id 4158).
final Chain crossfi = Chain(
  id: 4158,
  name: 'CrossFi Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'CrossFi',
    symbol: 'XFI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.ms'],
  blockExplorer: const BlockExplorer(
    name: 'CrossFi Blockchain Explorer',
    url: 'https://xfiscan.com',
  ),
);

/// Curtis (chain id 33111).
final Chain curtis = Chain(
  id: 33111,
  name: 'Curtis',
  nativeCurrency: const NativeCurrency(
    name: 'ApeCoin',
    symbol: 'APE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.curtis.apechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Curtis Explorer',
    url: 'https://explorer.curtis.apechain.com',
  ),
);

/// Cyber (chain id 7560).
final Chain cyber = Chain(
  id: 7560,
  name: 'Cyber',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://cyber.alt.technology'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://cyberscan.co',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Cyber Testnet (chain id 111557560).
final Chain cyberTestnet = Chain(
  id: 111557560,
  name: 'Cyber Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://cyber-testnet.alt.technology'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://testnet.cyberscan.co',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xffc391F0018269d4758AEA1a144772E8FB99545E',
      blockCreated: 304545,
    ),
  },
);

/// Daily Network Mainnet (chain id 824).
final Chain dailyNetwork = Chain(
  id: 824,
  name: 'Daily Network Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Daily',
    symbol: 'DLY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.dailycrypto.net'],
  blockExplorer: const BlockExplorer(
    name: 'Daily Mainnet Explorer',
    url: 'https://explorer.mainnet.dailycrypto.net',
  ),
);

/// Daily Network Testnet (chain id 825).
final Chain dailyNetworkTestnet = Chain(
  id: 825,
  name: 'Daily Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Daily',
    symbol: 'DLY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.dailycrypto.net'],
  blockExplorer: const BlockExplorer(
    name: 'Daily Testnet Explorer',
    url: 'https://explorer.testnet.dailycrypto.net',
  ),
);

/// Darwinia Network (chain id 46).
final Chain darwinia = Chain(
  id: 46,
  name: 'Darwinia Network',
  nativeCurrency: const NativeCurrency(
    name: 'RING',
    symbol: 'RING',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.darwinia.network'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://explorer.darwinia.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 69420,
    ),
  },
);

/// Datahaven Testnet (chain id 55931).
final Chain datahavenTestnet = Chain(
  id: 55931,
  name: 'Datahaven Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MOCK',
    symbol: 'MOCK',
    decimals: 18,
  ),
  rpcUrls: const ['https://services.datahaven-testnet.network/testnet'],
  blockExplorer: const BlockExplorer(
    name: 'DhScan',
    url: 'https://testnet.dhscan.io/',
  ),
);

/// DBK chain (chain id 20240603).
final Chain dbkchain = Chain(
  id: 20240603,
  name: 'DBK chain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.dbkchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'DBK Chain Explorer',
    url: 'https://scan.dbkchain.io',
  ),
);

/// Dchain (chain id 2716446429837000).
final Chain dchain = Chain(
  id: 2716446429837000,
  name: 'Dchain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://dchain-2716446429837000-1.jsonrpc.sagarpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Dchain Explorer',
    url: 'https://dchain-2716446429837000-1.sagaexplorer.io',
  ),
);

/// Dchain Testnet (chain id 2713017997578000).
final Chain dchainTestnet = Chain(
  id: 2713017997578000,
  name: 'Dchain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://dchaintestnet-2713017997578000-1.jsonrpc.testnet.sagarpc.io',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Dchain Explorer',
    url: 'https://dchaintestnet-2713017997578000-1.testnet.sagaexplorer.io',
  ),
);

/// Defi Oracle Meta Mainnet (chain id 138).
final Chain defiOracleMetaMainnet = Chain(
  id: 138,
  name: 'Defi Oracle Meta Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-http-pub.d-bis.org',
    'https://rpc.d-bis.org',
    'https://rpc2.d-bis.org',
    'https://rpc.public-0138.defi-oracle.io',
    'https://rpc.defi-oracle.io',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.d-bis.org',
  ),
);

/// DeFiChain EVM Mainnet (chain id 1130).
final Chain defichainEvm = Chain(
  id: 1130,
  name: 'DeFiChain EVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'DeFiChain',
    symbol: 'DFI',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth.mainnet.ocean.jellyfishsdk.com'],
  blockExplorer: const BlockExplorer(
    name: 'DeFiScan',
    url: 'https://meta.defiscan.live',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 137852,
    ),
  },
);

/// DeFiChain EVM Testnet (chain id 1131).
final Chain defichainEvmTestnet = Chain(
  id: 1131,
  name: 'DeFiChain EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'DeFiChain',
    symbol: 'DFI',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth.testnet.ocean.jellyfishsdk.com'],
  blockExplorer: const BlockExplorer(
    name: 'DeFiScan',
    url: 'https://meta.defiscan.live/?network=TestNet',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 156462,
    ),
  },
);

/// Degen (chain id 666666666).
final Chain degen = Chain(
  id: 666666666,
  name: 'Degen',
  nativeCurrency: const NativeCurrency(
    name: 'Degen',
    symbol: 'DEGEN',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.degen.tips'],
  blockExplorer: const BlockExplorer(
    name: 'Degen Chain Explorer',
    url: 'https://explorer.degen.tips',
  ),
);

/// DFK Chain (chain id 53935).
final Chain dfk = Chain(
  id: 53935,
  name: 'DFK Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Jewel',
    symbol: 'JEWEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://subnets.avax.network/defi-kingdoms/dfk-chain/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'DFKSubnetScan',
    url: 'https://subnets.avax.network/defi-kingdoms',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 14790551,
    ),
  },
);

/// Diode Prenet (chain id 15).
final Chain diode = Chain(
  id: 15,
  name: 'Diode Prenet',
  nativeCurrency: const NativeCurrency(
    name: 'DIODE',
    symbol: 'DIODE',
    decimals: 18,
  ),
  rpcUrls: const ['https://prenet.diode.io:8443'],
  blockExplorer: const BlockExplorer(
    name: 'Diode Explorer',
    url: 'https://diode.io/prenet',
  ),
);

/// DisChain (chain id 513100).
final Chain disChain = Chain(
  id: 513100,
  name: 'DisChain',
  nativeCurrency: const NativeCurrency(
    name: 'DIS',
    symbol: 'DIS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.dischain.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'DisChain Explorer',
    url: 'https://www.oklink.com/dis',
  ),
);

/// DODOchain Testnet (chain id 53457).
final Chain dodochainTestnet = Chain(
  id: 53457,
  name: 'DODOchain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'DODO',
    symbol: 'DODO',
    decimals: 18,
  ),
  rpcUrls: const ['https://dodochain-testnet.alt.technology'],
  blockExplorer: const BlockExplorer(
    name: 'DODOchain Testnet (Sepolia) Explorer',
    url: 'https://testnet-scan.dodochain.com',
  ),
);

/// Dogechain (chain id 2000).
final Chain dogechain = Chain(
  id: 2000,
  name: 'Dogechain',
  nativeCurrency: const NativeCurrency(
    name: 'Wrapped Dogecoin',
    symbol: 'WDOGE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.dogechain.dog'],
  blockExplorer: const BlockExplorer(
    name: 'DogeChainExplorer',
    url: 'https://explorer.dogechain.dog',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x68a8609a60a008EFA633dfdec592c03B030cC508',
      blockCreated: 25384031,
    ),
  },
);

/// Doma Testnet (chain id 97476).
final Chain domaTestnet = Chain(
  id: 97476,
  name: 'Doma Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.doma.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Doma Testnet Explorer',
    url: 'https://explorer-testnet.doma.xyz',
  ),
);

/// Donatuz (chain id 42026).
final Chain donatuz = Chain(
  id: 42026,
  name: 'Donatuz',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.donatuz.com'],
  blockExplorer: const BlockExplorer(
    name: 'Donatuz Explorer',
    url: 'https://explorer.donatuz.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// DOS Chain (chain id 7979).
final Chain dosChain = Chain(
  id: 7979,
  name: 'DOS Chain',
  nativeCurrency: const NativeCurrency(
    name: 'DOS Chain',
    symbol: 'DOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://main.doschain.com'],
  blockExplorer: const BlockExplorer(
    name: 'DOS Chain Explorer',
    url: 'https://doscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 161908,
    ),
  },
);

/// DOS Chain Testnet (chain id 3939).
final Chain dosChainTestnet = Chain(
  id: 3939,
  name: 'DOS Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'DOS Chain Testnet',
    symbol: 'DOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://test.doschain.com'],
  blockExplorer: const BlockExplorer(
    name: 'DOS Chain Testnet Explorer',
    url: 'https://test.doscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 69623,
    ),
  },
);

/// DreyerX Mainnet (chain id 23451).
final Chain dreyerxMainnet = Chain(
  id: 23451,
  name: 'DreyerX Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'DreyerX',
    symbol: 'DRX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.dreyerx.com'],
  blockExplorer: const BlockExplorer(
    name: 'DreyerX Scan',
    url: 'https://scan.dreyerx.com',
  ),
);

/// DreyerX Testnet (chain id 23452).
final Chain dreyerxTestnet = Chain(
  id: 23452,
  name: 'DreyerX Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'DreyerX',
    symbol: 'DRX',
    decimals: 18,
  ),
  rpcUrls: const ['http://testnet-rpc.dreyerx.com'],
  blockExplorer: const BlockExplorer(
    name: 'DreyerX Testnet Scan',
    url: 'https://testnet-scan.dreyerx.com',
  ),
);

/// DustBoy IoT (chain id 555888).
final Chain dustboyIoT = Chain(
  id: 555888,
  name: 'DustBoy IoT',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'DST',
    decimals: 18,
  ),
  rpcUrls: const ['https://dustboy-rpc.jibl2.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://dustboy.jibl2.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xFFD34aa2C62B2D52E00A361e466C229788f4eD6a',
      blockCreated: 526569,
    ),
  },
);

/// Dymension (chain id 1100).
final Chain dymension = Chain(
  id: 1100,
  name: 'Dymension',
  nativeCurrency: const NativeCurrency(
    name: 'DYM',
    symbol: 'DYM',
    decimals: 18,
  ),
  rpcUrls: const ['https://dymension-evm-rpc.publicnode.com'],
  blockExplorer: const BlockExplorer(name: 'Dym FYI', url: 'https://dym.fyi'),
);

/// Eden (chain id 714).
final Chain eden = Chain(
  id: 714,
  name: 'Eden',
  nativeCurrency: const NativeCurrency(
    name: 'TIA',
    symbol: 'TIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.eden.gateway.fm'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://eden.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// edeXa (chain id 5424).
final Chain edexa = Chain(
  id: 5424,
  name: 'edeXa',
  nativeCurrency: const NativeCurrency(
    name: 'edeXa',
    symbol: 'EDX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.edexa.network'],
  blockExplorer: const BlockExplorer(
    name: 'edeXa Explorer',
    url: 'https://explorer.edexa.network',
  ),
);

/// edeXa Testnet (chain id 1995).
final Chain edexaTestnet = Chain(
  id: 1995,
  name: 'edeXa Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'edeXa',
    symbol: 'tEDX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.edexa.network'],
  blockExplorer: const BlockExplorer(
    name: 'edeXa Testnet Explorer',
    url: 'https://explorer.testnet.edexa.network',
  ),
);

/// Edgeless Network (chain id 2026).
final Chain edgeless = Chain(
  id: 2026,
  name: 'Edgeless Network',
  nativeCurrency: const NativeCurrency(
    name: 'Edgeless Wrapped ETH',
    symbol: 'EwETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.edgeless.network/http'],
  blockExplorer: const BlockExplorer(
    name: 'Edgeless Explorer',
    url: 'https://explorer.edgeless.network',
  ),
);

/// Edgeless Testnet (chain id 202).
final Chain edgelessTestnet = Chain(
  id: 202,
  name: 'Edgeless Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Edgeless Wrapped ETH',
    symbol: 'EwETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://edgeless-testnet.rpc.caldera.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Edgeless Testnet Explorer',
    url: 'https://testnet.explorer.edgeless.network',
  ),
);

/// Edgeware EdgeEVM Mainnet (chain id 2021).
final Chain edgeware = Chain(
  id: 2021,
  name: 'Edgeware EdgeEVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Edgeware',
    symbol: 'EDG',
    decimals: 18,
  ),
  rpcUrls: const ['https://edgeware-evm.jelliedowl.net'],
  blockExplorer: const BlockExplorer(
    name: 'Edgscan by Bharathcoorg',
    url: 'https://edgscan.live',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 18117872,
    ),
  },
);

/// Beresheet BereEVM Testnet (chain id 2022).
final Chain edgewareTestnet = Chain(
  id: 2022,
  name: 'Beresheet BereEVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Testnet EDG',
    symbol: 'tEDG',
    decimals: 18,
  ),
  rpcUrls: const ['https://beresheet-evm.jelliedowl.net'],
  blockExplorer: const BlockExplorer(
    name: 'Edgscan by Bharathcoorg',
    url: 'https://testnet.edgscan.live',
  ),
);

/// EDU Chain (chain id 41923).
final Chain eduChain = Chain(
  id: 41923,
  name: 'EDU Chain',
  nativeCurrency: const NativeCurrency(
    name: 'EDU',
    symbol: 'EDU',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.educhain.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'EDU Chain Explorer',
    url: 'https://explorer.educhain.xyz/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 16410660,
    ),
  },
);

/// EDU Chain Testnet (chain id 656476).
final Chain eduChainTestnet = Chain(
  id: 656476,
  name: 'EDU Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'EDU',
    symbol: 'EDU',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.educhain.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'EDU Chain Testnet Explorer',
    url: 'https://explorer.testnet.educhain.xyz/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 15514133,
    ),
  },
);

/// Elastos Smart Chain (chain id 20).
final Chain elastos = Chain(
  id: 20,
  name: 'Elastos Smart Chain',
  nativeCurrency: const NativeCurrency(
    name: 'ELA',
    symbol: 'ELA',
    decimals: 18,
  ),
  rpcUrls: const ['https://api2.elastos.io/eth'],
  blockExplorer: const BlockExplorer(
    name: 'Elastos Explorer',
    url: 'https://esc.elastos.io',
  ),
);

/// Elastos Smart Chain Testnet (chain id 21).
final Chain elastosTestnet = Chain(
  id: 21,
  name: 'Elastos Smart Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tELA',
    symbol: 'tELA',
    decimals: 18,
  ),
  rpcUrls: const ['https://api-testnet.elastos.io/eth'],
  blockExplorer: const BlockExplorer(
    name: 'Elastos Explorer',
    url: 'https://esc-testnet.elastos.io',
  ),
);

/// Electroneum Mainnet (chain id 52014).
final Chain electroneum = Chain(
  id: 52014,
  name: 'Electroneum Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETN',
    symbol: 'ETN',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.electroneum.com'],
  blockExplorer: const BlockExplorer(
    name: 'Electroneum Block Explorer',
    url: 'https://blockexplorer.electroneum.com',
  ),
);

/// Electroneum Testnet (chain id 5201420).
final Chain electroneumTestnet = Chain(
  id: 5201420,
  name: 'Electroneum Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETN',
    symbol: 'ETN',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.electroneum.com'],
  blockExplorer: const BlockExplorer(
    name: 'Electroneum Block Explorer',
    url: 'https://blockexplorer.thesecurityteam.rocks',
  ),
);

/// Elysium Testnet (chain id 1338).
final Chain elysiumTestnet = Chain(
  id: 1338,
  name: 'Elysium Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'LAVA',
    symbol: 'LAVA',
    decimals: 18,
  ),
  rpcUrls: const ['https://elysium-test-rpc.vulcanforged.com'],
  blockExplorer: const BlockExplorer(
    name: 'Elysium testnet explorer',
    url: 'https://elysium-explorer.vulcanforged.com',
  ),
);

/// Energy Mainnet (chain id 246).
final Chain energy = Chain(
  id: 246,
  name: 'Energy Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'EWT',
    symbol: 'EWT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.energyweb.org'],
  blockExplorer: const BlockExplorer(
    name: 'EnergyWeb Explorer',
    url: 'https://explorer.energyweb.org',
  ),
);

/// ENI Mainnet (chain id 173).
final Chain eni = Chain(
  id: 173,
  name: 'ENI Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ENI',
    symbol: 'ENI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.eniac.network'],
  blockExplorer: const BlockExplorer(
    name: 'ENI Explorer',
    url: 'https://scan.eniac.network',
  ),
);

/// ENI Testnet (chain id 6912115).
final Chain eniTestnet = Chain(
  id: 6912115,
  name: 'ENI Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ENI Testnet Token',
    symbol: 'ENI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.eniac.network'],
  blockExplorer: const BlockExplorer(
    name: 'ENI Testnet Explorer',
    url: 'https://scan-testnet.eniac.network',
  ),
);

/// ENULS Mainnet (chain id 119).
final Chain enuls = Chain(
  id: 119,
  name: 'ENULS Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'NULS',
    symbol: 'NULS',
    decimals: 18,
  ),
  rpcUrls: const ['https://evmapi2.nuls.io'],
  blockExplorer: const BlockExplorer(
    name: 'ENULS Explorer',
    url: 'https://evmscan.nuls.io',
  ),
);

/// Horizen EON (chain id 7332).
final Chain eon = Chain(
  id: 7332,
  name: 'Horizen EON',
  nativeCurrency: const NativeCurrency(
    name: 'ZEN',
    symbol: 'ZEN',
    decimals: 18,
  ),
  rpcUrls: const ['https://eon-rpc.horizenlabs.io/ethv1'],
  blockExplorer: const BlockExplorer(
    name: 'EON Explorer',
    url: 'https://eon-explorer.horizenlabs.io',
  ),
);

/// EOS EVM (chain id 17777).
final Chain eos = Chain(
  id: 17777,
  name: 'EOS EVM',
  nativeCurrency: const NativeCurrency(
    name: 'EOS',
    symbol: 'EOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.evm.eosnetwork.com'],
  blockExplorer: const BlockExplorer(
    name: 'EOS EVM Explorer',
    url: 'https://explorer.evm.eosnetwork.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 7943933,
    ),
  },
);

/// EOS EVM Testnet (chain id 15557).
final Chain eosTestnet = Chain(
  id: 15557,
  name: 'EOS EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'EOS',
    symbol: 'EOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.testnet.evm.eosnetwork.com'],
  blockExplorer: const BlockExplorer(
    name: 'EOS EVM Testnet Explorer',
    url: 'https://explorer.testnet.evm.eosnetwork.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 9067940,
    ),
  },
);

/// Eteria (chain id 140).
final Chain eteria = Chain(
  id: 140,
  name: 'Eteria',
  nativeCurrency: const NativeCurrency(
    name: 'Eteria',
    symbol: 'ERA',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.eteria.io/v1'],
  blockExplorer: const BlockExplorer(
    name: 'Eteria Explorer',
    url: 'https://explorer.eteria.io',
  ),
);

/// Etherlink (chain id 42793).
final Chain etherlink = Chain(
  id: 42793,
  name: 'Etherlink',
  nativeCurrency: const NativeCurrency(
    name: 'Tez',
    symbol: 'XTZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://node.mainnet.etherlink.com'],
  blockExplorer: const BlockExplorer(
    name: 'Etherlink',
    url: 'https://explorer.etherlink.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 33899,
    ),
  },
);

/// Etherlink Shadownet Testnet (chain id 127823).
final Chain etherlinkShadownetTestnet = Chain(
  id: 127823,
  name: 'Etherlink Shadownet Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tez',
    symbol: 'XTZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://node.shadownet.etherlink.com'],
  blockExplorer: const BlockExplorer(
    name: 'Etherlink Shadownet Testnet Explorer',
    url: 'https://shadownet.explorer.etherlink.com',
  ),
);

/// Etherlink Testnet (chain id 128123).
final Chain etherlinkTestnet = Chain(
  id: 128123,
  name: 'Etherlink Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Tez',
    symbol: 'XTZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://node.ghostnet.etherlink.com'],
  blockExplorer: const BlockExplorer(
    name: 'Etherlink Testnet',
    url: 'https://testnet.explorer.etherlink.com',
  ),
);

/// Ethernity (chain id 183).
final Chain ethernity = Chain(
  id: 183,
  name: 'Ethernity',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.ethernitychain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Ethernity Explorer',
    url: 'https://ernscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// ETP Mainnet (chain id 20256789).
final Chain etp = Chain(
  id: 20256789,
  name: 'ETP Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETP Chain Native Token',
    symbol: 'ETP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.etpscan.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'ETP Scan',
    url: 'https://etpscan.xyz',
  ),
);

/// Evmos (chain id 9001).
final Chain evmos = Chain(
  id: 9001,
  name: 'Evmos',
  nativeCurrency: const NativeCurrency(
    name: 'Evmos',
    symbol: 'EVMOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth.bd.evmos.org:8545'],
  blockExplorer: const BlockExplorer(
    name: 'Evmos Block Explorer',
    url: 'https://escan.live',
  ),
);

/// Evmos Testnet (chain id 9000).
final Chain evmosTestnet = Chain(
  id: 9000,
  name: 'Evmos Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Evmos',
    symbol: 'EVMOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth.bd.evmos.dev:8545'],
  blockExplorer: const BlockExplorer(
    name: 'Evmos Testnet Block Explorer',
    url: 'https://evm.evmos.dev/',
  ),
);

/// Excelon Mainnet (chain id 22052002).
final Chain excelonMainnet = Chain(
  id: 22052002,
  name: 'Excelon Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Excelon',
    symbol: 'xlon',
    decimals: 18,
  ),
  rpcUrls: const ['https://edgewallet1.xlon.org'],
  blockExplorer: const BlockExplorer(
    name: 'Excelon explorer',
    url: 'https://explorer.excelon.io',
  ),
);

/// Expanse Network (chain id 2).
final Chain expanse = Chain(
  id: 2,
  name: 'Expanse Network',
  nativeCurrency: const NativeCurrency(
    name: 'EXP',
    symbol: 'EXP',
    decimals: 18,
  ),
  rpcUrls: const ['https://node.expanse.tech'],
  blockExplorer: const BlockExplorer(
    name: 'Expanse Explorer',
    url: 'https://explorer.expanse.tech',
  ),
);

/// exSat Network (chain id 7200).
final Chain exsat = Chain(
  id: 7200,
  name: 'exSat Network',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.exsat.network'],
  blockExplorer: const BlockExplorer(
    name: 'exSat Explorer',
    url: 'https://scan.exsat.network',
  ),
);

/// exSat Testnet (chain id 839999).
final Chain exsatTestnet = Chain(
  id: 839999,
  name: 'exSat Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm-tst3.exsat.network'],
  blockExplorer: const BlockExplorer(
    name: 'exSat Explorer',
    url: 'https://scan-testnet.exsat.network',
  ),
);

/// Fantom (chain id 250).
final Chain fantom = Chain(
  id: 250,
  name: 'Fantom',
  nativeCurrency: const NativeCurrency(
    name: 'Fantom',
    symbol: 'FTM',
    decimals: 18,
  ),
  rpcUrls: const ['https://250.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'FTMScan',
    url: 'https://ftmscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 33001987,
    ),
  },
);

/// Fantom Sonic Open Testnet (chain id 64240).
final Chain fantomSonicTestnet = Chain(
  id: 64240,
  name: 'Fantom Sonic Open Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Fantom',
    symbol: 'FTM',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpcapi.sonic.fantom.network'],
  blockExplorer: const BlockExplorer(
    name: 'Fantom Sonic Open Testnet Explorer',
    url: 'https://public-sonic.fantom.network',
  ),
);

/// Fantom Testnet (chain id 4002).
final Chain fantomTestnet = Chain(
  id: 4002,
  name: 'Fantom Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Fantom',
    symbol: 'FTM',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.fantom.network'],
  blockExplorer: const BlockExplorer(
    name: 'FTMScan',
    url: 'https://testnet.ftmscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 8328688,
    ),
  },
);

/// Fibo Chain (chain id 12306).
final Chain fibo = Chain(
  id: 12306,
  name: 'Fibo Chain',
  nativeCurrency: const NativeCurrency(
    name: 'fibo',
    symbol: 'FIBO',
    decimals: 18,
  ),
  rpcUrls: const ['https://network.hzroc.art'],
  blockExplorer: const BlockExplorer(
    name: 'FiboScan',
    url: 'https://scan.fibochain.org',
  ),
);

/// Filecoin Mainnet (chain id 314).
final Chain filecoin = Chain(
  id: 314,
  name: 'Filecoin Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'filecoin',
    symbol: 'FIL',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.node.glif.io/rpc/v1'],
  blockExplorer: const BlockExplorer(
    name: 'Filfox',
    url: 'https://filfox.info/en',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3328594,
    ),
  },
);

/// Filecoin Calibration (chain id 314159).
final Chain filecoinCalibration = Chain(
  id: 314159,
  name: 'Filecoin Calibration',
  nativeCurrency: const NativeCurrency(
    name: 'testnet filecoin',
    symbol: 'tFIL',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.calibration.node.glif.io/rpc/v1'],
  blockExplorer: const BlockExplorer(
    name: 'Filscan',
    url: 'https://calibration.filscan.io',
  ),
);

/// Filecoin Hyperspace (chain id 3141).
final Chain filecoinHyperspace = Chain(
  id: 3141,
  name: 'Filecoin Hyperspace',
  nativeCurrency: const NativeCurrency(
    name: 'testnet filecoin',
    symbol: 'tFIL',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.hyperspace.node.glif.io/rpc/v1'],
  blockExplorer: const BlockExplorer(
    name: 'Filfox',
    url: 'https://hyperspace.filfox.info/en',
  ),
);

/// 5ireChain (chain id 995).
final Chain fireChain = Chain(
  id: 995,
  name: '5ireChain',
  nativeCurrency: const NativeCurrency(
    name: '5ire Token',
    symbol: '5IRE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.5ire.network'],
  blockExplorer: const BlockExplorer(
    name: '5ireChain Mainnet Explorer',
    url: 'https://5irescan.io/',
  ),
);

/// Flame (chain id 253368190).
final Chain flame = Chain(
  id: 253368190,
  name: 'Flame',
  nativeCurrency: const NativeCurrency(
    name: 'TIA',
    symbol: 'TIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.flame.astria.org'],
  blockExplorer: const BlockExplorer(
    name: 'Flame Explorer',
    url: 'https://explorer.flame.astria.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 6829148,
    ),
  },
);

/// Flare Mainnet (chain id 14).
final Chain flare = Chain(
  id: 14,
  name: 'Flare Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Flare',
    symbol: 'FLR',
    decimals: 18,
  ),
  rpcUrls: const ['https://flare-api.flare.network/ext/C/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Flare Explorer',
    url: 'https://flare-explorer.flare.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3002461,
    ),
  },
);

/// Flare Testnet Coston2 (chain id 114).
final Chain flareTestnet = Chain(
  id: 114,
  name: 'Flare Testnet Coston2',
  nativeCurrency: const NativeCurrency(
    name: 'Coston2 Flare',
    symbol: 'C2FLR',
    decimals: 18,
  ),
  rpcUrls: const ['https://coston2-api.flare.network/ext/C/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Coston2 Explorer',
    url: 'https://coston2-explorer.flare.network',
  ),
);

/// Flow EVM Mainnet (chain id 747).
final Chain flowMainnet = Chain(
  id: 747,
  name: 'Flow EVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Flow',
    symbol: 'FLOW',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.evm.nodes.onflow.org'],
  blockExplorer: const BlockExplorer(
    name: 'Mainnet Explorer',
    url: 'https://evm.flowscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 6205,
    ),
  },
);

/// Flow EVM Previewnet (chain id 646).
final Chain flowPreviewnet = Chain(
  id: 646,
  name: 'Flow EVM Previewnet',
  nativeCurrency: const NativeCurrency(
    name: 'Flow',
    symbol: 'FLOW',
    decimals: 18,
  ),
  rpcUrls: const ['https://previewnet.evm.nodes.onflow.org'],
  blockExplorer: const BlockExplorer(
    name: 'Previewnet Explorer',
    url: 'https://previewnet.flowdiver.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 6205,
    ),
  },
);

/// Flow EVM Testnet (chain id 545).
final Chain flowTestnet = Chain(
  id: 545,
  name: 'Flow EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Flow',
    symbol: 'FLOW',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.evm.nodes.onflow.org'],
  blockExplorer: const BlockExplorer(
    name: 'Flow Diver',
    url: 'https://evm-testnet.flowscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 137518,
    ),
  },
);

/// Fluence (chain id 9999999).
final Chain fluence = Chain(
  id: 9999999,
  name: 'Fluence',
  nativeCurrency: const NativeCurrency(
    name: 'FLT',
    symbol: 'FLT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.fluence.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout.mainnet.fluence.dev',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 207583,
    ),
  },
);

/// Fluence Stage (chain id 123420000220).
final Chain fluenceStage = Chain(
  id: 123420000220,
  name: 'Fluence Stage',
  nativeCurrency: const NativeCurrency(
    name: 'tFLT',
    symbol: 'tFLT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.stage.fluence.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout.stage.fluence.dev',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 83227,
    ),
  },
);

/// Fluence Testnet (chain id 52164803).
final Chain fluenceTestnet = Chain(
  id: 52164803,
  name: 'Fluence Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tFLT',
    symbol: 'tFLT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.fluence.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout.testnet.fluence.dev',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 96424,
    ),
  },
);

/// Fluent (chain id 25363).
final Chain fluent = Chain(
  id: 25363,
  name: 'Fluent',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.fluent.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Fluent Explorer',
    url: 'https://fluentscan.xyz',
  ),
);

/// Fluent Devnet (chain id 20993).
final Chain fluentDevnet = Chain(
  id: 20993,
  name: 'Fluent Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.devnet.fluent.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Fluent Devnet Explorer',
    url: 'https://devnet.fluentscan.xyz',
  ),
);

/// Fluent Testnet (chain id 20994).
final Chain fluentTestnet = Chain(
  id: 20994,
  name: 'Fluent Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.fluent.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Fluent Testnet Explorer',
    url: 'https://testnet.fluentscan.xyz',
  ),
);

/// Form Network (chain id 478).
final Chain form = Chain(
  id: 478,
  name: 'Form Network',
  nativeCurrency: const NativeCurrency(
    name: 'Ethereum',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.form.network/http'],
  blockExplorer: const BlockExplorer(
    name: 'Form Explorer',
    url: 'https://explorer.form.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Form Testnet (chain id 132902).
final Chain formTestnet = Chain(
  id: 132902,
  name: 'Form Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ethereum',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia-rpc.form.network/http'],
  blockExplorer: const BlockExplorer(
    name: 'Form Testnet Explorer',
    url: 'https://sepolia-explorer.form.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Forma (chain id 984122).
final Chain forma = Chain(
  id: 984122,
  name: 'Forma',
  nativeCurrency: const NativeCurrency(
    name: 'TIA',
    symbol: 'TIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.forma.art'],
  blockExplorer: const BlockExplorer(
    name: 'Forma Explorer',
    url: 'https://explorer.forma.art',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xd53C6FFB123F7349A32980F87faeD8FfDc9ef079',
      blockCreated: 252705,
    ),
  },
);

/// Formicarium (chain id 43521).
final Chain formicarium = Chain(
  id: 43521,
  name: 'Formicarium',
  nativeCurrency: const NativeCurrency(name: 'M', symbol: 'M', decimals: 18),
  rpcUrls: const ['https://rpc.formicarium.memecore.net'],
  blockExplorer: const BlockExplorer(
    name: 'MemeCore Testnet Explorer',
    url: 'https://formicarium.memecorescan.io',
  ),
);

/// Forta Chain (chain id 80931).
final Chain forta = Chain(
  id: 80931,
  name: 'Forta Chain',
  nativeCurrency: const NativeCurrency(
    name: 'FORT',
    symbol: 'FORT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-forta-chain-8gj1qndmfc.t.conduit.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Forta Explorer',
    url: 'https://explorer.forta.org',
  ),
);

/// Foundry (chain id 31337).
final Chain foundry = Chain(
  id: 31337,
  name: 'Foundry',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://127.0.0.1:8545'],
);

/// Fraxtal (chain id 252).
final Chain fraxtal = Chain(
  id: 252,
  name: 'Fraxtal',
  nativeCurrency: const NativeCurrency(
    name: 'Frax',
    symbol: 'FRAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.frax.com'],
  blockExplorer: const BlockExplorer(
    name: 'fraxscan',
    url: 'https://fraxscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Fraxtal Testnet (chain id 2522).
final Chain fraxtalTestnet = Chain(
  id: 2522,
  name: 'Fraxtal Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Frax',
    symbol: 'FRAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.frax.com'],
  blockExplorer: const BlockExplorer(
    name: 'fraxscan testnet',
    url: 'https://holesky.fraxscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Funki (chain id 33979).
final Chain funkiMainnet = Chain(
  id: 33979,
  name: 'Funki',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-mainnet.funkichain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Funki Mainnet Explorer',
    url: 'https://funkiscan.io',
  ),
);

/// Funki Sepolia Sandbox (chain id 3397901).
final Chain funkiSepolia = Chain(
  id: 3397901,
  name: 'Funki Sepolia Sandbox',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://funki-testnet.alt.technology'],
  blockExplorer: const BlockExplorer(
    name: 'Funki Sepolia Sandbox Explorer',
    url: 'https://sepolia-sandbox.funkichain.com/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1620204,
    ),
  },
);

/// Fuse (chain id 122).
final Chain fuse = Chain(
  id: 122,
  name: 'Fuse',
  nativeCurrency: const NativeCurrency(
    name: 'Fuse',
    symbol: 'FUSE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.fuse.io'],
  blockExplorer: const BlockExplorer(
    name: 'Fuse Explorer',
    url: 'https://explorer.fuse.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 16146628,
    ),
  },
);

/// Fuse Sparknet (chain id 123).
final Chain fuseSparknet = Chain(
  id: 123,
  name: 'Fuse Sparknet',
  nativeCurrency: const NativeCurrency(
    name: 'Spark',
    symbol: 'SPARK',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.fusespark.io'],
  blockExplorer: const BlockExplorer(
    name: 'Sparkent Explorer',
    url: 'https://explorer.fusespark.io',
  ),
);

/// Fusion Mainnet (chain id 32659).
final Chain fusion = Chain(
  id: 32659,
  name: 'Fusion Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Fusion',
    symbol: 'FSN',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.fusionnetwork.io'],
  blockExplorer: const BlockExplorer(
    name: 'FSNscan',
    url: 'https://fsnscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 10441605,
    ),
  },
);

/// Fusion Testnet (chain id 46688).
final Chain fusionTestnet = Chain(
  id: 46688,
  name: 'Fusion Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Fusion',
    symbol: 'FSN',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.fusionnetwork.io'],
  blockExplorer: const BlockExplorer(
    name: 'FSNscan',
    url: 'https://testnet.fsnscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 10428309,
    ),
  },
);

/// Garnet Testnet (chain id 17069).
final Chain garnet = Chain(
  id: 17069,
  name: 'Garnet Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.garnetchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.garnetchain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// GateChain Mainnet (chain id 86).
final Chain gatechain = Chain(
  id: 86,
  name: 'GateChain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'GateChainToken',
    symbol: 'GT',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.nodeinfo.cc'],
  blockExplorer: const BlockExplorer(
    name: 'Gate Scan',
    url: 'https://www.gatescan.org',
  ),
);

/// Geist Mainnet (chain id 63157).
final Chain geist = Chain(
  id: 63157,
  name: 'Geist Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Aavegotchi GHST Token',
    symbol: 'GHST',
    decimals: 18,
  ),
  rpcUrls: const ['https://geist-mainnet.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://geist-mainnet.explorer.alchemy.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 660735,
    ),
  },
);

/// Genesys Mainnet (chain id 16507).
final Chain genesys = Chain(
  id: 16507,
  name: 'Genesys Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'GSYS',
    symbol: 'GSYS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.genesys.network'],
  blockExplorer: const BlockExplorer(
    name: 'Genesys Explorer',
    url: 'https://gchainexplorer.genesys.network',
  ),
);

/// Gensyn Mainnet (chain id 685689).
final Chain gensyn = Chain(
  id: 685689,
  name: 'Gensyn Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://gensyn-mainnet.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://gensyn-mainnet.explorer.alchemy.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// GIWA Sepolia (chain id 91342).
final Chain giwaSepolia = Chain(
  id: 91342,
  name: 'GIWA Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia-rpc.giwa.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://sepolia-explorer.giwa.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Glide L1 Protocol XP (chain id 251).
final Chain glideL1Protocol = Chain(
  id: 251,
  name: 'Glide L1 Protocol XP',
  nativeCurrency: const NativeCurrency(
    name: 'GLXP',
    symbol: 'GLXP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-api.glideprotocol.xyz/l1-rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Glide Protocol Explore',
    url: 'https://blockchain-explorer.glideprotocol.xyz',
  ),
);

/// Glide L2 Protocol XP (chain id 253).
final Chain glideL2Protocol = Chain(
  id: 253,
  name: 'Glide L2 Protocol XP',
  nativeCurrency: const NativeCurrency(
    name: 'GLXP',
    symbol: 'GLXP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-api.glideprotocol.xyz/l2-rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Glide Protocol Explore',
    url: 'https://blockchain-explorer.glideprotocol.xyz',
  ),
);

/// Gnosis (chain id 100).
final Chain gnosis = Chain(
  id: 100,
  name: 'Gnosis',
  nativeCurrency: const NativeCurrency(
    name: 'xDAI',
    symbol: 'XDAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.gnosischain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Gnosisscan',
    url: 'https://gnosisscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 21022491,
    ),
  },
);

/// Gnosis Chiado (chain id 10200).
final Chain gnosisChiado = Chain(
  id: 10200,
  name: 'Gnosis Chiado',
  nativeCurrency: const NativeCurrency(
    name: 'Gnosis',
    symbol: 'xDAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.chiadochain.net'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout.chiadochain.net',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 4967313,
    ),
  },
);

/// GoChain (chain id 60).
final Chain goChain = Chain(
  id: 60,
  name: 'GoChain',
  nativeCurrency: const NativeCurrency(name: 'GO', symbol: 'GO', decimals: 18),
  rpcUrls: const ['https://rpc.gochain.io'],
  blockExplorer: const BlockExplorer(
    name: 'GoChain Explorer',
    url: 'https://explorer.gochain.io',
  ),
);

/// GOAT (chain id 2345).
final Chain goat = Chain(
  id: 2345,
  name: 'GOAT',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.goat.network'],
  blockExplorer: const BlockExplorer(
    name: 'Goat Explorer',
    url: 'https://explorer.goat.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Horizen Gobi Testnet (chain id 1663).
final Chain gobi = Chain(
  id: 1663,
  name: 'Horizen Gobi Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Test ZEN',
    symbol: 'tZEN',
    decimals: 18,
  ),
  rpcUrls: const ['https://gobi-testnet.horizenlabs.io/ethv1'],
  blockExplorer: const BlockExplorer(
    name: 'Gobi Explorer',
    url: 'https://gobi-explorer.horizen.io',
  ),
);

/// Godwoken Mainnet (chain id 71402).
final Chain godwoken = Chain(
  id: 71402,
  name: 'Godwoken Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'pCKB',
    symbol: 'pCKB',
    decimals: 18,
  ),
  rpcUrls: const ['https://v1.mainnet.godwoken.io/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'GW Scan',
    url: 'https://v1.gwscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 15034,
    ),
  },
);

/// Goerli (chain id 5).
final Chain goerli = Chain(
  id: 5,
  name: 'Goerli',
  nativeCurrency: const NativeCurrency(
    name: 'Goerli Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://5.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://goerli.etherscan.io',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e',
    ),
    'ensUniversalResolver': ChainContract(
      address: '0xfc4AC75C46C914aF5892d6d3eFFcebD7917293F1',
      blockCreated: 10339206,
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 6507670,
    ),
  },
);

/// Graphite Network (chain id 440017).
final Chain graphite = Chain(
  id: 440017,
  name: 'Graphite Network',
  nativeCurrency: const NativeCurrency(
    name: 'Graphite',
    symbol: '@G',
    decimals: 18,
  ),
  rpcUrls: const ['https://anon-entrypoint-1.atgraphite.com'],
  blockExplorer: const BlockExplorer(
    name: 'Graphite Spectre',
    url: 'https://main.atgraphite.com',
  ),
);

/// Graphite Network Testnet (chain id 54170).
final Chain graphiteTestnet = Chain(
  id: 54170,
  name: 'Graphite Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Graphite',
    symbol: '@G',
    decimals: 18,
  ),
  rpcUrls: const ['https://anon-entrypoint-test-1.atgraphite.com'],
  blockExplorer: const BlockExplorer(
    name: 'Graphite Testnet Spectre',
    url: 'https://test.atgraphite.com',
  ),
);

/// Gravity (chain id 127001).
final Chain grav = Chain(
  id: 127001,
  name: 'Gravity',
  nativeCurrency: const NativeCurrency(
    name: 'Gravity',
    symbol: 'G',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.gravity.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Gravity Mainnet Explorer',
    url: 'https://mainnet-explorer.gravity.xyz',
  ),
);

/// Gravity Alpha Mainnet (chain id 1625).
final Chain gravity = Chain(
  id: 1625,
  name: 'Gravity Alpha Mainnet',
  nativeCurrency: const NativeCurrency(name: 'G', symbol: 'G', decimals: 18),
  rpcUrls: const ['https://rpc.gravity.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Gravity Explorer',
    url: 'https://explorer.gravity.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xf8ac4BEB2F75d2cFFb588c63251347fdD629B92c',
      blockCreated: 16851,
    ),
  },
);

/// Gunz Mainnet (chain id 43419).
final Chain gunz = Chain(
  id: 43419,
  name: 'Gunz Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'GUN',
    symbol: 'GUN',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc.gunzchain.io/ext/bc/2M47TxWHGnhNtq6pM5zPXdATBtuqubxn5EPFgFmEawCQr9WFML/rpc',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Gunz Explorer',
    url: 'https://gunzscan.io/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 70502,
    ),
  },
);

/// Guru Network Mainnet (chain id 260).
final Chain guruNetwork = Chain(
  id: 260,
  name: 'Guru Network Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'GURU Token',
    symbol: 'GURU',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-main.gurunetwork.ai',
    'https://rpc.gurunetwork.ai/archive/260',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Guruscan',
    url: 'https://scan.gurunetwork.ai',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 271691,
    ),
  },
);

/// Guru Network Testnet (chain id 261).
final Chain guruTestnet = Chain(
  id: 261,
  name: 'Guru Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tGURU Token',
    symbol: 'tGURU',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-test.gurunetwork.ai',
    'https://rpc.gurunetwork.ai/archive/261',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Guruscan',
    url: 'https://sepolia.gurunetwork.ai',
  ),
);

/// Ham (chain id 5112).
final Chain ham = Chain(
  id: 5112,
  name: 'Ham',
  nativeCurrency: const NativeCurrency(
    name: 'Ham',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.ham.fun'],
  blockExplorer: const BlockExplorer(
    name: 'Ham Chain Explorer',
    url: 'https://explorer.ham.fun',
  ),
);

/// Happychain Testnet (chain id 216).
final Chain happychainTestnet = Chain(
  id: 216,
  name: 'Happychain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'HAPPY',
    symbol: 'HAPPY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.happy.tech/http'],
  blockExplorer: const BlockExplorer(
    name: 'Happy Chain Testnet Explorer',
    url: 'https://explorer.testnet.happy.tech',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1,
    ),
  },
);

/// HAQQ Mainnet (chain id 11235).
final Chain haqqMainnet = Chain(
  id: 11235,
  name: 'HAQQ Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Islamic Coin',
    symbol: 'ISLM',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.eth.haqq.network'],
  blockExplorer: const BlockExplorer(
    name: 'HAQQ Explorer',
    url: 'https://explorer.haqq.network',
  ),
);

/// HAQQ Testedge 2 (chain id 54211).
final Chain haqqTestedge2 = Chain(
  id: 54211,
  name: 'HAQQ Testedge 2',
  nativeCurrency: const NativeCurrency(
    name: 'Islamic Coin',
    symbol: 'ISLMT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.eth.testedge2.haqq.network'],
  blockExplorer: const BlockExplorer(
    name: 'HAQQ Explorer',
    url: 'https://explorer.testedge2.haqq.network',
  ),
);

/// Hardhat (chain id 31337).
final Chain hardhat = Chain(
  id: 31337,
  name: 'Hardhat',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://127.0.0.1:8545'],
);

/// Harmony One (chain id 1666600000).
final Chain harmonyOne = Chain(
  id: 1666600000,
  name: 'Harmony One',
  nativeCurrency: const NativeCurrency(
    name: 'Harmony',
    symbol: 'ONE',
    decimals: 18,
  ),
  rpcUrls: const ['https://1666600000.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'Harmony Explorer',
    url: 'https://explorer.harmony.one',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 24185753,
    ),
  },
);

/// HashKey Chain (chain id 177).
final Chain hashkey = Chain(
  id: 177,
  name: 'HashKey Chain',
  nativeCurrency: const NativeCurrency(
    name: 'HashKey EcoPoints',
    symbol: 'HSK',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.hsk.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'HashKey Chain Explorer',
    url: 'https://hashkey.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// HashKey Chain Testnet (chain id 133).
final Chain hashkeyTestnet = Chain(
  id: 133,
  name: 'HashKey Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'HashKey EcoPoints',
    symbol: 'HSK',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.hsk.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'HashKey Chain Testnet explorer',
    url: 'https://testnet-explorer.hsk.xyz',
  ),
);

/// Haust Network Testnet (chain id 1523903251).
final Chain haustTestnet = Chain(
  id: 1523903251,
  name: 'Haust Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'HAUST',
    symbol: 'HAUST',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.haust.app'],
  blockExplorer: const BlockExplorer(
    name: 'Haust Network Testnet Explorer',
    url: 'https://explorer-testnet.haust.app',
  ),
);

/// Hedera Mainnet (chain id 295).
final Chain hedera = Chain(
  id: 295,
  name: 'Hedera Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'HBAR',
    symbol: 'HBAR',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.hashio.io/api'],
  blockExplorer: const BlockExplorer(
    name: 'Hashscan',
    url: 'https://hashscan.io/mainnet',
  ),
);

/// Hedera Previewnet (chain id 297).
final Chain hederaPreviewnet = Chain(
  id: 297,
  name: 'Hedera Previewnet',
  nativeCurrency: const NativeCurrency(
    name: 'HBAR',
    symbol: 'HBAR',
    decimals: 18,
  ),
  rpcUrls: const ['https://previewnet.hashio.io/api'],
  blockExplorer: const BlockExplorer(
    name: 'Hashscan',
    url: 'https://hashscan.io/previewnet',
  ),
);

/// Hedera Testnet (chain id 296).
final Chain hederaTestnet = Chain(
  id: 296,
  name: 'Hedera Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'HBAR',
    symbol: 'HBAR',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.hashio.io/api'],
  blockExplorer: const BlockExplorer(
    name: 'Hashscan',
    url: 'https://hashscan.io/testnet',
  ),
);

/// Hela Mainnet (chain id 8668).
final Chain hela = Chain(
  id: 8668,
  name: 'Hela Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'HLUSD',
    symbol: 'HLUSD',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.helachain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Hela explorer',
    url: 'https://mainnet-blockexplorer.helachain.com',
  ),
);

/// Helios Testnet (chain id 42000).
final Chain heliosTestnet = Chain(
  id: 42000,
  name: 'Helios Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Helios',
    symbol: 'HLS',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet1.helioschainlabs.org'],
  blockExplorer: const BlockExplorer(
    name: 'Helios Testnet Explorer',
    url: 'https://explorer.helioschainlabs.org/',
  ),
);

/// Hemi (chain id 43111).
final Chain hemi = Chain(
  id: 43111,
  name: 'Hemi',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hemi.network/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.hemi.xyz',
  ),
);

/// Hemi Sepolia (chain id 743111).
final Chain hemiSepolia = Chain(
  id: 743111,
  name: 'Hemi Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.rpc.hemi.network/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Hemi Sepolia explorer',
    url: 'https://testnet.explorer.hemi.xyz',
  ),
);

/// Henesys (chain id 68414).
final Chain henesys = Chain(
  id: 68414,
  name: 'Henesys',
  nativeCurrency: const NativeCurrency(
    name: 'NEXPACE',
    symbol: 'NXPC',
    decimals: 18,
  ),
  rpcUrls: const ['https://henesys-rpc.msu.io'],
  blockExplorer: const BlockExplorer(
    name: 'Avalanche Explorer',
    url: 'https://subnets.avax.network/henesys',
  ),
);

/// Holesky (chain id 17000).
final Chain holesky = Chain(
  id: 17000,
  name: 'Holesky',
  nativeCurrency: const NativeCurrency(
    name: 'Holesky Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://ethereum-holesky-rpc.publicnode.com'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://holesky.etherscan.io',
  ),
  contracts: const {
    'ensUniversalResolver': ChainContract(
      address: '0xeeeeeeee14d718c2b47d9923deab1335e144eeee',
      blockCreated: 4295055,
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 77,
    ),
  },
);

/// Hoodi (chain id 560048).
final Chain hoodi = Chain(
  id: 560048,
  name: 'Hoodi',
  nativeCurrency: const NativeCurrency(
    name: 'Hoodi Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hoodi.ethpandaops.io'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://hoodi.etherscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2589,
    ),
  },
);

/// Horizen Testnet (chain id 2651420).
final Chain horizenTestnet = Chain(
  id: 2651420,
  name: 'Horizen Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://horizen-testnet.rpc.caldera.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Horizen Testnet Caldera Explorer',
    url: 'https://horizen-testnet.explorer.caldera.xyz',
  ),
);

/// High Performance Blockchain (chain id 269).
final Chain hpb = Chain(
  id: 269,
  name: 'High Performance Blockchain',
  nativeCurrency: const NativeCurrency(
    name: 'HPB',
    symbol: 'HPB',
    decimals: 18,
  ),
  rpcUrls: const ['https://hpbnode.com'],
  blockExplorer: const BlockExplorer(name: 'hpbScan', url: 'https://hscan.org'),
);

/// HPP Mainnet (chain id 190415).
final Chain hpp = Chain(
  id: 190415,
  name: 'HPP Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.hpp.io'],
  blockExplorer: const BlockExplorer(
    name: 'HPP Mainnet Explorer',
    url: 'https://explorer.hpp.io',
  ),
);

/// HPP Sepolia (chain id 181228).
final Chain hppSepolia = Chain(
  id: 181228,
  name: 'HPP Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.hpp.io'],
  blockExplorer: const BlockExplorer(
    name: 'HPP Sepolia Explorer',
    url: 'https://sepolia-explorer.hpp.io',
  ),
);

/// Huddle01 dRTC Chain (chain id 12323).
final Chain huddle01Mainnet = Chain(
  id: 12323,
  name: 'Huddle01 dRTC Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Ethereum',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://huddle01.calderachain.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Huddle01 Caldera Explorer',
    url: 'https://huddle01.calderaexplorer.xyz',
  ),
);

/// Huddle01 dRTC Chain Testnet (chain id 2524852).
final Chain huddle01Testnet = Chain(
  id: 2524852,
  name: 'Huddle01 dRTC Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ethereum',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://huddle-testnet.rpc.caldera.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Huddle01 Caldera Explorer',
    url: 'https://huddle-testnet.explorer.caldera.xyz',
  ),
);

/// Humanity (chain id 6985385).
final Chain humanity = Chain(
  id: 6985385,
  name: 'Humanity',
  nativeCurrency: const NativeCurrency(name: 'H', symbol: 'H', decimals: 18),
  rpcUrls: const ['https://humanity-mainnet.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Humanity Mainnet Explorer',
    url: 'https://humanity-mainnet.explorer.alchemy.com',
  ),
);

/// Humanity Testnet (chain id 7080969).
final Chain humanityTestnet = Chain(
  id: 7080969,
  name: 'Humanity Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tHP',
    symbol: 'tHP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.humanity.org'],
  blockExplorer: const BlockExplorer(
    name: 'Humanity Testnet Explorer',
    url: 'https://humanity-testnet.explorer.alchemy.com',
  ),
);

/// Humanode (chain id 5234).
final Chain humanode = Chain(
  id: 5234,
  name: 'Humanode',
  nativeCurrency: const NativeCurrency(
    name: 'HMND',
    symbol: 'HMND',
    decimals: 18,
  ),
  rpcUrls: const ['https://explorer-rpc-http.mainnet.stages.humanode.io'],
  blockExplorer: const BlockExplorer(
    name: 'Subscan',
    url: 'https://humanode.subscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 4413097,
    ),
  },
);

/// Humanode Testnet 5 (chain id 14853).
final Chain humanodeTestnet5 = Chain(
  id: 14853,
  name: 'Humanode Testnet 5',
  nativeCurrency: const NativeCurrency(
    name: 'HMND',
    symbol: 'HMND',
    decimals: 18,
  ),
  rpcUrls: const ['https://explorer-rpc-http.testnet5.stages.humanode.io'],
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// HYCHAIN (chain id 2911).
final Chain hychain = Chain(
  id: 2911,
  name: 'HYCHAIN',
  nativeCurrency: const NativeCurrency(
    name: 'HYTOPIA',
    symbol: 'TOPIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hychain.com/http'],
  blockExplorer: const BlockExplorer(
    name: 'HYCHAIN Explorer',
    url: 'https://explorer.hychain.com',
  ),
);

/// HYCHAIN Testnet (chain id 29112).
final Chain hychainTestnet = Chain(
  id: 29112,
  name: 'HYCHAIN Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'HYTOPIA',
    symbol: 'TOPIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hychain.com/http'],
  blockExplorer: const BlockExplorer(
    name: 'HYCHAIN Explorer',
    url: 'https://testnet-rpc.hychain.com/http',
  ),
);

/// HyperEVM (chain id 999).
final Chain hyperEvm = Chain(
  id: 999,
  name: 'HyperEVM',
  nativeCurrency: const NativeCurrency(
    name: 'HYPE',
    symbol: 'HYPE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hyperliquid.xyz/evm'],
  blockExplorer: const BlockExplorer(
    name: 'HyperEVMScan',
    url: 'https://hyperevmscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 13051,
    ),
  },
);

/// Hyperliquid EVM Testnet (chain id 998).
final Chain hyperliquidEvmTestnet = Chain(
  id: 998,
  name: 'Hyperliquid EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'HYPE',
    symbol: 'HYPE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hyperliquid-testnet.xyz/evm'],
);

/// iSunCoin Mainnet (chain id 8017).
final Chain iSunCoin = Chain(
  id: 8017,
  name: 'iSunCoin Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ISC',
    symbol: 'ISC',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.isuncoin.com'],
  blockExplorer: const BlockExplorer(
    name: 'iSunCoin Explorer',
    url: 'https://baifa.io/app/chains/8017',
  ),
);

/// ICB Network (chain id 73115).
final Chain icbNetwork = Chain(
  id: 73115,
  name: 'ICB Network',
  nativeCurrency: const NativeCurrency(
    name: 'ICB Native Token',
    symbol: 'ICBX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc1-mainnet.icbnetwork.info'],
  blockExplorer: const BlockExplorer(
    name: 'ICB Explorer',
    url: 'https://icbscan.io',
  ),
);

/// IDChain Mainnet (chain id 74).
final Chain idchain = Chain(
  id: 74,
  name: 'IDChain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'EIDI',
    symbol: 'EIDI',
    decimals: 18,
  ),
  rpcUrls: const ['https://idchain.one/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'IDChain Explorer',
    url: 'https://explorer.idchain.one',
  ),
);

/// Igra Network (chain id 38833).
final Chain igra = Chain(
  id: 38833,
  name: 'Igra Network',
  nativeCurrency: const NativeCurrency(
    name: 'iKAS',
    symbol: 'iKAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.igralabs.com:8545'],
  blockExplorer: const BlockExplorer(
    name: 'Igra Explorer',
    url: 'https://explorer.igralabs.com',
  ),
);

/// Immutable zkEVM (chain id 13371).
final Chain immutableZkEvm = Chain(
  id: 13371,
  name: 'Immutable zkEVM',
  nativeCurrency: const NativeCurrency(
    name: 'Immutable Coin',
    symbol: 'IMX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.immutable.com'],
  blockExplorer: const BlockExplorer(
    name: 'Immutable Explorer',
    url: 'https://explorer.immutable.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x236bdA4589e44e6850f5aC6a74BfCa398a86c6c0',
      blockCreated: 4335972,
    ),
  },
);

/// Immutable zkEVM Testnet (chain id 13473).
final Chain immutableZkEvmTestnet = Chain(
  id: 13473,
  name: 'Immutable zkEVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Immutable Coin',
    symbol: 'IMX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.immutable.com'],
  blockExplorer: const BlockExplorer(
    name: 'Immutable Testnet Explorer',
    url: 'https://explorer.testnet.immutable.com/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x2CC787Ed364600B0222361C4188308Fa8E68bA60',
      blockCreated: 5977391,
    ),
  },
);

/// inEVM Mainnet (chain id 2525).
final Chain inEVM = Chain(
  id: 2525,
  name: 'inEVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Injective',
    symbol: 'INJ',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.rpc.inevm.com/http'],
  blockExplorer: const BlockExplorer(
    name: 'inEVM Explorer',
    url: 'https://inevm.calderaexplorer.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 118606,
    ),
  },
);

/// InitVerse Mainnet (chain id 7233).
final Chain initVerse = Chain(
  id: 7233,
  name: 'InitVerse Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'InitVerse',
    symbol: 'INI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-mainnet.inichain.com'],
  blockExplorer: const BlockExplorer(
    name: 'InitVerseScan',
    url: 'https://www.iniscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x83466BE48A067115FFF91f7b892Ed1726d032e47',
      blockCreated: 2318,
    ),
  },
);

/// InitVerse Genesis Testnet (chain id 7234).
final Chain initVerseGenesis = Chain(
  id: 7234,
  name: 'InitVerse Genesis Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'InitVerse',
    symbol: 'INI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.inichain.com'],
  blockExplorer: const BlockExplorer(
    name: 'InitVerseGenesisScan',
    url: 'https://genesis-testnet.iniscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0cF32CBDd6c437331EA4f85ed2d881A5379B5a6F',
      blockCreated: 16361,
    ),
  },
);

/// Injective (chain id 1776).
final Chain injective = Chain(
  id: 1776,
  name: 'Injective',
  nativeCurrency: const NativeCurrency(
    name: 'Injective',
    symbol: 'INJ',
    decimals: 18,
  ),
  rpcUrls: const ['https://sentry.evm-rpc.injective.network'],
  blockExplorer: const BlockExplorer(
    name: 'Injective Explorer',
    url: 'https://blockscout.injective.network',
  ),
);

/// Injective Testnet (chain id 1439).
final Chain injectiveTestnet = Chain(
  id: 1439,
  name: 'Injective Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Injective',
    symbol: 'INJ',
    decimals: 18,
  ),
  rpcUrls: const ['https://k8s.testnet.json-rpc.injective.network'],
  blockExplorer: const BlockExplorer(
    name: 'Injective Explorer',
    url: 'https://testnet.blockscout.injective.network',
  ),
);

/// Ink (chain id 57073).
final Chain ink = Chain(
  id: 57073,
  name: 'Ink',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-gel.inkonchain.com',
    'https://rpc-qnd.inkonchain.com',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.inkonchain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Ink Sepolia (chain id 763373).
final Chain inkSepolia = Chain(
  id: 763373,
  name: 'Ink Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-gel-sepolia.inkonchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer-sepolia.inkonchain.com/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// IOTA EVM (chain id 8822).
final Chain iota = Chain(
  id: 8822,
  name: 'IOTA EVM',
  nativeCurrency: const NativeCurrency(
    name: 'IOTA',
    symbol: 'IOTA',
    decimals: 18,
  ),
  rpcUrls: const ['https://json-rpc.evm.iotaledger.net'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://explorer.evm.iota.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 25022,
    ),
  },
);

/// IOTA EVM Testnet (chain id 1075).
final Chain iotaTestnet = Chain(
  id: 1075,
  name: 'IOTA EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'IOTA',
    symbol: 'IOTA',
    decimals: 18,
  ),
  rpcUrls: const ['https://json-rpc.evm.testnet.iotaledger.net'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://explorer.evm.testnet.iotaledger.net',
  ),
);

/// IoTeX (chain id 4689).
final Chain iotex = Chain(
  id: 4689,
  name: 'IoTeX',
  nativeCurrency: const NativeCurrency(
    name: 'IoTeX',
    symbol: 'IOTX',
    decimals: 18,
  ),
  rpcUrls: const ['https://babel-api.mainnet.iotex.io'],
  blockExplorer: const BlockExplorer(
    name: 'IoTeXScan',
    url: 'https://iotexscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 22163670,
    ),
  },
);

/// IoTeX Testnet (chain id 4690).
final Chain iotexTestnet = Chain(
  id: 4690,
  name: 'IoTeX Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'IoTeX',
    symbol: 'IOTX',
    decimals: 18,
  ),
  rpcUrls: const ['https://babel-api.testnet.iotex.io'],
  blockExplorer: const BlockExplorer(
    name: 'IoTeXScan',
    url: 'https://testnet.iotexscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xb5cecD6894c6f473Ec726A176f1512399A2e355d',
      blockCreated: 24347592,
    ),
  },
);

/// Jasmy Chain (chain id 680).
final Chain jasmyChain = Chain(
  id: 680,
  name: 'Jasmy Chain',
  nativeCurrency: const NativeCurrency(
    name: 'JasmyCoin',
    symbol: 'JASMY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.jasmychain.io'],
);

/// Jasmy Chain Testnet (chain id 681).
final Chain jasmyChainTestnet = Chain(
  id: 681,
  name: 'Jasmy Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'JasmyCoin',
    symbol: 'JASMY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc_testnet.jasmychain.io'],
);

/// JB Chain (chain id 8899).
final Chain jbc = Chain(
  id: 8899,
  name: 'JB Chain',
  nativeCurrency: const NativeCurrency(
    name: 'JBC',
    symbol: 'JBC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-l1.jibchain.net'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://exp-l1.jibchain.net',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xc0C8C486D1466C57Efe13C2bf000d4c56F47CBdC',
      blockCreated: 2299048,
    ),
  },
);

/// Jibchain Testnet (chain id 88991).
final Chain jbcTestnet = Chain(
  id: 88991,
  name: 'Jibchain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tJBC',
    symbol: 'tJBC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.jibchain.net'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://exp.testnet.jibchain.net',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xa1a858ad9041B4741e620355a3F96B3c78e70ecE',
      blockCreated: 32848,
    ),
  },
);

/// Japan Open Chain Mainnet (chain id 81).
final Chain jocMainnet = Chain(
  id: 81,
  name: 'Japan Open Chain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Japan Open Chain Token',
    symbol: 'JOC',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-1.japanopenchain.org:8545',
    'https://rpc-2.japanopenchain.org:8545',
    'https://rpc-3.japanopenchain.org',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Block Explorer',
    url: 'https://explorer.japanopenchain.org',
  ),
);

/// Japan Open Chain Testnet (chain id 10081).
final Chain jocTestnet = Chain(
  id: 10081,
  name: 'Japan Open Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Japan Open Chain Testnet Token',
    symbol: 'JOCT',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-1.testnet.japanopenchain.org:8545',
    'https://rpc-2.testnet.japanopenchain.org:8545',
    'https://rpc-3.testnet.japanopenchain.org',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Testnet Block Explorer',
    url: 'https://explorer.testnet.japanopenchain.org',
  ),
);

/// Jovay Mainnet (chain id 5734951).
final Chain jovay = Chain(
  id: 5734951,
  name: 'Jovay Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.jovay.io'],
  blockExplorer: const BlockExplorer(
    name: 'Jovay Explorer',
    url: 'https://explorer.jovay.io/l2',
  ),
);

/// Jovay Sepolia Testnet (chain id 2019775).
final Chain jovaySepolia = Chain(
  id: 2019775,
  name: 'Jovay Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.zan.top/public/jovay-testnet'],
  blockExplorer: const BlockExplorer(
    name: 'Jovay Testnet Explorer',
    url: 'https://sepolia-explorer.jovay.io/l2',
  ),
);

/// Juneo JUNE-Chain (chain id 45003).
final Chain juneo = Chain(
  id: 45003,
  name: 'Juneo JUNE-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'JUNE-Chain',
    symbol: 'JUNE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/JUNE/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/2',
  ),
);

/// Juneo BCH1-Chain (chain id 45013).
final Chain juneoBCH1Chain = Chain(
  id: 45013,
  name: 'Juneo BCH1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo BCH1-Chain',
    symbol: 'BCH1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/BCH1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/12',
  ),
);

/// Juneo DAI1-Chain (chain id 45004).
final Chain juneoDAI1Chain = Chain(
  id: 45004,
  name: 'Juneo DAI1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo DAI1-Chain',
    symbol: 'DAI1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/DAI1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/5',
  ),
);

/// Juneo DOGE1-Chain (chain id 45010).
final Chain juneoDOGE1Chain = Chain(
  id: 45010,
  name: 'Juneo DOGE1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo DOGE1-Chain',
    symbol: 'DOGE1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/DOGE1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/10',
  ),
);

/// Juneo EUR1-Chain (chain id 45011).
final Chain juneoEUR1Chain = Chain(
  id: 45011,
  name: 'Juneo EUR1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo EUR1-Chain',
    symbol: 'EUR1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/EUR1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/6',
  ),
);

/// Juneo GLD1-Chain (chain id 45008).
final Chain juneoGLD1Chain = Chain(
  id: 45008,
  name: 'Juneo GLD1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo GLD1-Chain',
    symbol: 'GLD1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/GLD1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/8',
  ),
);

/// Juneo LINK1-Chain (chain id 45014).
final Chain juneoLINK1Chain = Chain(
  id: 45014,
  name: 'Juneo LINK1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo LINK1-Chain',
    symbol: 'LINK1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/LINK1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/13',
  ),
);

/// Juneo LTC1-Chain (chain id 45009).
final Chain juneoLTC1Chain = Chain(
  id: 45009,
  name: 'Juneo LTC1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo LTC1-Chain',
    symbol: 'LTC1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/LTC1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/11',
  ),
);

/// Juneo SGD1-Chain (chain id 45012).
final Chain juneoSGD1Chain = Chain(
  id: 45012,
  name: 'Juneo SGD1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo SGD1-Chain',
    symbol: 'SGD1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/SGD1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/7',
  ),
);

/// Socotra JUNE-Chain (chain id 101003).
final Chain juneoSocotraTestnet = Chain(
  id: 101003,
  name: 'Socotra JUNE-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Socotra JUNE-Chain',
    symbol: 'JUNE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.socotra-testnet.network/ext/bc/JUNE/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://socotra.juneoscan.io/chain/2',
  ),
);

/// Juneo USD1-Chain (chain id 45006).
final Chain juneoUSD1Chain = Chain(
  id: 45006,
  name: 'Juneo USD1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo USD1-Chain',
    symbol: 'USD1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/USD1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/4',
  ),
);

/// Juneo USDT1-Chain (chain id 45005).
final Chain juneoUSDT1Chain = Chain(
  id: 45005,
  name: 'Juneo USDT1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo USDT1-Chain',
    symbol: 'USDT1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/USDT1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/3',
  ),
);

/// Juneo mBTC1-Chain (chain id 45007).
final Chain juneomBTC1Chain = Chain(
  id: 45007,
  name: 'Juneo mBTC1-Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Juneo mBTC1-Chain',
    symbol: 'mBTC1',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.juneo-mainnet.network/ext/bc/mBTC1/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Juneo Scan',
    url: 'https://juneoscan.io/chain/9',
  ),
);

/// Kaia (chain id 8217).
final Chain kaia = Chain(
  id: 8217,
  name: 'Kaia',
  nativeCurrency: const NativeCurrency(
    name: 'Kaia',
    symbol: 'KAIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-en.node.kaia.io'],
  blockExplorer: const BlockExplorer(
    name: 'KaiaScan',
    url: 'https://kaiascan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 96002415,
    ),
  },
);

/// Kairos Testnet (chain id 1001).
final Chain kairos = Chain(
  id: 1001,
  name: 'Kairos Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Kairos KAIA',
    symbol: 'KAIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-en-kairos.node.kaia.io'],
  blockExplorer: const BlockExplorer(
    name: 'KaiaScan',
    url: 'https://kairos.kaiascan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 123390593,
    ),
  },
);

/// Kakarot Sepolia (chain id 1802203764).
final Chain kakarotSepolia = Chain(
  id: 1802203764,
  name: 'Kakarot Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia-rpc.kakarot.org'],
  blockExplorer: const BlockExplorer(
    name: 'Kakarot Scan',
    url: 'https://sepolia.kakarotscan.org',
  ),
);

/// Kakarot Starknet Sepolia (chain id 920637907288165).
final Chain kakarotStarknetSepolia = Chain(
  id: 920637907288165,
  name: 'Kakarot Starknet Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia-rpc.kakarot.org'],
  blockExplorer: const BlockExplorer(
    name: 'Kakarot Scan',
    url: 'https://sepolia.kakarotscan.org',
  ),
);

/// KardiaChain Mainnet (chain id 24).
final Chain kardiaChain = Chain(
  id: 24,
  name: 'KardiaChain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'KAI',
    symbol: 'KAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.kardiachain.io'],
  blockExplorer: const BlockExplorer(
    name: 'KardiaChain Explorer',
    url: 'https://explorer.kardiachain.io',
  ),
);

/// Karura (chain id 686).
final Chain karura = Chain(
  id: 686,
  name: 'Karura',
  nativeCurrency: const NativeCurrency(
    name: 'Karura',
    symbol: 'KAR',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc-karura.aca-api.network'],
  blockExplorer: const BlockExplorer(
    name: 'Karura Blockscout',
    url: 'https://blockscout.karura.network',
  ),
);

/// Katana (chain id 747474).
final Chain katana = Chain(
  id: 747474,
  name: 'Katana',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.katana.network'],
  blockExplorer: const BlockExplorer(
    name: 'katana explorer',
    url: 'https://katanascan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Kava EVM (chain id 2222).
final Chain kava = Chain(
  id: 2222,
  name: 'Kava EVM',
  nativeCurrency: const NativeCurrency(
    name: 'Kava',
    symbol: 'KAVA',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.kava.io'],
  blockExplorer: const BlockExplorer(
    name: 'Kava EVM Explorer',
    url: 'https://kavascan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 3661165,
    ),
  },
);

/// Kava EVM Testnet (chain id 2221).
final Chain kavaTestnet = Chain(
  id: 2221,
  name: 'Kava EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Kava',
    symbol: 'KAVA',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.testnet.kava.io'],
  blockExplorer: const BlockExplorer(
    name: 'Kava EVM Testnet Explorer',
    url: 'https://testnet.kavascan.com/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xDf1D724A7166261eEB015418fe8c7679BBEa7fd6',
      blockCreated: 7242179,
    ),
  },
);

/// KCC Mainnet (chain id 321).
final Chain kcc = Chain(
  id: 321,
  name: 'KCC Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'KCS',
    symbol: 'KCS',
    decimals: 18,
  ),
  rpcUrls: const ['https://kcc-rpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'KCC Explorer',
    url: 'https://explorer.kcc.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 11760430,
    ),
  },
);

/// KiiChain (chain id 1783).
final Chain kii = Chain(
  id: 1783,
  name: 'KiiChain',
  nativeCurrency: const NativeCurrency(
    name: 'Kii',
    symbol: 'KII',
    decimals: 18,
  ),
  rpcUrls: const ['https://json-rpc.kiivalidator.com'],
  blockExplorer: const BlockExplorer(
    name: 'KiiExplorer',
    url: 'https://explorer.kiichain.io',
  ),
);

/// Kii Testnet Oro (chain id 1336).
final Chain kiiTestnetOro = Chain(
  id: 1336,
  name: 'Kii Testnet Oro',
  nativeCurrency: const NativeCurrency(
    name: 'Kii',
    symbol: 'KII',
    decimals: 18,
  ),
  rpcUrls: const ['https://json-rpc.uno.sentry.testnet.v3.kiivalidator.com'],
  blockExplorer: const BlockExplorer(
    name: 'KiiExplorer',
    url: 'https://testnet.explorer.kiichain.io',
  ),
);

/// Kinto Mainnet (chain id 7887).
final Chain kinto = Chain(
  id: 7887,
  name: 'Kinto Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.kinto.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Kinto Explorer',
    url: 'https://explorer.kinto.xyz',
  ),
);

/// Klaytn (chain id 8217).
final Chain klaytn = Chain(
  id: 8217,
  name: 'Klaytn',
  nativeCurrency: const NativeCurrency(
    name: 'Klaytn',
    symbol: 'KLAY',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-en-cypress.klaytn.net'],
  blockExplorer: const BlockExplorer(
    name: 'KlaytnScope',
    url: 'https://scope.klaytn.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 96002415,
    ),
  },
);

/// Klaytn Baobab Testnet (chain id 1001).
final Chain klaytnBaobab = Chain(
  id: 1001,
  name: 'Klaytn Baobab Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Baobab Klaytn',
    symbol: 'KLAY',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-en-baobab.klaytn.net'],
  blockExplorer: const BlockExplorer(
    name: 'KlaytnScope',
    url: 'https://baobab.klaytnscope.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 123390593,
    ),
  },
);

/// Koi Network (chain id 701).
final Chain koi = Chain(
  id: 701,
  name: 'Koi Network',
  nativeCurrency: const NativeCurrency(
    name: 'Koi Network Native Token',
    symbol: 'KRING',
    decimals: 18,
  ),
  rpcUrls: const ['https://koi-rpc.darwinia.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://koi-scan.darwinia.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 180001,
    ),
  },
);

/// Kroma (chain id 255).
final Chain kroma = Chain(
  id: 255,
  name: 'Kroma',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.kroma.network'],
  blockExplorer: const BlockExplorer(
    name: 'Kroma Explorer',
    url: 'https://blockscout.kroma.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 16054868,
    ),
  },
);

/// Kroma Sepolia (chain id 2358).
final Chain kromaSepolia = Chain(
  id: 2358,
  name: 'Kroma Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.sepolia.kroma.network'],
  blockExplorer: const BlockExplorer(
    name: 'Kroma Sepolia Explorer',
    url: 'https://blockscout.sepolia.kroma.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 8900914,
    ),
  },
);

/// Krown (chain id 1983).
final Chain krown = Chain(
  id: 1983,
  name: 'Krown',
  nativeCurrency: const NativeCurrency(
    name: 'Krown',
    symbol: 'KROWN',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.krown.network'],
  blockExplorer: const BlockExplorer(
    name: 'Krown Explorer',
    url: 'https://explorer.krown.network',
  ),
);

/// L3X Protocol (chain id 12324).
final Chain l3x = Chain(
  id: 12324,
  name: 'L3X Protocol',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-mainnet.l3x.com'],
  blockExplorer: const BlockExplorer(
    name: 'L3X Mainnet Explorer',
    url: 'https://explorer.l3x.com',
  ),
);

/// L3X Protocol Testnet (chain id 12325).
final Chain l3xTestnet = Chain(
  id: 12325,
  name: 'L3X Protocol Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.l3x.com'],
  blockExplorer: const BlockExplorer(
    name: 'L3X Testnet Explorer',
    url: 'https://explorer-testnet.l3x.com',
  ),
);

/// LadyChain (chain id 589).
final Chain ladyChain = Chain(
  id: 589,
  name: 'LadyChain',
  nativeCurrency: const NativeCurrency(
    name: 'Lady',
    symbol: 'LADY',
    decimals: 18,
  ),
  rpcUrls: const ['https://ladyrpc.us/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'LadyScan',
    url: 'https://ladyscan.us',
  ),
);

/// LAVITA Mainnet (chain id 360890).
final Chain lavita = Chain(
  id: 360890,
  name: 'LAVITA Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'vTFUEL',
    symbol: 'vTFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://tsub360890-eth-rpc.thetatoken.org/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'LAVITA Explorer',
    url: 'https://tsub360890-explorer.thetatoken.org',
  ),
);

/// Lens (chain id 232).
final Chain lens = Chain(
  id: 232,
  name: 'Lens',
  nativeCurrency: const NativeCurrency(
    name: 'GHO',
    symbol: 'GHO',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.lens.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Lens Block Explorer',
    url: 'https://explorer.lens.xyz',
  ),
);

/// Lens Testnet (chain id 37111).
final Chain lensTestnet = Chain(
  id: 37111,
  name: 'Lens Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'GRASS',
    symbol: 'GRASS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.lens.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Lens Block Explorer',
    url: 'https://block-explorer.testnet.lens.dev',
  ),
);

/// Lestnet (chain id 21363).
final Chain lestnet = Chain(
  id: 21363,
  name: 'Lestnet',
  nativeCurrency: const NativeCurrency(
    name: 'Lestnet Ether',
    symbol: 'LETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://service.lestnet.org'],
  blockExplorer: const BlockExplorer(
    name: 'Lestnet Explorer',
    url: 'https://explore.lestnet.org',
  ),
);

/// LightLink Pegasus Testnet (chain id 1891).
final Chain lightlinkPegasus = Chain(
  id: 1891,
  name: 'LightLink Pegasus Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://replicator.pegasus.lightlink.io/rpc/v1'],
  blockExplorer: const BlockExplorer(
    name: 'LightLink Pegasus Explorer',
    url: 'https://pegasus.lightlink.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 127188532,
    ),
  },
);

/// LightLink Phoenix Mainnet (chain id 1890).
final Chain lightlinkPhoenix = Chain(
  id: 1890,
  name: 'LightLink Phoenix Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://replicator.phoenix.lightlink.io/rpc/v1'],
  blockExplorer: const BlockExplorer(
    name: 'LightLink Phoenix Explorer',
    url: 'https://phoenix.lightlink.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 125499184,
    ),
  },
);

/// Linea Mainnet (chain id 59144).
final Chain linea = Chain(
  id: 59144,
  name: 'Linea Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Linea Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.linea.build'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://lineascan.build',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x50130b669B28C339991d8676FA73CF122a121267',
      blockCreated: 6682888,
    ),
    'ensUniversalResolver': ChainContract(
      address: '0x4D41762915F83c76EcaF6776d9b08076aA32b492',
      blockCreated: 22222151,
    ),
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 42,
    ),
  },
);

/// Linea Goerli Testnet (chain id 59140).
final Chain lineaGoerli = Chain(
  id: 59140,
  name: 'Linea Goerli Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Linea Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.goerli.linea.build'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://goerli.lineascan.build',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 498623,
    ),
  },
);

/// Linea Sepolia Testnet (chain id 59141).
final Chain lineaSepolia = Chain(
  id: 59141,
  name: 'Linea Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Linea Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sepolia.linea.build'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://sepolia.lineascan.build',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x5B2636F0f2137B4aE722C01dd5122D7d3e9541f7',
      blockCreated: 2395094,
    ),
    'ensUniversalResolver': ChainContract(
      address: '0x4D41762915F83c76EcaF6776d9b08076aA32b492',
      blockCreated: 17168484,
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 227427,
    ),
  },
);

/// Linea Goerli Testnet (chain id 59140).
final Chain lineaTestnet = Chain(
  id: 59140,
  name: 'Linea Goerli Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Linea Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.goerli.linea.build'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://goerli.lineascan.build',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 498623,
    ),
  },
);

/// Lisk (chain id 1135).
final Chain lisk = Chain(
  id: 1135,
  name: 'Lisk',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.api.lisk.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout.lisk.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xA9d71E1dd7ca26F26e656E66d6AA81ed7f745bf0',
    ),
  },
);

/// Lisk Sepolia (chain id 4202).
final Chain liskSepolia = Chain(
  id: 4202,
  name: 'Lisk Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sepolia-api.lisk.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://sepolia-blockscout.lisk.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Load Alphanet (chain id 9496).
final Chain loadAlphanet = Chain(
  id: 9496,
  name: 'Load Alphanet',
  nativeCurrency: const NativeCurrency(
    name: 'Testnet LOAD',
    symbol: 'tLOAD',
    decimals: 18,
  ),
  rpcUrls: const ['https://alphanet.load.network'],
  blockExplorer: const BlockExplorer(
    name: 'Load Alphanet Explorer',
    url: 'https://explorer.load.network',
  ),
);

/// Localhost (chain id 1337).
final Chain localhost = Chain(
  id: 1337,
  name: 'Localhost',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://127.0.0.1:8545'],
);

/// LoopNetwork Mainnet (chain id 15551).
final Chain loop = Chain(
  id: 15551,
  name: 'LoopNetwork Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'LOOP',
    symbol: 'LOOP',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.mainnetloop.com'],
  blockExplorer: const BlockExplorer(
    name: 'LoopNetwork Blockchain Explorer',
    url: 'https://explorer.mainnetloop.com/',
  ),
);

/// LUKSO (chain id 42).
final Chain lukso = Chain(
  id: 42,
  name: 'LUKSO',
  nativeCurrency: const NativeCurrency(
    name: 'LUKSO',
    symbol: 'LYX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.lukso.network'],
  blockExplorer: const BlockExplorer(
    name: 'LUKSO Mainnet Explorer',
    url: 'https://explorer.execution.mainnet.lukso.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 468183,
    ),
  },
);

/// LUKSO Testnet (chain id 4201).
final Chain luksoTestnet = Chain(
  id: 4201,
  name: 'LUKSO Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'LUKSO Testnet',
    symbol: 'LYXt',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.lukso.network'],
  blockExplorer: const BlockExplorer(
    name: 'LUKSO Testnet Explorer',
    url: 'https://explorer.execution.testnet.lukso.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 605348,
    ),
  },
);

/// Lumia Mainnet (chain id 994873017).
final Chain lumiaMainnet = Chain(
  id: 994873017,
  name: 'Lumia Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Lumia',
    symbol: 'LUMIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.lumia.org'],
  blockExplorer: const BlockExplorer(
    name: 'Lumia Explorer',
    url: 'https://explorer.lumia.org/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3975939,
    ),
  },
);

/// Lumia Testnet (chain id 1952959480).
final Chain lumiaTestnet = Chain(
  id: 1952959480,
  name: 'Lumia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Lumia',
    symbol: 'LUMIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.lumia.org'],
  blockExplorer: const BlockExplorer(
    name: 'Lumia Testnet Explorer',
    url: 'https://testnet-explorer.lumia.org/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2235063,
    ),
  },
);

/// Lumoz (chain id 96370).
final Chain lumoz = Chain(
  id: 96370,
  name: 'Lumoz',
  nativeCurrency: const NativeCurrency(
    name: 'Lumoz Token',
    symbol: 'MOZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.lumoz.org'],
  blockExplorer: const BlockExplorer(
    name: 'Lumoz Scan',
    url: 'https://scan.lumoz.info',
  ),
);

/// Lumoz Testnet (chain id 105363).
final Chain lumozTestnet = Chain(
  id: 105363,
  name: 'Lumoz Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Lumoz Testnet Token',
    symbol: 'MOZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.lumoz.org'],
);

/// LuxePorts (chain id 1122).
final Chain luxeports = Chain(
  id: 1122,
  name: 'LuxePorts',
  nativeCurrency: const NativeCurrency(
    name: 'LuxePorts',
    symbol: 'LXP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.luxeports.com', 'https://erpc.luxeports.com'],
  blockExplorer: const BlockExplorer(
    name: 'LXPScan',
    url: 'https://lxpscan.com',
  ),
);

/// Lycan (chain id 721).
final Chain lycan = Chain(
  id: 721,
  name: 'Lycan',
  nativeCurrency: const NativeCurrency(
    name: 'Lycan',
    symbol: 'LYC',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc.lycanchain.com',
    'https://us-east.lycanchain.com',
    'https://us-west.lycanchain.com',
    'https://eu-north.lycanchain.com',
    'https://eu-west.lycanchain.com',
    'https://asia-southeast.lycanchain.com',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Lycan Explorer',
    url: 'https://explorer.lycanchain.com',
  ),
);

/// Lyra Chain (chain id 957).
final Chain lyra = Chain(
  id: 957,
  name: 'Lyra Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.lyra.finance'],
  blockExplorer: const BlockExplorer(
    name: 'Lyra Explorer',
    url: 'https://explorer.lyra.finance',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1935198,
    ),
  },
);

/// Ethereum (chain id 1).
final Chain mainnet = Chain(
  id: 1,
  name: 'Ethereum',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://ethereum.reth.rs/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://etherscan.io',
  ),
  contracts: const {
    'ensUniversalResolver': ChainContract(
      address: '0xeeeeeeee14d718c2b47d9923deab1335e144eeee',
      blockCreated: 23085558,
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 14353601,
    ),
  },
);

/// Mandala TC9 (chain id 595).
final Chain mandala = Chain(
  id: 595,
  name: 'Mandala TC9',
  nativeCurrency: const NativeCurrency(
    name: 'Mandala',
    symbol: 'mACA',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc-tc9.aca-staging.network'],
  blockExplorer: const BlockExplorer(
    name: 'Mandala Blockscout',
    url: 'https://blockscout.mandala.aca-staging.network',
  ),
);

/// Manta Pacific Mainnet (chain id 169).
final Chain manta = Chain(
  id: 169,
  name: 'Manta Pacific Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://pacific-rpc.manta.network/http'],
  blockExplorer: const BlockExplorer(
    name: 'Manta Explorer',
    url: 'https://pacific-explorer.manta.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 332890,
    ),
  },
);

/// Manta Pacific Sepolia Testnet (chain id 3441006).
final Chain mantaSepoliaTestnet = Chain(
  id: 3441006,
  name: 'Manta Pacific Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://pacific-rpc.sepolia-testnet.manta.network/http'],
  blockExplorer: const BlockExplorer(
    name: 'Manta Sepolia Testnet Explorer',
    url: 'https://pacific-explorer.sepolia-testnet.manta.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca54918f7B525C8df894668846506767412b53E3',
      blockCreated: 479584,
    ),
  },
);

/// Manta Pacific Testnet (chain id 3441005).
final Chain mantaTestnet = Chain(
  id: 3441005,
  name: 'Manta Pacific Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://manta-testnet.calderachain.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Manta Testnet Explorer',
    url: 'https://pacific-explorer.testnet.manta.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x211B1643b95Fe76f11eD8880EE810ABD9A4cf56C',
      blockCreated: 419915,
    ),
  },
);

/// Mantle (chain id 5000).
final Chain mantle = Chain(
  id: 5000,
  name: 'Mantle',
  nativeCurrency: const NativeCurrency(
    name: 'MNT',
    symbol: 'MNT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mantle.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Mantle Explorer',
    url: 'https://mantlescan.xyz/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 304717,
    ),
  },
);

/// Mantle Sepolia Testnet (chain id 5003).
final Chain mantleSepoliaTestnet = Chain(
  id: 5003,
  name: 'Mantle Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MNT',
    symbol: 'MNT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sepolia.mantle.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Mantle Testnet Explorer',
    url: 'https://explorer.sepolia.mantle.xyz/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 4584012,
    ),
  },
);

/// Mantle Testnet (chain id 5001).
final Chain mantleTestnet = Chain(
  id: 5001,
  name: 'Mantle Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MNT',
    symbol: 'MNT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.mantle.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Mantle Testnet Explorer',
    url: 'https://explorer.testnet.mantle.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 561333,
    ),
  },
);

/// MANTRA DuKong EVM Testnet (chain id 5887).
final Chain mantraDuKongEVMTestnet = Chain(
  id: 5887,
  name: 'MANTRA DuKong EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MANTRA',
    symbol: 'MANTRA',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.dukong.mantrachain.io'],
  blockExplorer: const BlockExplorer(
    name: 'MANTRAScan',
    url: 'https://mantrascan.io/dukong',
  ),
);

/// MANTRA EVM (chain id 5888).
final Chain mantraEVM = Chain(
  id: 5888,
  name: 'MANTRA EVM',
  nativeCurrency: const NativeCurrency(
    name: 'MANTRA',
    symbol: 'MANTRA',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.mantrachain.io'],
  blockExplorer: const BlockExplorer(
    name: 'MANTRA Blockscout Explorer',
    url: 'https://blockscout.mantrascan.io',
  ),
);

/// MAP Protocol (chain id 22776).
final Chain mapProtocol = Chain(
  id: 22776,
  name: 'MAP Protocol',
  nativeCurrency: const NativeCurrency(
    name: 'MAPO',
    symbol: 'MAPO',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.maplabs.io'],
  blockExplorer: const BlockExplorer(
    name: 'MAPO Scan',
    url: 'https://maposcan.io',
  ),
);

/// Maroo Testnet (chain id 450815).
final Chain marooTestnet = Chain(
  id: 450815,
  name: 'Maroo Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Testnet OKRW',
    symbol: 'tOKRW',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.maroo.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer-testnet.maroo.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Mars Credit (chain id 110110).
final Chain marsCredit = Chain(
  id: 110110,
  name: 'Mars Credit',
  nativeCurrency: const NativeCurrency(
    name: 'Mars Credit',
    symbol: 'MARS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.marscredit.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscan.marscredit.xyz',
  ),
);

/// Matchain (chain id 698).
final Chain matchain = Chain(
  id: 698,
  name: 'Matchain',
  nativeCurrency: const NativeCurrency(
    name: 'BNB',
    symbol: 'BNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.matchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Matchain Scan',
    url: 'https://matchscan.io',
  ),
);

/// Matchain Testnet (chain id 699).
final Chain matchainTestnet = Chain(
  id: 699,
  name: 'Matchain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BNB',
    symbol: 'BNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.matchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Matchain Scan',
    url: 'https://testnet.matchscan.io',
  ),
);

/// MCH Verse (chain id 29548).
final Chain mchVerse = Chain(
  id: 29548,
  name: 'MCH Verse',
  nativeCurrency: const NativeCurrency(
    name: 'Oasys',
    symbol: 'OAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.oasys.mycryptoheroes.net'],
  blockExplorer: const BlockExplorer(
    name: 'MCH Verse Explorer',
    url: 'https://explorer.oasys.mycryptoheroes.net',
  ),
);

/// MegaETH (chain id 4326).
final Chain megaeth = Chain(
  id: 4326,
  name: 'MegaETH',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.megaeth.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://mega.etherscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// MegaETH Testnet (chain id 6343).
final Chain megaethTestnet = Chain(
  id: 6343,
  name: 'MegaETH Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MegaETH Testnet Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://carrot.megaeth.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://testnet-mega.etherscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Mekong Pectra Devnet (chain id 7078815900).
final Chain mekong = Chain(
  id: 7078815900,
  name: 'Mekong Pectra Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'eth',
    symbol: 'eth',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mekong.ethpandaops.io'],
  blockExplorer: const BlockExplorer(
    name: 'Block Explorer',
    url: 'https://explorer.mekong.ethpandaops.io',
  ),
);

/// Meld (chain id 333000333).
final Chain meld = Chain(
  id: 333000333,
  name: 'Meld',
  nativeCurrency: const NativeCurrency(
    name: 'Meld',
    symbol: 'MELD',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-1.meld.com'],
  blockExplorer: const BlockExplorer(
    name: 'MELDscan',
    url: 'https://meldscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x769ee5a8e82c15c1b6e358f62ac8eb6e3abe8dc5',
      blockCreated: 360069,
    ),
  },
);

/// MemeCore (chain id 4352).
final Chain memecore = Chain(
  id: 4352,
  name: 'MemeCore',
  nativeCurrency: const NativeCurrency(name: 'M', symbol: 'M', decimals: 18),
  rpcUrls: const ['https://rpc.memecore.net'],
  blockExplorer: const BlockExplorer(
    name: 'MemeCore Explorer',
    url: 'https://memecorescan.io',
  ),
);

/// Merlin (chain id 4200).
final Chain merlin = Chain(
  id: 4200,
  name: 'Merlin',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.merlinchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://scan.merlinchain.io',
  ),
);

/// Merlin Erigon Testnet (chain id 4203).
final Chain merlinErigonTestnet = Chain(
  id: 4203,
  name: 'Merlin Erigon Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-erigon-rpc.merlinchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://testnet-erigon-scan.merlinchain.io',
  ),
);

/// MetaChain Mainnet (chain id 571).
final Chain metachain = Chain(
  id: 571,
  name: 'MetaChain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Metatime Coin',
    symbol: 'MTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.metatime.com'],
  blockExplorer: const BlockExplorer(
    name: 'MetaExplorer',
    url: 'https://explorer.metatime.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0000000000000000000000000000000000003001',
      blockCreated: 0,
    ),
  },
);

/// MetaChain Istanbul (chain id 1453).
final Chain metachainIstanbul = Chain(
  id: 1453,
  name: 'MetaChain Istanbul',
  nativeCurrency: const NativeCurrency(
    name: 'Metatime Coin',
    symbol: 'MTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://istanbul-rpc.metachain.dev'],
  blockExplorer: const BlockExplorer(
    name: 'MetaExplorer',
    url: 'https://istanbul-explorer.metachain.dev',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0000000000000000000000000000000000003001',
      blockCreated: 0,
    ),
  },
);

/// Metadium Network (chain id 11).
final Chain metadium = Chain(
  id: 11,
  name: 'Metadium Network',
  nativeCurrency: const NativeCurrency(
    name: 'META',
    symbol: 'META',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.metadium.com/prod'],
  blockExplorer: const BlockExplorer(
    name: 'Metadium Explorer',
    url: 'https://explorer.metadium.com',
  ),
);

/// Metal L2 (chain id 1750).
final Chain metalL2 = Chain(
  id: 1750,
  name: 'Metal L2',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.metall2.com'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://explorer.metall2.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Meter (chain id 82).
final Chain meter = Chain(
  id: 82,
  name: 'Meter',
  nativeCurrency: const NativeCurrency(
    name: 'MTR',
    symbol: 'MTR',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.meter.io'],
  blockExplorer: const BlockExplorer(
    name: 'MeterScan',
    url: 'https://scan.meter.io',
  ),
);

/// Meter Testnet (chain id 83).
final Chain meterTestnet = Chain(
  id: 83,
  name: 'Meter Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MTR',
    symbol: 'MTR',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpctest.meter.io'],
  blockExplorer: const BlockExplorer(
    name: 'MeterTestnetScan',
    url: 'https://scan-warringstakes.meter.io',
  ),
);

/// Metis (chain id 1088).
final Chain metis = Chain(
  id: 1088,
  name: 'Metis',
  nativeCurrency: const NativeCurrency(
    name: 'Metis',
    symbol: 'METIS',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://metis.rpc.hypersync.xyz',
    'https://metis-pokt.nodies.app',
    'https://api.blockeden.xyz/metis/67nCBdZQSH9z3YqDDjdm',
    'https://metis-andromeda.rpc.thirdweb.com',
    'https://metis-andromeda.gateway.tenderly.co',
    'https://metis.api.onfinality.io/public',
    'https://andromeda.metis.io/?owner=1088',
    'https://metis-mainnet.public.blastapi.io',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Metis Explorer',
    url: 'https://explorer.metis.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 2338552,
    ),
  },
);

/// Metis Goerli (chain id 599).
final Chain metisGoerli = Chain(
  id: 599,
  name: 'Metis Goerli',
  nativeCurrency: const NativeCurrency(
    name: 'Metis Goerli',
    symbol: 'METIS',
    decimals: 18,
  ),
  rpcUrls: const ['https://goerli.gateway.metisdevops.link'],
  blockExplorer: const BlockExplorer(
    name: 'Metis Goerli Explorer',
    url: 'https://goerli.explorer.metisdevops.link',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1006207,
    ),
  },
);

/// Metis Sepolia (chain id 59902).
final Chain metisSepolia = Chain(
  id: 59902,
  name: 'Metis Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Test Metis',
    symbol: 'tMETIS',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://sepolia.metisdevops.link',
    'https://metis-sepolia-rpc.publicnode.com',
    'https://metis-sepolia.gateway.tenderly.co',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Metis Sepolia Explorer',
    url: 'https://sepolia-explorer.metisdevops.link',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 224185,
    ),
  },
);

/// MEVerse Chain Mainnet (chain id 7518).
final Chain mev = Chain(
  id: 7518,
  name: 'MEVerse Chain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'MEVerse',
    symbol: 'MEV',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.meversemainnet.io'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://www.meversescan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 86881340,
    ),
  },
);

/// MEVerse Chain Testnet (chain id 4759).
final Chain mevTestnet = Chain(
  id: 4759,
  name: 'MEVerse Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MEVerse',
    symbol: 'MEV',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.meversetestnet.io'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://testnet.meversescan.io/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 64371115,
    ),
  },
);

/// Mezo (chain id 31612).
final Chain mezo = Chain(
  id: 31612,
  name: 'Mezo',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mezo.org'],
  blockExplorer: const BlockExplorer(
    name: 'Mezo Explorer',
    url: 'https://explorer.mezo.org',
  ),
);

/// Mezo Testnet (chain id 31611).
final Chain mezoTestnet = Chain(
  id: 31611,
  name: 'Mezo Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.test.mezo.org'],
  blockExplorer: const BlockExplorer(
    name: 'Mezo Testnet Explorer',
    url: 'https://explorer.test.mezo.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3328573,
    ),
  },
);

/// Mint Mainnet (chain id 185).
final Chain mint = Chain(
  id: 185,
  name: 'Mint Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mintchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Mintchain explorer',
    url: 'https://explorer.mintchain.io',
  ),
);

/// Mint Sepolia Testnet (chain id 1686).
final Chain mintSepoliaTestnet = Chain(
  id: 1686,
  name: 'Mint Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.mintchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Mintchain Testnet explorer',
    url: 'https://testnet-explorer.mintchain.io',
  ),
);

/// Mitosis Testnet (chain id 124832).
final Chain mitosisTestnet = Chain(
  id: 124832,
  name: 'Mitosis Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MITO',
    symbol: 'MITO',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.mitosis.org'],
  blockExplorer: const BlockExplorer(
    name: 'Mitosis testnet explorer',
    url: 'https://testnet.mitosiscan.xyz',
  ),
);

/// MIZUHIKI Testnet Awaji (chain id 6497).
final Chain mizuhikiTestnetAwaji = Chain(
  id: 6497,
  name: 'MIZUHIKI Testnet Awaji',
  nativeCurrency: const NativeCurrency(
    name: 'MIZU',
    symbol: 'MIZU',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.awaji.mizuhiki.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://awaji.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// Mode Mainnet (chain id 34443).
final Chain mode = Chain(
  id: 34443,
  name: 'Mode Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.mode.network'],
  blockExplorer: const BlockExplorer(
    name: 'Modescan',
    url: 'https://modescan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 2465882,
    ),
  },
);

/// Mode Testnet (chain id 919).
final Chain modeTestnet = Chain(
  id: 919,
  name: 'Mode Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.mode.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://sepolia.explorer.mode.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xBAba8373113Fb7a68f195deF18732e01aF8eDfCF',
      blockCreated: 3019007,
    ),
  },
);

/// Monad (chain id 143).
final Chain monad = Chain(
  id: 143,
  name: 'Monad',
  nativeCurrency: const NativeCurrency(
    name: 'Monad',
    symbol: 'MON',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.monad.xyz', 'https://rpc1.monad.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Monadscan',
    url: 'https://monadscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 9248132,
    ),
  },
);

/// Monad Testnet (chain id 10143).
final Chain monadTestnet = Chain(
  id: 10143,
  name: 'Monad Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Testnet MON Token',
    symbol: 'MON',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.monad.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Monad Testnet explorer',
    url: 'https://testnet.monadexplorer.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 251449,
    ),
  },
);

/// Moonbase Alpha (chain id 1287).
final Chain moonbaseAlpha = Chain(
  id: 1287,
  name: 'Moonbase Alpha',
  nativeCurrency: const NativeCurrency(
    name: 'DEV',
    symbol: 'DEV',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.api.moonbase.moonbeam.network'],
  blockExplorer: const BlockExplorer(
    name: 'Moonscan',
    url: 'https://moonbase.moonscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1850686,
    ),
  },
);

/// Moonbeam (chain id 1284).
final Chain moonbeam = Chain(
  id: 1284,
  name: 'Moonbeam',
  nativeCurrency: const NativeCurrency(
    name: 'Moonbeam',
    symbol: 'GLMR',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.api.moonbeam.network'],
  blockExplorer: const BlockExplorer(
    name: 'Moonscan',
    url: 'https://moonscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 609002,
    ),
  },
);

/// Moonbeam Development Node (chain id 1281).
final Chain moonbeamDev = Chain(
  id: 1281,
  name: 'Moonbeam Development Node',
  nativeCurrency: const NativeCurrency(
    name: 'DEV',
    symbol: 'DEV',
    decimals: 18,
  ),
  rpcUrls: const ['http://127.0.0.1:9944'],
);

/// Moonriver (chain id 1285).
final Chain moonriver = Chain(
  id: 1285,
  name: 'Moonriver',
  nativeCurrency: const NativeCurrency(
    name: 'Moonriver',
    symbol: 'MOVR',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.api.moonriver.moonbeam.network'],
  blockExplorer: const BlockExplorer(
    name: 'Moonscan',
    url: 'https://moonriver.moonscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1597904,
    ),
  },
);

/// Morph (chain id 2818).
final Chain morph = Chain(
  id: 2818,
  name: 'Morph',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.morphl2.io'],
  blockExplorer: const BlockExplorer(
    name: 'Morph Explorer',
    url: 'https://explorer.morphl2.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3654913,
    ),
  },
);

/// Morph Holesky (chain id 2810).
final Chain morphHolesky = Chain(
  id: 2810,
  name: 'Morph Holesky',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-quicknode-holesky.morphl2.io'],
  blockExplorer: const BlockExplorer(
    name: 'Morph Holesky Explorer',
    url: 'https://explorer-holesky.morphl2.io',
  ),
);

/// Morph Sepolia (chain id 2710).
final Chain morphSepolia = Chain(
  id: 2710,
  name: 'Morph Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.morphl2.io'],
  blockExplorer: const BlockExplorer(
    name: 'Morph Testnet Explorer',
    url: 'https://explorer-testnet.morphl2.io',
  ),
);

/// Nahmii 2 Mainnet (chain id 5551).
final Chain nahmii = Chain(
  id: 5551,
  name: 'Nahmii 2 Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://l2.nahmii.io'],
  blockExplorer: const BlockExplorer(
    name: 'Nahmii 2 Explorer',
    url: 'https://explorer.n2.nahmii.io',
  ),
);

/// Nautilus Mainnet (chain id 22222).
final Chain nautilus = Chain(
  id: 22222,
  name: 'Nautilus Mainnet',
  nativeCurrency: const NativeCurrency(name: 'ZBC', symbol: 'ZBC', decimals: 9),
  rpcUrls: const ['https://api.nautilus.nautchain.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'NautScan',
    url: 'https://nautscan.com',
  ),
);

/// NEAR Protocol (chain id 397).
final Chain near = Chain(
  id: 397,
  name: 'NEAR Protocol',
  nativeCurrency: const NativeCurrency(
    name: 'NEAR',
    symbol: 'NEAR',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc.mainnet.near.org'],
  blockExplorer: const BlockExplorer(
    name: 'NEAR Explorer',
    url: 'https://eth-explorer.near.org',
  ),
);

/// NEAR Protocol Testnet (chain id 398).
final Chain nearTestnet = Chain(
  id: 398,
  name: 'NEAR Protocol Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'NEAR',
    symbol: 'NEAR',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc.testnet.near.org'],
  blockExplorer: const BlockExplorer(
    name: 'NEAR Explorer',
    url: 'https://eth-explorer-testnet.near.org',
  ),
);

/// Neon EVM DevNet (chain id 245022926).
final Chain neonDevnet = Chain(
  id: 245022926,
  name: 'Neon EVM DevNet',
  nativeCurrency: const NativeCurrency(
    name: 'NEON',
    symbol: 'NEON',
    decimals: 18,
  ),
  rpcUrls: const ['https://devnet.neonevm.org'],
  blockExplorer: const BlockExplorer(
    name: 'Neonscan',
    url: 'https://devnet.neonscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 205206112,
    ),
  },
);

/// Neon EVM MainNet (chain id 245022934).
final Chain neonMainnet = Chain(
  id: 245022934,
  name: 'Neon EVM MainNet',
  nativeCurrency: const NativeCurrency(
    name: 'NEON',
    symbol: 'NEON',
    decimals: 18,
  ),
  rpcUrls: const ['https://neon-proxy-mainnet.solana.p2p.org'],
  blockExplorer: const BlockExplorer(
    name: 'Neonscan',
    url: 'https://neonscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 206545524,
    ),
  },
);

/// Neo X Mainnet (chain id 47763).
final Chain neoxMainnet = Chain(
  id: 47763,
  name: 'Neo X Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Gas',
    symbol: 'GAS',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://mainnet-1.rpc.banelabs.org',
    'https://mainnet-2.rpc.banelabs.org',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Neo X - Explorer',
    url: 'https://xexplorer.neo.org',
  ),
);

/// Neo X Testnet T4 (chain id 12227332).
final Chain neoxT4 = Chain(
  id: 12227332,
  name: 'Neo X Testnet T4',
  nativeCurrency: const NativeCurrency(
    name: 'Gas',
    symbol: 'GAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.rpc.banelabs.org/'],
  blockExplorer: const BlockExplorer(
    name: 'neox-scan',
    url: 'https://xt4scan.ngd.network',
  ),
);

/// Newton (chain id 1012).
final Chain newton = Chain(
  id: 1012,
  name: 'Newton',
  nativeCurrency: const NativeCurrency(
    name: 'Newton',
    symbol: 'NEW',
    decimals: 18,
  ),
  rpcUrls: const ['https://global.rpc.mainnet.newtonproject.org'],
  blockExplorer: const BlockExplorer(
    name: 'NewFi explorer',
    url: 'https://explorer.newtonproject.org/',
  ),
);

/// Nexi (chain id 4242).
final Chain nexi = Chain(
  id: 4242,
  name: 'Nexi',
  nativeCurrency: const NativeCurrency(
    name: 'Nexi',
    symbol: 'NEXI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.chain.nexi.technology'],
  blockExplorer: const BlockExplorer(
    name: 'NexiScan',
    url: 'https://www.nexiscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0277A46Cc69A57eE3A6C8c158bA874832F718B8E',
      blockCreated: 25770160,
    ),
  },
);

/// Nexilix Smart Chain (chain id 240).
final Chain nexilix = Chain(
  id: 240,
  name: 'Nexilix Smart Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Nexilix',
    symbol: 'NEXILIX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpcurl.pos.nexilix.com'],
  blockExplorer: const BlockExplorer(
    name: 'NexilixScan',
    url: 'https://scan.nexilix.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x58381c8e2BF9d0C2C4259cA14BdA9Afe02831244',
      blockCreated: 74448,
    ),
  },
);

/// Nibiru (chain id 6900).
final Chain nibiru = Chain(
  id: 6900,
  name: 'Nibiru',
  nativeCurrency: const NativeCurrency(
    name: 'NIBI',
    symbol: 'NIBI',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm-rpc.nibiru.fi'],
  blockExplorer: const BlockExplorer(
    name: 'NibiScan',
    url: 'https://nibiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 19587573,
    ),
  },
);

/// Nitrograph Testnet (chain id 200024).
final Chain nitrographTestnet = Chain(
  id: 200024,
  name: 'Nitrograph Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Nitro',
    symbol: 'NOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.nitrograph.foundation'],
  blockExplorer: const BlockExplorer(
    name: 'Nitrograph Explorer',
    url: 'https://explorer-testnet.nitrograph.foundation',
  ),
);

/// Nomina (chain id 166).
final Chain nomina = Chain(
  id: 166,
  name: 'Nomina',
  nativeCurrency: const NativeCurrency(
    name: 'Nomina',
    symbol: 'NOM',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.nomina.io'],
  blockExplorer: const BlockExplorer(
    name: 'Nomina Explorer',
    url: 'https://nomscan.io',
  ),
);

/// Oasis Testnet (chain id 4090).
final Chain oasisTestnet = Chain(
  id: 4090,
  name: 'Oasis Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Fasttoken',
    symbol: 'FTN',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc1.oasis.bahamutchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Ftnscan',
    url: 'https://oasis.ftnscan.com',
  ),
);

/// Oasys (chain id 248).
final Chain oasys = Chain(
  id: 248,
  name: 'Oasys',
  nativeCurrency: const NativeCurrency(
    name: 'Oasys',
    symbol: 'OAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.oasys.games'],
  blockExplorer: const BlockExplorer(
    name: 'OasysScan',
    url: 'https://scan.oasys.games',
  ),
);

/// Odyssey Testnet (chain id 911867).
final Chain odysseyTestnet = Chain(
  id: 911867,
  name: 'Odyssey Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://odyssey.ithaca.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Odyssey Explorer',
    url: 'https://odyssey-explorer.ithaca.xyz',
  ),
);

/// OKC (chain id 66).
final Chain okc = Chain(
  id: 66,
  name: 'OKC',
  nativeCurrency: const NativeCurrency(
    name: 'OKT',
    symbol: 'OKT',
    decimals: 18,
  ),
  rpcUrls: const ['https://exchainrpc.okex.org'],
  blockExplorer: const BlockExplorer(
    name: 'oklink',
    url: 'https://www.oklink.com/okc',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 10364792,
    ),
  },
);

/// Omax Mainnet (chain id 311).
final Chain omax = Chain(
  id: 311,
  name: 'Omax Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'OMAX',
    symbol: 'OMAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainapi.omaxray.com'],
  blockExplorer: const BlockExplorer(
    name: 'Omax Explorer',
    url: 'https://omaxscan.com',
  ),
);

/// Omni (chain id 166).
final Chain omni = Chain(
  id: 166,
  name: 'Omni',
  nativeCurrency: const NativeCurrency(
    name: 'Omni',
    symbol: 'OMNI',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.omni.network'],
  blockExplorer: const BlockExplorer(
    name: 'OmniScan',
    url: 'https://omniscan.network',
  ),
);

/// Omni Omega (chain id 164).
final Chain omniOmega = Chain(
  id: 164,
  name: 'Omni Omega',
  nativeCurrency: const NativeCurrency(
    name: 'Omni',
    symbol: 'OMNI',
    decimals: 18,
  ),
  rpcUrls: const ['https://omega.omni.network'],
  blockExplorer: const BlockExplorer(
    name: 'Omega OmniScan',
    url: 'https://omega.omniscan.network/',
  ),
);

/// One World Chain Mainnet (chain id 309075).
final Chain oneWorld = Chain(
  id: 309075,
  name: 'One World Chain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'OWCT',
    symbol: 'OWCT',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.oneworldchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'One World Explorer',
    url: 'https://mainnet.oneworldchain.org',
  ),
);

/// OORT MainnetDev (chain id 9700).
final Chain oortMainnetDev = Chain(
  id: 9700,
  name: 'OORT MainnetDev',
  nativeCurrency: const NativeCurrency(
    name: 'OORT',
    symbol: 'OORT',
    decimals: 18,
  ),
  rpcUrls: const ['https://dev-rpc.oortech.com'],
  blockExplorer: const BlockExplorer(
    name: 'OORT MainnetDev Explorer',
    url: 'https://dev-scan.oortech.com',
  ),
);

/// opBNB (chain id 204).
final Chain opBNB = Chain(
  id: 204,
  name: 'opBNB',
  nativeCurrency: const NativeCurrency(
    name: 'BNB',
    symbol: 'BNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://opbnb-mainnet-rpc.bnbchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'opBNB (BSCScan)',
    url: 'https://opbnb.bscscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 512881,
    ),
  },
);

/// opBNB Testnet (chain id 5611).
final Chain opBNBTestnet = Chain(
  id: 5611,
  name: 'opBNB Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tBNB',
    symbol: 'tBNB',
    decimals: 18,
  ),
  rpcUrls: const ['https://opbnb-testnet-rpc.bnbchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'opbnbscan',
    url: 'https://testnet.opbnbscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3705108,
    ),
  },
);

/// OpenLedger (chain id 1612).
final Chain openledger = Chain(
  id: 1612,
  name: 'OpenLedger',
  nativeCurrency: const NativeCurrency(
    name: 'Open',
    symbol: 'OPEN',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.openledger.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'OpenLedger Explorer',
    url: 'https://scan.openledger.xyz',
  ),
);

/// OP Mainnet (chain id 10).
final Chain optimism = Chain(
  id: 10,
  name: 'OP Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.optimism.io'],
  blockExplorer: const BlockExplorer(
    name: 'Optimism Explorer',
    url: 'https://optimistic.etherscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 4286263,
    ),
  },
);

/// Optimism Goerli (chain id 420).
final Chain optimismGoerli = Chain(
  id: 420,
  name: 'Optimism Goerli',
  nativeCurrency: const NativeCurrency(
    name: 'Goerli Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://goerli.optimism.io'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://goerli-optimism.etherscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 49461,
    ),
  },
);

/// OP Sepolia (chain id 11155420).
final Chain optimismSepolia = Chain(
  id: 11155420,
  name: 'OP Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.optimism.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://optimism-sepolia.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1620204,
    ),
  },
);

/// Optopia (chain id 62050).
final Chain optopia = Chain(
  id: 62050,
  name: 'Optopia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-mainnet.optopia.ai'],
  blockExplorer: const BlockExplorer(
    name: 'Optopia Explorer',
    url: 'https://scan.optopia.ai',
  ),
);

/// Optopia Testnet (chain id 62049).
final Chain optopiaTestnet = Chain(
  id: 62049,
  name: 'Optopia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.optopia.ai'],
  blockExplorer: const BlockExplorer(
    name: 'Optopia Explorer',
    url: 'https://scan-testnet.optopia.ai',
  ),
);

/// Orderly (chain id 291).
final Chain orderly = Chain(
  id: 291,
  name: 'Orderly',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.orderly.network'],
  blockExplorer: const BlockExplorer(
    name: 'Orderly Explorer',
    url: 'https://explorer.orderly.network',
  ),
);

/// Orderly Sepolia (chain id 4460).
final Chain orderlySepolia = Chain(
  id: 4460,
  name: 'Orderly Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://l2-orderly-l2-4460-sepolia-8tc3sd7dvy.t.conduit.xyz',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Orderly Explorer',
    url:
        'https://explorerl2new-orderly-l2-4460-sepolia-8tc3sd7dvy.t.conduit.xyz',
  ),
);

/// Otim Devnet (chain id 41144114).
final Chain otimDevnet = Chain(
  id: 41144114,
  name: 'Otim Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://devnet.otim.xyz'],
  contracts: const {
    'batchInvoker': ChainContract(
      address: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
    ),
  },
);

/// Palm (chain id 11297108109).
final Chain palm = Chain(
  id: 11297108109,
  name: 'Palm',
  nativeCurrency: const NativeCurrency(
    name: 'PALM',
    symbol: 'PALM',
    decimals: 18,
  ),
  rpcUrls: const ['https://palm-mainnet.public.blastapi.io'],
  blockExplorer: const BlockExplorer(
    name: 'Chainlens',
    url: 'https://palm.chainlens.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 15429248,
    ),
  },
);

/// Palm Testnet (chain id 11297108099).
final Chain palmTestnet = Chain(
  id: 11297108099,
  name: 'Palm Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'PALM',
    symbol: 'PALM',
    decimals: 18,
  ),
  rpcUrls: const ['https://palm-mainnet.public.blastapi.io'],
  blockExplorer: const BlockExplorer(
    name: 'Chainlens',
    url: 'https://palm.chainlens.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 15429248,
    ),
  },
);

/// Paseo PassetHub (chain id 420420422).
final Chain paseoPassetHub = Chain(
  id: 420420422,
  name: 'Paseo PassetHub',
  nativeCurrency: const NativeCurrency(
    name: 'PAS',
    symbol: 'PAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-passet-hub-eth-rpc.polkadot.io'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://blockscout-passet-hub.parity-testnet.parity.io',
  ),
);

/// Peaq (chain id 3338).
final Chain peaq = Chain(
  id: 3338,
  name: 'Peaq',
  nativeCurrency: const NativeCurrency(
    name: 'peaq',
    symbol: 'PEAQ',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://quicknode1.peaq.xyz',
    'https://quicknode2.peaq.xyz',
    'https://quicknode3.peaq.xyz',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Subscan',
    url: 'https://peaq.subscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 3566354,
    ),
  },
);

/// PGN (chain id 424).
final Chain pgn = Chain(
  id: 424,
  name: 'PGN',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.publicgoods.network'],
  blockExplorer: const BlockExplorer(
    name: 'PGN Explorer',
    url: 'https://explorer.publicgoods.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3380209,
    ),
  },
);

/// PGN (chain id 58008).
final Chain pgnTestnet = Chain(
  id: 58008,
  name: 'PGN',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.publicgoods.network'],
  blockExplorer: const BlockExplorer(
    name: 'PGN Testnet Explorer',
    url: 'https://explorer.sepolia.publicgoods.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3754925,
    ),
  },
);

/// Phoenix Blockchain (chain id 13381).
final Chain phoenix = Chain(
  id: 13381,
  name: 'Phoenix Blockchain',
  nativeCurrency: const NativeCurrency(
    name: 'Phoenix',
    symbol: 'PHX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.phoenixplorer.com'],
  blockExplorer: const BlockExplorer(
    name: 'Phoenixplorer',
    url: 'https://phoenixplorer.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x498cF757a575cFF2c2Ed9f532f56Efa797f86442',
      blockCreated: 5620192,
    ),
  },
);

/// Planq Mainnet (chain id 7070).
final Chain planq = Chain(
  id: 7070,
  name: 'Planq Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'PLQ',
    symbol: 'PLQ',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://planq-rpc.nodies.app',
    'https://evm-rpc.planq.network',
    'https://jsonrpc.planq.nodestake.top',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Planq Explorer',
    url: 'https://evm.planq.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 8470015,
    ),
  },
);

/// Plasma (chain id 9745).
final Chain plasma = Chain(
  id: 9745,
  name: 'Plasma',
  nativeCurrency: const NativeCurrency(
    name: 'Plasma',
    symbol: 'XPL',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.plasma.to'],
  blockExplorer: const BlockExplorer(
    name: 'PlasmaScan',
    url: 'https://plasmascan.to',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Plasma Devnet (chain id 9747).
final Chain plasmaDevnet = Chain(
  id: 9747,
  name: 'Plasma Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'Devnet Plasma',
    symbol: 'XPL',
    decimals: 18,
  ),
  rpcUrls: const ['https://devnet-rpc.plasma.to'],
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// Plasma Testnet (chain id 9746).
final Chain plasmaTestnet = Chain(
  id: 9746,
  name: 'Plasma Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Testnet Plasma',
    symbol: 'XPL',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.plasma.to'],
  blockExplorer: const BlockExplorer(
    name: 'RouteScan',
    url: 'https://testnet.plasmascan.to',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// PlayFi Albireo Testnet (chain id 1612127).
final Chain playfiAlbireo = Chain(
  id: 1612127,
  name: 'PlayFi Albireo Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://albireo-rpc.playfi.ai'],
  blockExplorer: const BlockExplorer(
    name: 'PlayFi Albireo Explorer',
    url: 'https://albireo-explorer.playfi.ai',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xF9cda624FBC7e059355ce98a31693d299FACd963',
    ),
  },
);

/// Plinga (chain id 242).
final Chain plinga = Chain(
  id: 242,
  name: 'Plinga',
  nativeCurrency: const NativeCurrency(
    name: 'Plinga',
    symbol: 'PLINGA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpcurl.mainnet.plgchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Plgscan',
    url: 'https://www.plgscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0989576160f2e7092908BB9479631b901060b6e4',
      blockCreated: 204489,
    ),
  },
);

/// Plume (Legacy) (chain id 98865).
final Chain plume = Chain(
  id: 98865,
  name: 'Plume (Legacy)',
  nativeCurrency: const NativeCurrency(
    name: 'Plume Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.plumenetwork.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.plumenetwork.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 48577,
    ),
  },
);

/// Plume Devnet (Legacy) (chain id 98864).
final Chain plumeDevnet = Chain(
  id: 98864,
  name: 'Plume Devnet (Legacy)',
  nativeCurrency: const NativeCurrency(
    name: 'Plume Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://test-rpc.plumenetwork.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://test-explorer.plumenetwork.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 481948,
    ),
  },
);

/// Plume (chain id 98866).
final Chain plumeMainnet = Chain(
  id: 98866,
  name: 'Plume',
  nativeCurrency: const NativeCurrency(
    name: 'Plume',
    symbol: 'PLUME',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.plume.org'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.plume.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 39679,
    ),
  },
);

/// Plume Testnet (chain id 98867).
final Chain plumeSepolia = Chain(
  id: 98867,
  name: 'Plume Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Plume',
    symbol: 'PLUME',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.plume.org'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://testnet-explorer.plume.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 199712,
    ),
  },
);

/// Plume Testnet (Legacy) (chain id 161221135).
final Chain plumeTestnet = Chain(
  id: 161221135,
  name: 'Plume Testnet (Legacy)',
  nativeCurrency: const NativeCurrency(
    name: 'Plume Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.plumenetwork.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://testnet-explorer.plumenetwork.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 6022332,
    ),
  },
);

/// Polter Testnet (chain id 631571).
final Chain polterTestnet = Chain(
  id: 631571,
  name: 'Polter Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Polter GHST',
    symbol: 'GHST',
    decimals: 18,
  ),
  rpcUrls: const ['https://geist-polter.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://polter-testnet.explorer.alchemy.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 11245,
    ),
  },
);

/// Polygon (chain id 137).
final Chain polygon = Chain(
  id: 137,
  name: 'Polygon',
  nativeCurrency: const NativeCurrency(
    name: 'POL',
    symbol: 'POL',
    decimals: 18,
  ),
  rpcUrls: const ['https://polygon.drpc.org'],
  blockExplorer: const BlockExplorer(
    name: 'PolygonScan',
    url: 'https://polygonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 25770160,
    ),
  },
);

/// Polygon Amoy (chain id 80002).
final Chain polygonAmoy = Chain(
  id: 80002,
  name: 'Polygon Amoy',
  nativeCurrency: const NativeCurrency(
    name: 'POL',
    symbol: 'POL',
    decimals: 18,
  ),
  rpcUrls: const ['https://polygon-amoy.drpc.org'],
  blockExplorer: const BlockExplorer(
    name: 'PolygonScan',
    url: 'https://amoy.polygonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 3127388,
    ),
  },
);

/// Polygon Mumbai (chain id 80001).
final Chain polygonMumbai = Chain(
  id: 80001,
  name: 'Polygon Mumbai',
  nativeCurrency: const NativeCurrency(
    name: 'MATIC',
    symbol: 'MATIC',
    decimals: 18,
  ),
  rpcUrls: const ['https://80001.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'PolygonScan',
    url: 'https://mumbai.polygonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 25770160,
    ),
  },
);

/// Polygon zkEVM (chain id 1101).
final Chain polygonZkEvm = Chain(
  id: 1101,
  name: 'Polygon zkEVM',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://zkevm-rpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'PolygonScan',
    url: 'https://zkevm.polygonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 57746,
    ),
  },
);

/// Polygon zkEVM Cardona (chain id 2442).
final Chain polygonZkEvmCardona = Chain(
  id: 2442,
  name: 'Polygon zkEVM Cardona',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.cardona.zkevm-rpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'PolygonScan',
    url: 'https://cardona-zkevm.polygonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 114091,
    ),
  },
);

/// Polygon zkEVM Testnet (chain id 1442).
final Chain polygonZkEvmTestnet = Chain(
  id: 1442,
  name: 'Polygon zkEVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.public.zkevm-test.net'],
  blockExplorer: const BlockExplorer(
    name: 'PolygonScan',
    url: 'https://testnet-zkevm.polygonscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 525686,
    ),
  },
);

/// Polynomial (chain id 8008).
final Chain polynomial = Chain(
  id: 8008,
  name: 'Polynomial',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.polynomial.fi'],
  blockExplorer: const BlockExplorer(
    name: 'Polynomial Scan',
    url: 'https://polynomialscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Polynomia Sepolia (chain id 80008).
final Chain polynomialSepolia = Chain(
  id: 80008,
  name: 'Polynomia Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sepolia.polynomial.fi'],
  blockExplorer: const BlockExplorer(
    name: 'Polynomial Scan',
    url: 'https://sepolia.polynomialscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// POTOS Mainnet (chain id 60603).
final Chain potos = Chain(
  id: 60603,
  name: 'POTOS Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'POTOS Token',
    symbol: 'POT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.potos.hk'],
  blockExplorer: const BlockExplorer(
    name: 'POTOS Mainnet explorer',
    url: 'https://scan.potos.hk',
  ),
);

/// POTOS Testnet (chain id 60600).
final Chain potosTestnet = Chain(
  id: 60600,
  name: 'POTOS Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'POTOS Token',
    symbol: 'POT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.potos.hk'],
  blockExplorer: const BlockExplorer(
    name: 'POTOS Testnet explorer',
    url: 'https://scan-testnet.potos.hk',
  ),
);

/// PremiumBlock Testnet (chain id 23023).
final Chain premiumBlockTestnet = Chain(
  id: 23023,
  name: 'PremiumBlock Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Premium Block',
    symbol: 'PBLK',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.premiumblock.org'],
  blockExplorer: const BlockExplorer(
    name: 'PremiumBlocks Explorer',
    url: 'https://scan.premiumblock.org',
  ),
);

/// PulseChain (chain id 369).
final Chain pulsechain = Chain(
  id: 369,
  name: 'PulseChain',
  nativeCurrency: const NativeCurrency(
    name: 'Pulse',
    symbol: 'PLS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.pulsechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'PulseScan',
    url: 'https://ipfs.scan.pulsechain.com',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e',
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 14353601,
    ),
  },
);

/// PulseChain V4 (chain id 943).
final Chain pulsechainV4 = Chain(
  id: 943,
  name: 'PulseChain V4',
  nativeCurrency: const NativeCurrency(
    name: 'V4 Pulse',
    symbol: 'v4PLS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.v4.testnet.pulsechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'PulseScan',
    url: 'https://scan.v4.testnet.pulsechain.com',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e',
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 14353601,
    ),
  },
);

/// Pumpfi Testnet (chain id 490092).
final Chain pumpfiTestnet = Chain(
  id: 490092,
  name: 'Pumpfi Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'PMPT',
    symbol: 'PMPT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc1testnet.pumpfi.me'],
  blockExplorer: const BlockExplorer(
    name: 'Pumpfi Testnet Scan',
    url: 'https://testnetscan.pumpfi.me',
  ),
);

/// Pyrope Testnet (chain id 695569).
final Chain pyrope = Chain(
  id: 695569,
  name: 'Pyrope Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.pyropechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://pyrope.blockscout.com',
  ),
);

/// Q Mainnet (chain id 35441).
final Chain qMainnet = Chain(
  id: 35441,
  name: 'Q Mainnet',
  nativeCurrency: const NativeCurrency(name: 'Q', symbol: 'Q', decimals: 18),
  rpcUrls: const ['https://rpc.q.org'],
  blockExplorer: const BlockExplorer(
    name: 'Q Mainnet Explorer',
    url: 'https://explorer.q.org',
  ),
);

/// Q Testnet (chain id 35443).
final Chain qTestnet = Chain(
  id: 35443,
  name: 'Q Testnet',
  nativeCurrency: const NativeCurrency(name: 'Q', symbol: 'Q', decimals: 18),
  rpcUrls: const ['https://rpc.qtestnet.org'],
  blockExplorer: const BlockExplorer(
    name: 'Q Testnet Explorer',
    url: 'https://explorer.qtestnet.org',
  ),
);

/// QL1 (chain id 766).
final Chain ql1 = Chain(
  id: 766,
  name: 'QL1',
  nativeCurrency: const NativeCurrency(
    name: 'QOM',
    symbol: 'QOM',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.qom.one'],
  blockExplorer: const BlockExplorer(
    name: 'Ql1 Explorer',
    url: 'https://scan.qom.one',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x7A52370716ea730585884F5BDB0f6E60C39b8C64',
    ),
  },
);

/// Quai Network Mainnet (chain id 9).
final Chain quai = Chain(
  id: 9,
  name: 'Quai Network Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Quai',
    symbol: 'QUAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.quai.network/cyprus1'],
  blockExplorer: const BlockExplorer(
    name: 'Quaiscan',
    url: 'https://quaiscan.io',
  ),
);

/// Quai Network Testnet (chain id 15000).
final Chain quaiTestnet = Chain(
  id: 15000,
  name: 'Quai Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Quai',
    symbol: 'QUAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://orchard.rpc.quai.network/cyprus1'],
  blockExplorer: const BlockExplorer(
    name: 'Orchard Quaiscan',
    url: 'https://orchard.quaiscan.io',
  ),
);

/// Radius Network (chain id 723487).
final Chain radius = Chain(
  id: 723487,
  name: 'Radius Network',
  nativeCurrency: const NativeCurrency(
    name: 'Radius USD',
    symbol: 'RUSD',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.radiustech.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Radius Network Explorer',
    url: 'https://network.radiustech.xyz',
  ),
);

/// Radius Test Network (chain id 72344).
final Chain radiusTestnet = Chain(
  id: 72344,
  name: 'Radius Test Network',
  nativeCurrency: const NativeCurrency(
    name: 'Radius USD',
    symbol: 'RUSD',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.radiustech.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Radius Test Network Explorer',
    url: 'https://testnet.radiustech.xyz',
  ),
);

/// Reactive Lasna Testnet (chain id 5318007).
final Chain reactiveTestnet = Chain(
  id: 5318007,
  name: 'Reactive Lasna Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Lasna React',
    symbol: 'lREACT',
    decimals: 18,
  ),
  rpcUrls: const ['https://lasna-rpc.rnk.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Reactscan',
    url: 'https://lasna.reactscan.net',
  ),
);

/// re.al (chain id 111188).
final Chain real = Chain(
  id: 111188,
  name: 're.al',
  nativeCurrency: const NativeCurrency(
    name: 'reETH',
    symbol: 'reETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.realforreal.gelato.digital'],
  blockExplorer: const BlockExplorer(
    name: 're.al Explorer',
    url: 'https://explorer.re.al',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 695,
    ),
  },
);

/// Redbelly Network Mainnet (chain id 151).
final Chain redbellyMainnet = Chain(
  id: 151,
  name: 'Redbelly Network Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Redbelly Native Coin',
    symbol: 'RBNT',
    decimals: 18,
  ),
  rpcUrls: const ['https://governors.mainnet.redbelly.network'],
  blockExplorer: const BlockExplorer(
    name: 'Routescan',
    url: 'https://redbelly.routescan.io',
  ),
);

/// Redbelly Network Testnet (chain id 153).
final Chain redbellyTestnet = Chain(
  id: 153,
  name: 'Redbelly Network Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Redbelly Native Coin',
    symbol: 'RBNT',
    decimals: 18,
  ),
  rpcUrls: const ['https://governors.testnet.redbelly.network'],
  blockExplorer: const BlockExplorer(
    name: 'Routescan',
    url: 'https://redbelly.testnet.routescan.io',
  ),
);

/// Reddio (chain id 50342).
final Chain reddio = Chain(
  id: 50342,
  name: 'Reddio',
  nativeCurrency: const NativeCurrency(
    name: 'Reddio',
    symbol: 'RED',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.reddio.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://reddio.cloud.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 848849,
    ),
  },
);

/// Reddio Sepolia (chain id 50341).
final Chain reddioSepolia = Chain(
  id: 50341,
  name: 'Reddio Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Reddio',
    symbol: 'RED',
    decimals: 18,
  ),
  rpcUrls: const ['https://reddio-dev.reddio.com'],
  blockExplorer: const BlockExplorer(
    name: 'Reddioscan',
    url: 'https://reddio-devnet.l2scan.co',
  ),
);

/// Redstone (chain id 690).
final Chain redstone = Chain(
  id: 690,
  name: 'Redstone',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.redstonechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.redstone.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// REI Mainnet (chain id 47805).
final Chain rei = Chain(
  id: 47805,
  name: 'REI Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'REI',
    symbol: 'REI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.rei.network'],
  blockExplorer: const BlockExplorer(
    name: 'REI Scan',
    url: 'https://scan.rei.network',
  ),
);

/// Reya Network (chain id 1729).
final Chain reyaNetwork = Chain(
  id: 1729,
  name: 'Reya Network',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.reya.network'],
  blockExplorer: const BlockExplorer(
    name: 'Reya Network Explorer',
    url: 'https://explorer.reya.network',
  ),
);

/// RISE (chain id 4153).
final Chain rise = Chain(
  id: 4153,
  name: 'RISE',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.risechain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.risechain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// RISE Testnet (chain id 11155931).
final Chain riseTestnet = Chain(
  id: 11155931,
  name: 'RISE Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'RISE Testnet Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.riselabs.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.testnet.riselabs.xyz/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Rivalz (chain id 753).
final Chain rivalz = Chain(
  id: 753,
  name: 'Rivalz',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rivalz.calderachain.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Rivalz Caldera Explorer',
    url: 'https://rivalz.calderaexplorer.xyz',
  ),
);

/// Robinhood Chain (chain id 4663).
final Chain robinhood = Chain(
  id: 4663,
  name: 'Robinhood Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.chain.robinhood.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://robinhoodchain.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Robinhood Chain Testnet (chain id 46630).
final Chain robinhoodTestnet = Chain(
  id: 46630,
  name: 'Robinhood Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.chain.robinhood.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.testnet.chain.robinhood.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Rollux Mainnet (chain id 570).
final Chain rollux = Chain(
  id: 570,
  name: 'Rollux Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Syscoin',
    symbol: 'SYS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.rollux.com'],
  blockExplorer: const BlockExplorer(
    name: 'RolluxExplorer',
    url: 'https://explorer.rollux.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 119222,
    ),
  },
);

/// Rollux Testnet (chain id 57000).
final Chain rolluxTestnet = Chain(
  id: 57000,
  name: 'Rollux Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Syscoin',
    symbol: 'SYS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-tanenbaum.rollux.com/'],
  blockExplorer: const BlockExplorer(
    name: 'RolluxTestnetExplorer',
    url: 'https://rollux.tanenbaum.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1813675,
    ),
  },
);

/// Ronin (chain id 2020).
final Chain ronin = Chain(
  id: 2020,
  name: 'Ronin',
  nativeCurrency: const NativeCurrency(
    name: 'RON',
    symbol: 'RON',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.roninchain.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Ronin Explorer',
    url: 'https://app.roninchain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 26023535,
    ),
  },
);

/// The Root Network (chain id 7668).
final Chain root = Chain(
  id: 7668,
  name: 'The Root Network',
  nativeCurrency: const NativeCurrency(
    name: 'XRP',
    symbol: 'XRP',
    decimals: 18,
  ),
  rpcUrls: const ['https://root.rootnet.live/archive'],
  blockExplorer: const BlockExplorer(
    name: 'Rootscan',
    url: 'https://rootscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xc9C2E2429AeC354916c476B30d729deDdC94988d',
      blockCreated: 9218338,
    ),
  },
);

/// The Root Network - Porcini (chain id 7672).
final Chain rootPorcini = Chain(
  id: 7672,
  name: 'The Root Network - Porcini',
  nativeCurrency: const NativeCurrency(
    name: 'XRP',
    symbol: 'XRP',
    decimals: 18,
  ),
  rpcUrls: const ['https://porcini.rootnet.app/archive'],
  blockExplorer: const BlockExplorer(
    name: 'Rootscan',
    url: 'https://porcini.rootscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xc9C2E2429AeC354916c476B30d729deDdC94988d',
      blockCreated: 10555692,
    ),
  },
);

/// Rootstock Mainnet (chain id 30).
final Chain rootstock = Chain(
  id: 30,
  name: 'Rootstock Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Rootstock Bitcoin',
    symbol: 'RBTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-node.rsk.co'],
  blockExplorer: const BlockExplorer(
    name: 'RSK Explorer',
    url: 'https://explorer.rsk.co',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 4249540,
    ),
  },
);

/// Rootstock Testnet (chain id 31).
final Chain rootstockTestnet = Chain(
  id: 31,
  name: 'Rootstock Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Rootstock Bitcoin',
    symbol: 'tRBTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://public-node.testnet.rsk.co'],
  blockExplorer: const BlockExplorer(
    name: 'RSK Explorer',
    url: 'https://explorer.testnet.rootstock.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2771150,
    ),
  },
);

/// RSS3 VSL Mainnet (chain id 12553).
final Chain rss3 = Chain(
  id: 12553,
  name: 'RSS3 VSL Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'RSS3',
    symbol: 'RSS3',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.rss3.io'],
  blockExplorer: const BlockExplorer(
    name: 'RSS3 VSL Mainnet Scan',
    url: 'https://scan.rss3.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 14193,
    ),
  },
);

/// RSS3 VSL Sepolia Testnet (chain id 2331).
final Chain rss3Sepolia = Chain(
  id: 2331,
  name: 'RSS3 VSL Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'RSS3',
    symbol: 'RSS3',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.rss3.io'],
  blockExplorer: const BlockExplorer(
    name: 'RSS3 VSL Sepolia Testnet Scan',
    url: 'https://scan.testnet.rss3.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 55697,
    ),
  },
);

/// Saakuru Mainnet (chain id 7225878).
final Chain saakuru = Chain(
  id: 7225878,
  name: 'Saakuru Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'OAS',
    symbol: 'OAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.saakuru.network'],
  blockExplorer: const BlockExplorer(
    name: 'Saakuru Explorer',
    url: 'https://explorer.saakuru.network',
  ),
);

/// Saga (chain id 5464).
final Chain saga = Chain(
  id: 5464,
  name: 'Saga',
  nativeCurrency: const NativeCurrency(
    name: 'gas',
    symbol: 'GAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://sagaevm.jsonrpc.sagarpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Saga Explorer',
    url: 'https://sagaevm.sagaexplorer.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x864DDc9B50B9A0dF676d826c9B9EDe9F8913a160',
      blockCreated: 467530,
    ),
  },
);

/// Ronin Saigon Testnet (chain id 202601).
final Chain saigon = Chain(
  id: 202601,
  name: 'Ronin Saigon Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'RON',
    symbol: 'RON',
    decimals: 18,
  ),
  rpcUrls: const ['https://saigon-testnet.roninchain.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Saigon Explorer',
    url: 'https://saigon-explorer.roninchain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 18736871,
    ),
  },
);

/// Sanko (chain id 1996).
final Chain sanko = Chain(
  id: 1996,
  name: 'Sanko',
  nativeCurrency: const NativeCurrency(
    name: 'DMT',
    symbol: 'DMT',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.sanko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Sanko Explorer',
    url: 'https://explorer.sanko.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 37,
    ),
  },
);

/// Oasis Sapphire (chain id 23294).
final Chain sapphire = Chain(
  id: 23294,
  name: 'Oasis Sapphire',
  nativeCurrency: const NativeCurrency(
    name: 'Sapphire Rose',
    symbol: 'ROSE',
    decimals: 18,
  ),
  rpcUrls: const ['https://sapphire.oasis.io'],
  blockExplorer: const BlockExplorer(
    name: 'Oasis Explorer',
    url: 'https://explorer.oasis.io/mainnet/sapphire',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 734531,
    ),
  },
);

/// Oasis Sapphire Testnet (chain id 23295).
final Chain sapphireTestnet = Chain(
  id: 23295,
  name: 'Oasis Sapphire Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sapphire Test Rose',
    symbol: 'TEST',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.sapphire.oasis.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Oasis Explorer',
    url: 'https://explorer.oasis.io/testnet/sapphire',
  ),
);

/// SatoshiVM Alpha Mainnet (chain id 3109).
final Chain satoshiVM = Chain(
  id: 3109,
  name: 'SatoshiVM Alpha Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://alpha-rpc-node-http.svmscan.io'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://svmscan.io',
  ),
);

/// SatoshiVM Testnet (chain id 3110).
final Chain satoshiVMTestnet = Chain(
  id: 3110,
  name: 'SatoshiVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'BTC',
    symbol: 'BTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://test-rpc-node-http.svmscan.io'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://testnet.svmscan.io',
  ),
);

/// Scroll (chain id 534352).
final Chain scroll = Chain(
  id: 534352,
  name: 'Scroll',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.scroll.io'],
  blockExplorer: const BlockExplorer(
    name: 'Scrollscan',
    url: 'https://scrollscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 14,
    ),
  },
);

/// Scroll Sepolia (chain id 534351).
final Chain scrollSepolia = Chain(
  id: 534351,
  name: 'Scroll Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia-rpc.scroll.io'],
  blockExplorer: const BlockExplorer(
    name: 'Scrollscan',
    url: 'https://sepolia.scrollscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 9473,
    ),
  },
);

/// Sei Network (chain id 1329).
final Chain sei = Chain(
  id: 1329,
  name: 'Sei Network',
  nativeCurrency: const NativeCurrency(
    name: 'Sei',
    symbol: 'SEI',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm-rpc.sei-apis.com/'],
  blockExplorer: const BlockExplorer(
    name: 'Seiscan',
    url: 'https://seiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Sei Testnet (chain id 1328).
final Chain seiTestnet = Chain(
  id: 1328,
  name: 'Sei Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sei',
    symbol: 'SEI',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm-rpc-testnet.sei-apis.com'],
  blockExplorer: const BlockExplorer(
    name: 'Seiscan',
    url: 'https://testnet.seiscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 98697651,
    ),
  },
);

/// Seismic Devnet (chain id 5124).
final Chain seismicDevnet = Chain(
  id: 5124,
  name: 'Seismic Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'Seismic Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://node-2.seismicdev.net/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Seismic Devnet Explorer',
    url: 'https://explorer-2.seismicdev.net',
  ),
);

/// Sentrix Chain (chain id 7119).
final Chain sentrix = Chain(
  id: 7119,
  name: 'Sentrix Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Sentrix',
    symbol: 'SRX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sentrixchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'SentrixScan',
    url: 'https://scan.sentrixchain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xFd4b34b5763f54a580a0d9f7997A2A993ef9ceE9',
      blockCreated: 717078,
    ),
  },
);

/// Sentrix Testnet (chain id 7120).
final Chain sentrixTestnet = Chain(
  id: 7120,
  name: 'Sentrix Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sentrix',
    symbol: 'SRX',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.sentrixchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'SentrixScan Testnet',
    url: 'https://scan-testnet.sentrixchain.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x7900826De548425c6BE56caEbD4760AB0155Cd54',
      blockCreated: 723191,
    ),
  },
);

/// Sepolia (chain id 11155111).
final Chain sepolia = Chain(
  id: 11155111,
  name: 'Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://11155111.rpc.thirdweb.com'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://sepolia.etherscan.io',
  ),
  contracts: const {
    'ensUniversalResolver': ChainContract(
      address: '0xeeeeeeee14d718c2b47d9923deab1335e144eeee',
      blockCreated: 8928790,
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 751532,
    ),
  },
);

/// Shape (chain id 360).
final Chain shape = Chain(
  id: 360,
  name: 'Shape',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.shape.network'],
  blockExplorer: const BlockExplorer(
    name: 'shapescan',
    url: 'https://shapescan.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1,
    ),
  },
);

/// Shape Sepolia Testnet (chain id 11011).
final Chain shapeSepolia = Chain(
  id: 11011,
  name: 'Shape Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.shape.network'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer-sepolia.shape.network/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1,
    ),
  },
);

/// Shardeum (chain id 8118).
final Chain shardeum = Chain(
  id: 8118,
  name: 'Shardeum',
  nativeCurrency: const NativeCurrency(
    name: 'Shardeum',
    symbol: 'SHM',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.shardeum.org'],
  blockExplorer: const BlockExplorer(
    name: 'Shardeum Explorer',
    url: 'https://explorer.shardeum.org',
  ),
);

/// Shardeum Sphinx (chain id 8082).
final Chain shardeumSphinx = Chain(
  id: 8082,
  name: 'Shardeum Sphinx',
  nativeCurrency: const NativeCurrency(
    name: 'SHARDEUM',
    symbol: 'SHM',
    decimals: 18,
  ),
  rpcUrls: const ['https://sphinx.shardeum.org'],
  blockExplorer: const BlockExplorer(
    name: 'Shardeum Explorer',
    url: 'https://explorer-sphinx.shardeum.org',
  ),
);

/// Shibarium (chain id 109).
final Chain shibarium = Chain(
  id: 109,
  name: 'Shibarium',
  nativeCurrency: const NativeCurrency(
    name: 'Bone',
    symbol: 'BONE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.shibrpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://shibariumscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x864Bf681ADD6052395188A89101A1B37d3B4C961',
      blockCreated: 265900,
    ),
  },
);

/// Puppynet Shibarium (chain id 157).
final Chain shibariumTestnet = Chain(
  id: 157,
  name: 'Puppynet Shibarium',
  nativeCurrency: const NativeCurrency(
    name: 'Bone',
    symbol: 'BONE',
    decimals: 18,
  ),
  rpcUrls: const ['https://puppynet.shibrpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://puppyscan.shib.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xA4029b74FBA366c926eDFA7Dd10B21C621170a4c',
      blockCreated: 3035769,
    ),
  },
);

/// Shiden (chain id 336).
final Chain shiden = Chain(
  id: 336,
  name: 'Shiden',
  nativeCurrency: const NativeCurrency(
    name: 'SDN',
    symbol: 'SDN',
    decimals: 18,
  ),
  rpcUrls: const ['https://shiden.public.blastapi.io'],
  blockExplorer: const BlockExplorer(
    name: 'Shiden Scan',
    url: 'https://shiden.subscan.io',
  ),
);

/// Shimmer (chain id 148).
final Chain shimmer = Chain(
  id: 148,
  name: 'Shimmer',
  nativeCurrency: const NativeCurrency(
    name: 'Shimmer',
    symbol: 'SMR',
    decimals: 18,
  ),
  rpcUrls: const ['https://json-rpc.evm.shimmer.network'],
  blockExplorer: const BlockExplorer(
    name: 'Shimmer Network Explorer',
    url: 'https://explorer.evm.shimmer.network',
  ),
);

/// Shimmer Testnet (chain id 1073).
final Chain shimmerTestnet = Chain(
  id: 1073,
  name: 'Shimmer Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Shimmer',
    symbol: 'SMR',
    decimals: 18,
  ),
  rpcUrls: const ['https://json-rpc.evm.testnet.shimmer.network'],
  blockExplorer: const BlockExplorer(
    name: 'Shimmer Network Explorer',
    url: 'https://explorer.evm.testnet.shimmer.network',
  ),
);

/// Sidra Chain (chain id 97453).
final Chain sidraChain = Chain(
  id: 97453,
  name: 'Sidra Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Sidra Digital Asset',
    symbol: 'SDA',
    decimals: 18,
  ),
  rpcUrls: const ['https://node.sidrachain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Sidra Chain Explorer',
    url: 'https://ledger.sidrachain.com',
  ),
);

/// Silent Data Mainnet (chain id 380929).
final Chain silentData = Chain(
  id: 380929,
  name: 'Silent Data Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.silentdata.com'],
  blockExplorer: const BlockExplorer(
    name: 'Silent Data Mainnet Explorer',
    url: 'https://explorer-mainnet.rollup.silentdata.com',
  ),
);

/// Silicon zkEVM (chain id 2355).
final Chain silicon = Chain(
  id: 2355,
  name: 'Silicon zkEVM',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc.silicon.network',
    'https://silicon-mainnet.nodeinfra.com',
  ],
  blockExplorer: const BlockExplorer(
    name: 'SiliconScope',
    url: 'https://scope.silicon.network',
  ),
);

/// Silicon Sepolia zkEVM (chain id 1722641160).
final Chain siliconSepolia = Chain(
  id: 1722641160,
  name: 'Silicon Sepolia zkEVM',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-sepolia.silicon.network',
    'https://silicon-testnet.nodeinfra.com',
  ],
  blockExplorer: const BlockExplorer(
    name: 'SiliconSepoliaScope',
    url: 'https://scope-sepolia.silicon.network',
  ),
);

/// Six Protocol (chain id 98).
final Chain sixProtocol = Chain(
  id: 98,
  name: 'Six Protocol',
  nativeCurrency: const NativeCurrency(
    name: 'SIX',
    symbol: 'SIX',
    decimals: 18,
  ),
  rpcUrls: const ['https://sixnet-rpc-evm.sixprotocol.net'],
  blockExplorer: const BlockExplorer(
    name: 'Six Protocol Scan',
    url: 'https://sixscan.io/sixnet',
  ),
);

/// SKALE Base (chain id 1187947933).
final Chain skaleBase = Chain(
  id: 1187947933,
  name: 'SKALE Base',
  nativeCurrency: const NativeCurrency(
    name: 'Credits',
    symbol: 'CREDIT',
    decimals: 18,
  ),
  rpcUrls: const ['https://skale-base.skalenodes.com/v1/base'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://skale-base-explorer.skalenodes.com/',
  ),
);

/// SKALE Base Sepolia Testnet (chain id 324705682).
final Chain skaleBaseSepoliaTestnet = Chain(
  id: 324705682,
  name: 'SKALE Base Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Credits',
    symbol: 'CREDIT',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://base-sepolia-testnet.skalenodes.com/v1/base-testnet',
  ],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://base-sepolia-testnet-explorer.skalenodes.com/',
  ),
);

/// SKALE | Block Brawlers (chain id 391845894).
final Chain skaleBlockBrawlers = Chain(
  id: 391845894,
  name: 'SKALE | Block Brawlers',
  nativeCurrency: const NativeCurrency(
    name: 'BRAWL',
    symbol: 'BRAWL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/frayed-decent-antares'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://frayed-decent-antares.explorer.mainnet.skalenodes.com',
  ),
);

/// SKALE Calypso Hub (chain id 1564830818).
final Chain skaleCalypso = Chain(
  id: 1564830818,
  name: 'SKALE Calypso Hub',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://mainnet.skalenodes.com/v1/honorable-steel-rasalhague',
  ],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://honorable-steel-rasalhague.explorer.mainnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3107626,
    ),
  },
);

/// SKALE Calypso Testnet (chain id 974399131).
final Chain skaleCalypsoTestnet = Chain(
  id: 974399131,
  name: 'SKALE Calypso Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.skalenodes.com/v1/giant-half-dual-testnet'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://giant-half-dual-testnet.explorer.testnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 103220,
    ),
  },
);

/// SKALE | CryptoBlades (chain id 1026062157).
final Chain skaleCryptoBlades = Chain(
  id: 1026062157,
  name: 'SKALE | CryptoBlades',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://mainnet.skalenodes.com/v1/affectionate-immediate-pollux',
  ],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url:
        'https://affectionate-immediate-pollux.explorer.mainnet.skalenodes.com',
  ),
);

/// SKALE | Crypto Colosseum (chain id 1032942172).
final Chain skaleCryptoColosseum = Chain(
  id: 1032942172,
  name: 'SKALE | Crypto Colosseum',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/haunting-devoted-deneb'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://haunting-devoted-deneb.explorer.mainnet.skalenodes.com',
  ),
);

/// SKALE Europa Hub (chain id 2046399126).
final Chain skaleEuropa = Chain(
  id: 2046399126,
  name: 'SKALE Europa Hub',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/elated-tan-skat'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://elated-tan-skat.explorer.mainnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 3113495,
    ),
  },
);

/// SKALE Europa Testnet (chain id 1444673419).
final Chain skaleEuropaTestnet = Chain(
  id: 1444673419,
  name: 'SKALE Europa Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.skalenodes.com/v1/juicy-low-small-testnet'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://juicy-low-small-testnet.explorer.testnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 110858,
    ),
  },
);

/// Exorde Network (chain id 2139927552).
final Chain skaleExorde = Chain(
  id: 2139927552,
  name: 'Exorde Network',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/light-vast-diphda'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://light-vast-diphda.explorer.mainnet.skalenodes.com',
  ),
);

/// SKALE | Human Protocol (chain id 1273227453).
final Chain skaleHumanProtocol = Chain(
  id: 1273227453,
  name: 'SKALE | Human Protocol',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/wan-red-ain'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://wan-red-ain.explorer.mainnet.skalenodes.com',
  ),
);

/// SKALE Nebula Hub (chain id 1482601649).
final Chain skaleNebula = Chain(
  id: 1482601649,
  name: 'SKALE Nebula Hub',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/green-giddy-denebola'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://green-giddy-denebola.explorer.mainnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2372986,
    ),
  },
);

/// SKALE Nebula Testnet (chain id 37084624).
final Chain skaleNebulaTestnet = Chain(
  id: 37084624,
  name: 'SKALE Nebula Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.skalenodes.com/v1/lanky-ill-funny-testnet'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://lanky-ill-funny-testnet.explorer.testnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 105141,
    ),
  },
);

/// SKALE | Razor Network (chain id 278611351).
final Chain skaleRazor = Chain(
  id: 278611351,
  name: 'SKALE | Razor Network',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/turbulent-unique-scheat'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://turbulent-unique-scheat.explorer.mainnet.skalenodes.com',
  ),
);

/// SKALE Titan Hub (chain id 1350216234).
final Chain skaleTitan = Chain(
  id: 1350216234,
  name: 'SKALE Titan Hub',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.skalenodes.com/v1/parallel-stormy-spica'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://parallel-stormy-spica.explorer.mainnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2076458,
    ),
  },
);

/// SKALE Titan Testnet (chain id 1020352220).
final Chain skaleTitanTestnet = Chain(
  id: 1020352220,
  name: 'SKALE Titan Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'sFUEL',
    symbol: 'sFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.skalenodes.com/v1/aware-fake-trim-testnet'],
  blockExplorer: const BlockExplorer(
    name: 'SKALE Explorer',
    url: 'https://aware-fake-trim-testnet.explorer.testnet.skalenodes.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 104072,
    ),
  },
);

/// Forma Sketchpad (chain id 984123).
final Chain sketchpad = Chain(
  id: 984123,
  name: 'Forma Sketchpad',
  nativeCurrency: const NativeCurrency(
    name: 'TIA',
    symbol: 'TIA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sketchpad-1.forma.art'],
  blockExplorer: const BlockExplorer(
    name: 'Sketchpad Explorer',
    url: 'https://explorer.sketchpad-1.forma.art',
  ),
);

/// SnaxChain (chain id 2192).
final Chain snax = Chain(
  id: 2192,
  name: 'SnaxChain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.snaxchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Snax Explorer',
    url: 'https://explorer.snaxchain.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// SnaxChain Testnet (chain id 13001).
final Chain snaxTestnet = Chain(
  id: 13001,
  name: 'SnaxChain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.snaxchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Snax Explorer',
    url: 'https://testnet-explorer.snaxchain.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
    ),
  },
);

/// Somnia (chain id 5031).
final Chain somnia = Chain(
  id: 5031,
  name: 'Somnia',
  nativeCurrency: const NativeCurrency(
    name: 'Somnia',
    symbol: 'SOMI',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.infra.mainnet.somnia.network'],
  blockExplorer: const BlockExplorer(
    name: 'Somnia Explorer',
    url: 'https://explorer.somnia.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x5e44F178E8cF9B2F5409B6f18ce936aB817C5a11',
      blockCreated: 38516341,
    ),
  },
);

/// Somnia Testnet (chain id 50312).
final Chain somniaTestnet = Chain(
  id: 50312,
  name: 'Somnia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'STT',
    symbol: 'STT',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.infra.testnet.somnia.network'],
  blockExplorer: const BlockExplorer(
    name: 'Somnia Testnet Explorer',
    url: 'https://shannon-explorer.somnia.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x841b8199E6d3Db3C6f264f6C2bd8848b3cA64223',
      blockCreated: 71314235,
    ),
  },
);

/// Soneium Mainnet (chain id 1868).
final Chain soneium = Chain(
  id: 1868,
  name: 'Soneium Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.soneium.org'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://soneium.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1,
    ),
  },
);

/// Soneium Minato Testnet (chain id 1946).
final Chain soneiumMinato = Chain(
  id: 1946,
  name: 'Soneium Minato Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.minato.soneium.org'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://soneium-minato.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1,
    ),
  },
);

/// Songbird Canary-Network (chain id 19).
final Chain songbird = Chain(
  id: 19,
  name: 'Songbird Canary-Network',
  nativeCurrency: const NativeCurrency(
    name: 'Songbird',
    symbol: 'SGB',
    decimals: 18,
  ),
  rpcUrls: const ['https://songbird-api.flare.network/ext/C/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Songbird Explorer',
    url: 'https://songbird-explorer.flare.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 13382504,
    ),
  },
);

/// Songbird Testnet Coston (chain id 16).
final Chain songbirdTestnet = Chain(
  id: 16,
  name: 'Songbird Testnet Coston',
  nativeCurrency: const NativeCurrency(
    name: 'Coston Flare',
    symbol: 'CFLR',
    decimals: 18,
  ),
  rpcUrls: const ['https://coston-api.flare.network/ext/C/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Coston Explorer',
    url: 'https://coston-explorer.flare.network',
  ),
);

/// Sonic (chain id 146).
final Chain sonic = Chain(
  id: 146,
  name: 'Sonic',
  nativeCurrency: const NativeCurrency(
    name: 'Sonic',
    symbol: 'S',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.soniclabs.com'],
  blockExplorer: const BlockExplorer(
    name: 'Sonic Explorer',
    url: 'https://sonicscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 60,
    ),
  },
);

/// Sonic Blaze Testnet (chain id 57054).
final Chain sonicBlazeTestnet = Chain(
  id: 57054,
  name: 'Sonic Blaze Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sonic',
    symbol: 'S',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.blaze.soniclabs.com'],
  blockExplorer: const BlockExplorer(
    name: 'Sonic Blaze Testnet Explorer',
    url: 'https://testnet.sonicscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1100,
    ),
  },
);

/// Sonic Testnet (chain id 64165).
final Chain sonicTestnet = Chain(
  id: 64165,
  name: 'Sonic Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sonic',
    symbol: 'S',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.soniclabs.com'],
  blockExplorer: const BlockExplorer(
    name: 'Sonic Testnet Explorer',
    url: 'https://testnet.soniclabs.com/',
  ),
);

/// Sophon (chain id 50104).
final Chain sophon = Chain(
  id: 50104,
  name: 'Sophon',
  nativeCurrency: const NativeCurrency(
    name: 'Sophon',
    symbol: 'SOPH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sophon.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Sophon Block Explorer',
    url: 'https://explorer.sophon.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x5f4867441d2416cA88B1b3fd38f21811680CD2C8',
      blockCreated: 116,
    ),
  },
);

/// Sophon Testnet (chain id 531050104).
final Chain sophonTestnet = Chain(
  id: 531050104,
  name: 'Sophon Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Sophon',
    symbol: 'SOPH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.sophon.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Sophon Block Explorer',
    url: 'https://explorer.testnet.sophon.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x83c04d112adedA2C6D9037bb6ecb42E7f0b108Af',
      blockCreated: 15642,
    ),
  },
);

/// Sova (chain id 100021).
final Chain sova = Chain(
  id: 100021,
  name: 'Sova',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.sova.io'],
  blockExplorer: const BlockExplorer(
    name: 'Sova Block Explorer',
    url: 'https://explorer.sova.io',
  ),
);

/// Sova Network Sepolia (chain id 120893).
final Chain sovaSepolia = Chain(
  id: 120893,
  name: 'Sova Network Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.sova.io'],
  blockExplorer: const BlockExplorer(
    name: 'Sova Sepolia Explorer',
    url: 'https://explorer.testnet.sova.io',
  ),
);

/// Chiliz Spicy Testnet (chain id 88882).
final Chain spicy = Chain(
  id: 88882,
  name: 'Chiliz Spicy Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'CHZ',
    symbol: 'CHZ',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://spicy-rpc.chiliz.com',
    'https://chiliz-spicy-rpc.publicnode.com',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Chiliz Explorer',
    url: 'http://spicy-explorer.chiliz.com',
  ),
);

/// Stable Mainnet (chain id 988).
final Chain stable = Chain(
  id: 988,
  name: 'Stable Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'USDT0',
    symbol: 'USDT0',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.stable.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Stablescan',
    url: 'https://stablescan.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2423647,
    ),
  },
);

/// Stable Testnet (chain id 2201).
final Chain stableTestnet = Chain(
  id: 2201,
  name: 'Stable Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'USDT0',
    symbol: 'USDT0',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.stable.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Stablescan',
    url: 'https://testnet.stablescan.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 22364430,
    ),
  },
);

/// Status Network Sepolia (chain id 1660990954).
final Chain statusSepolia = Chain(
  id: 1660990954,
  name: 'Status Network Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://public.sepolia.rpc.status.network'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://sepoliascan.status.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1578364,
    ),
  },
);

/// Step Network (chain id 1234).
final Chain step = Chain(
  id: 1234,
  name: 'Step Network',
  nativeCurrency: const NativeCurrency(
    name: 'FITFI',
    symbol: 'FITFI',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.step.network'],
  blockExplorer: const BlockExplorer(
    name: 'Step Scan',
    url: 'https://stepscan.io',
  ),
);

/// Story (chain id 1514).
final Chain story = Chain(
  id: 1514,
  name: 'Story',
  nativeCurrency: const NativeCurrency(
    name: 'IP Token',
    symbol: 'IP',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.storyrpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Story explorer',
    url: 'https://storyscan.io',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x5dc881dda4e4a8d312be3544ad13118d1a04cb17',
      blockCreated: 648924,
    ),
    'ensUniversalResolver': ChainContract(
      address: '0xddfb18888a9466688235887dec2a10c4f5effee9',
      blockCreated: 649114,
    ),
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 340998,
    ),
  },
);

/// Story Aeneid (chain id 1315).
final Chain storyAeneid = Chain(
  id: 1315,
  name: 'Story Aeneid',
  nativeCurrency: const NativeCurrency(name: 'IP', symbol: 'IP', decimals: 18),
  rpcUrls: const ['https://aeneid.storyrpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Story Aeneid Explorer',
    url: 'https://aeneid.storyscan.io',
  ),
  contracts: const {
    'ensRegistry': ChainContract(
      address: '0x5dC881dDA4e4a8d312be3544AD13118D1a04Cb17',
      blockCreated: 1322033,
    ),
    'ensUniversalResolver': ChainContract(
      address: '0x6D3B3F99177FB2A5de7F9E928a9BD807bF7b5BAD',
      blockCreated: 1322097,
    ),
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 1792,
    ),
  },
);

/// Story Odyssey (chain id 1516).
final Chain storyOdyssey = Chain(
  id: 1516,
  name: 'Story Odyssey',
  nativeCurrency: const NativeCurrency(name: 'IP', symbol: 'IP', decimals: 18),
  rpcUrls: const ['https://rpc.odyssey.storyrpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Story Odyssey Explorer',
    url: 'https://odyssey.storyscan.xyz',
  ),
);

/// Story Testnet (chain id 1513).
final Chain storyTestnet = Chain(
  id: 1513,
  name: 'Story Testnet',
  nativeCurrency: const NativeCurrency(name: 'IP', symbol: 'IP', decimals: 18),
  rpcUrls: const ['https://testnet.storyrpc.io'],
  blockExplorer: const BlockExplorer(
    name: 'Story Testnet Explorer',
    url: 'https://testnet.storyscan.xyz',
  ),
);

/// Stratis Mainnet (chain id 105105).
final Chain stratis = Chain(
  id: 105105,
  name: 'Stratis Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Stratis',
    symbol: 'STRAX',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.stratisevm.com'],
  blockExplorer: const BlockExplorer(
    name: 'Stratis Explorer',
    url: 'https://explorer.stratisevm.com',
  ),
);

/// Subtensor EVM (chain id 964).
final Chain subtensorEvm = Chain(
  id: 964,
  name: 'Subtensor EVM',
  nativeCurrency: const NativeCurrency(
    name: 'TAO',
    symbol: 'TAO',
    decimals: 18,
  ),
  rpcUrls: const ['https://lite.chain.opentensor.ai'],
  blockExplorer: const BlockExplorer(
    name: 'Taostats EVM Explorer',
    url: 'https://evm.taostats.io',
  ),
);

/// SuperLumio (chain id 8866).
final Chain superlumio = Chain(
  id: 8866,
  name: 'SuperLumio',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.lumio.io'],
  blockExplorer: const BlockExplorer(
    name: 'Lumio explorer',
    url: 'https://explorer.lumio.io',
  ),
);

/// Superposition (chain id 55244).
final Chain superposition = Chain(
  id: 55244,
  name: 'Superposition',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.superposition.so'],
  blockExplorer: const BlockExplorer(
    name: 'Superposition Explorer',
    url: 'https://explorer.superposition.so',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 39,
    ),
  },
);

/// Superseed (chain id 5330).
final Chain superseed = Chain(
  id: 5330,
  name: 'Superseed',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.superseed.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Superseed Explorer',
    url: 'https://explorer.superseed.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Superseed Sepolia (chain id 53302).
final Chain superseedSepolia = Chain(
  id: 53302,
  name: 'Superseed Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.superseed.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Superseed Sepolia Explorer',
    url: 'https://sepolia-explorer.superseed.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Surge Testnet (chain id 763375).
final Chain surgeTestnet = Chain(
  id: 763375,
  name: 'Surge Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://l2-rpc.hoodi.surge.wtf'],
  blockExplorer: const BlockExplorer(
    name: 'Surge Testnet Blockscout',
    url: 'https://explorer.hoodi.surge.wtf',
  ),
);

/// Swan Chain Mainnet (chain id 254).
final Chain swan = Chain(
  id: 254,
  name: 'Swan Chain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet-rpc.swanchain.org'],
  blockExplorer: const BlockExplorer(
    name: 'Swan Explorer',
    url: 'https://swanscan.io',
  ),
);

/// Swan Proxima Testnet (chain id 20241133).
final Chain swanProximaTestnet = Chain(
  id: 20241133,
  name: 'Swan Proxima Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Swan Ether',
    symbol: 'sETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-proxima.swanchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Swan Explorer',
    url: 'https://proxima-explorer.swanchain.io',
  ),
);

/// Swan Saturn Testnet (chain id 2024).
final Chain swanSaturnTestnet = Chain(
  id: 2024,
  name: 'Swan Saturn Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Swan Ether',
    symbol: 'sETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://saturn-rpc.swanchain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Swan Explorer',
    url: 'https://saturn-explorer.swanchain.io',
  ),
);

/// Swellchain (chain id 1923).
final Chain swellchain = Chain(
  id: 1923,
  name: 'Swellchain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://swell-mainnet.alt.technology'],
  blockExplorer: const BlockExplorer(
    name: 'Swell Explorer',
    url: 'https://explorer.swellnetwork.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1,
    ),
  },
);

/// Swellchain Testnet (chain id 1924).
final Chain swellchainTestnet = Chain(
  id: 1924,
  name: 'Swellchain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://swell-testnet.alt.technology'],
  blockExplorer: const BlockExplorer(
    name: 'Swellchain Testnet Explorer',
    url: 'https://swell-testnet-explorer.alt.technology',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1,
    ),
  },
);

/// SwissDLT Mainnet (chain id 94).
final Chain swissdlt = Chain(
  id: 94,
  name: 'SwissDLT Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'BCTS',
    symbol: 'BCTS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.swissdlt.ch'],
  blockExplorer: const BlockExplorer(
    name: 'SwissDLT Explorer',
    url: 'https://explorer.swissdlt.ch',
  ),
);

/// Syscoin Mainnet (chain id 57).
final Chain syscoin = Chain(
  id: 57,
  name: 'Syscoin Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Syscoin',
    symbol: 'SYS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.syscoin.org'],
  blockExplorer: const BlockExplorer(
    name: 'SyscoinExplorer',
    url: 'https://explorer.syscoin.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 287139,
    ),
  },
);

/// Syscoin Tanenbaum Testnet (chain id 5700).
final Chain syscoinTestnet = Chain(
  id: 5700,
  name: 'Syscoin Tanenbaum Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Syscoin',
    symbol: 'SYS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.tanenbaum.io'],
  blockExplorer: const BlockExplorer(
    name: 'SyscoinTestnetExplorer',
    url: 'https://tanenbaum.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 271288,
    ),
  },
);

/// TAC (chain id 239).
final Chain tac = Chain(
  id: 239,
  name: 'TAC',
  nativeCurrency: const NativeCurrency(
    name: 'TAC',
    symbol: 'TAC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.ankr.com/tac'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://tac.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// TAC SPB Testnet (chain id 2391).
final Chain tacSPB = Chain(
  id: 2391,
  name: 'TAC SPB Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'TAC',
    symbol: 'TAC',
    decimals: 18,
  ),
  rpcUrls: const ['https://spb.rpc.tac.build'],
  blockExplorer: const BlockExplorer(
    name: 'TAC',
    url: 'https://spb.explorer.tac.build',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 471429,
    ),
  },
);

/// Taiko Mainnet (chain id 167000).
final Chain taiko = Chain(
  id: 167000,
  name: 'Taiko Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.taiko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://taikoscan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 11269,
    ),
  },
);

/// Taiko Hekla L2 (chain id 167009).
final Chain taikoHekla = Chain(
  id: 167009,
  name: 'Taiko Hekla L2',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hekla.taiko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Taikoscan',
    url: 'https://hekla.taikoscan.network',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 59757,
    ),
  },
);

/// Taiko Hoodi (chain id 167013).
final Chain taikoHoodi = Chain(
  id: 167013,
  name: 'Taiko Hoodi',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.hoodi.taiko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Etherscan',
    url: 'https://hoodi.taikoscan.io/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 581116,
    ),
  },
);

/// Taiko Jolnir (Alpha-5 Testnet) (chain id 167007).
final Chain taikoJolnir = Chain(
  id: 167007,
  name: 'Taiko Jolnir (Alpha-5 Testnet)',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.jolnir.taiko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.jolnir.taiko.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 732706,
    ),
  },
);

/// Taiko Katla (Alpha-6 Testnet) (chain id 167008).
final Chain taikoKatla = Chain(
  id: 167008,
  name: 'Taiko Katla (Alpha-6 Testnet)',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.katla.taiko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.katla.taiko.xyz',
  ),
);

/// Taiko (Alpha-3 Testnet) (chain id 167005).
final Chain taikoTestnetSepolia = Chain(
  id: 167005,
  name: 'Taiko (Alpha-3 Testnet)',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.test.taiko.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.test.taiko.xyz',
  ),
);

/// Taraxa Mainnet (chain id 841).
final Chain taraxa = Chain(
  id: 841,
  name: 'Taraxa Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Tara',
    symbol: 'TARA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.mainnet.taraxa.io'],
  blockExplorer: const BlockExplorer(
    name: 'Taraxa Explorer',
    url: 'https://explorer.mainnet.taraxa.io',
  ),
);

/// Taraxa Testnet (chain id 842).
final Chain taraxaTestnet = Chain(
  id: 842,
  name: 'Taraxa Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Tara',
    symbol: 'TARA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.taraxa.io'],
  blockExplorer: const BlockExplorer(
    name: 'Taraxa Explorer',
    url: 'https://explorer.testnet.taraxa.io',
  ),
);

/// Tea Sepolia (chain id 10218).
final Chain teaSepolia = Chain(
  id: 10218,
  name: 'Tea Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Sepolia Tea',
    symbol: 'TEA',
    decimals: 18,
  ),
  rpcUrls: const ['https://tea-sepolia.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Tea Sepolia Explorer',
    url: 'https://sepolia.tea.xyz',
  ),
);

/// Telcoin Adiri Testnet (chain id 2017).
final Chain telcoinTestnet = Chain(
  id: 2017,
  name: 'Telcoin Adiri Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Telcoin',
    symbol: 'TEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.telcoin.network'],
  blockExplorer: const BlockExplorer(
    name: 'telscan',
    url: 'https://telscan.io',
  ),
);

/// Telos (chain id 40).
final Chain telos = Chain(
  id: 40,
  name: 'Telos',
  nativeCurrency: const NativeCurrency(
    name: 'Telos',
    symbol: 'TLOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.telos.net'],
  blockExplorer: const BlockExplorer(
    name: 'Teloscan',
    url: 'https://www.teloscan.io/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 246530709,
    ),
  },
);

/// Telos (chain id 41).
final Chain telosTestnet = Chain(
  id: 41,
  name: 'Telos',
  nativeCurrency: const NativeCurrency(
    name: 'Telos',
    symbol: 'TLOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.telos.net'],
  blockExplorer: const BlockExplorer(
    name: 'Teloscan (testnet)',
    url: 'https://testnet.teloscan.io/',
  ),
);

/// Tempo Mainnet (chain id 4217).
final Chain tempo = Chain(
  id: 4217,
  name: 'Tempo Mainnet',
  nativeCurrency: const NativeCurrency(name: 'USD', symbol: 'USD', decimals: 6),
  rpcUrls: const ['https://rpc.tempo.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Tempo Explorer',
    url: 'https://explore.tempo.xyz',
  ),
);

/// Tempo Devnet (chain id 31318).
final Chain tempoDevnet = Chain(
  id: 31318,
  name: 'Tempo Devnet',
  nativeCurrency: const NativeCurrency(name: 'USD', symbol: 'USD', decimals: 6),
  rpcUrls: const ['https://rpc.devnet.tempoxyz.dev'],
  blockExplorer: const BlockExplorer(
    name: 'Tempo Explorer',
    url: 'https://explore.devnet.tempo.xyz',
  ),
);

/// Tempo (chain id 1337).
final Chain tempoLocalnet = Chain(
  id: 1337,
  name: 'Tempo',
  nativeCurrency: const NativeCurrency(name: 'USD', symbol: 'USD', decimals: 6),
  rpcUrls: const ['http://localhost:8545'],
);

/// Tempo Testnet (Moderato) (chain id 42431).
final Chain tempoModerato = Chain(
  id: 42431,
  name: 'Tempo Testnet (Moderato)',
  nativeCurrency: const NativeCurrency(name: 'USD', symbol: 'USD', decimals: 6),
  rpcUrls: const ['https://rpc.moderato.tempo.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Tempo Explorer',
    url: 'https://explore.testnet.tempo.xyz',
  ),
);

/// Tenet (chain id 1559).
final Chain tenet = Chain(
  id: 1559,
  name: 'Tenet',
  nativeCurrency: const NativeCurrency(
    name: 'TENET',
    symbol: 'TENET',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.tenet.org'],
  blockExplorer: const BlockExplorer(
    name: 'TenetScan Mainnet',
    url: 'https://tenetscan.io',
  ),
);

/// Ternoa (chain id 752025).
final Chain ternoa = Chain(
  id: 752025,
  name: 'Ternoa',
  nativeCurrency: const NativeCurrency(
    name: 'Capsule Coin',
    symbol: 'CAPS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-mainnet.zkevm.ternoa.network'],
  blockExplorer: const BlockExplorer(
    name: 'Ternoa Explorer',
    url: 'https://explorer-mainnet.zkevm.ternoa.network',
  ),
);

/// ThaiChain (chain id 7).
final Chain thaiChain = Chain(
  id: 7,
  name: 'ThaiChain',
  nativeCurrency: const NativeCurrency(
    name: 'TCH',
    symbol: 'TCH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.thaichain.org'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://exp.thaichain.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0DaD6130e832c21719C5CE3bae93454E16A84826',
      blockCreated: 4806386,
    ),
  },
);

/// THAT Mainnet (chain id 8428).
final Chain that = Chain(
  id: 8428,
  name: 'THAT Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'THAT',
    symbol: 'THAT',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.thatchain.io/mainnet'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://that.blockscout.com',
  ),
);

/// Theta Mainnet (chain id 361).
final Chain theta = Chain(
  id: 361,
  name: 'Theta Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'TFUEL',
    symbol: 'TFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc-api.thetatoken.org/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Theta Explorer',
    url: 'https://explorer.thetatoken.org',
  ),
);

/// Theta Testnet (chain id 365).
final Chain thetaTestnet = Chain(
  id: 365,
  name: 'Theta Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'TFUEL',
    symbol: 'TFUEL',
    decimals: 18,
  ),
  rpcUrls: const ['https://eth-rpc-api-testnet.thetatoken.org/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Theta Explorer',
    url: 'https://testnet-explorer.thetatoken.org',
  ),
);

/// ThunderCore Mainnet (chain id 108).
final Chain thunderCore = Chain(
  id: 108,
  name: 'ThunderCore Mainnet',
  nativeCurrency: const NativeCurrency(name: 'TT', symbol: 'TT', decimals: 18),
  rpcUrls: const ['https://mainnet-rpc.thundercore.com'],
  blockExplorer: const BlockExplorer(
    name: 'ThunderCore Explorer',
    url: 'https://explorer-mainnet.thundercore.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 0,
    ),
  },
);

/// 5ireChain Thunder Testnet (chain id 997).
final Chain thunderTestnet = Chain(
  id: 997,
  name: '5ireChain Thunder Testnet',
  nativeCurrency: const NativeCurrency(
    name: '5ire Token',
    symbol: '5IRE',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.5ire.network'],
  blockExplorer: const BlockExplorer(
    name: '5ireChain Thunder Explorer',
    url: 'https://testnet.5irescan.io/',
  ),
);

/// TikTrix Testnet (chain id 62092).
final Chain tiktrixTestnet = Chain(
  id: 62092,
  name: 'TikTrix Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'tTTX',
    symbol: 'tTTX',
    decimals: 18,
  ),
  rpcUrls: const ['https://tiktrix-rpc.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'TikTrix Testnet Explorer',
    url: 'https://tiktrix.xyz',
  ),
);

/// Tomb Mainnet (chain id 6969).
final Chain tomb = Chain(
  id: 6969,
  name: 'Tomb Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'TOMB',
    symbol: 'TOMB',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.tombchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Tomb Explorer',
    url: 'https://tombscout.com',
  ),
);

/// Treasure (chain id 61166).
final Chain treasure = Chain(
  id: 61166,
  name: 'Treasure',
  nativeCurrency: const NativeCurrency(
    name: 'MAGIC',
    symbol: 'MAGIC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.treasure.lol'],
  blockExplorer: const BlockExplorer(
    name: 'Treasure Block Explorer',
    url: 'https://treasurescan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x2e29fe39496a56856D8698bD43e1dF4D0CE6266a',
      blockCreated: 101,
    ),
  },
);

/// Treasure Topaz Testnet (chain id 978658).
final Chain treasureTopaz = Chain(
  id: 978658,
  name: 'Treasure Topaz Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'MAGIC',
    symbol: 'MAGIC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.topaz.treasure.lol'],
  blockExplorer: const BlockExplorer(
    name: 'Treasure Topaz Block Explorer',
    url: 'https://topaz.treasurescan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xF9cda624FBC7e059355ce98a31693d299FACd963',
      blockCreated: 108112,
    ),
  },
);

/// Tron (chain id 728126428).
final Chain tron = Chain(
  id: 728126428,
  name: 'Tron',
  nativeCurrency: const NativeCurrency(
    name: 'TRON',
    symbol: 'TRX',
    decimals: 6,
  ),
  rpcUrls: const ['https://api.trongrid.io/jsonrpc'],
  blockExplorer: const BlockExplorer(
    name: 'Tronscan',
    url: 'https://tronscan.org',
  ),
);

/// Tron Nile (chain id 3448148188).
final Chain tronNile = Chain(
  id: 3448148188,
  name: 'Tron Nile',
  nativeCurrency: const NativeCurrency(
    name: 'TRON',
    symbol: 'TRX',
    decimals: 6,
  ),
  rpcUrls: const ['https://nile.trongrid.io/jsonrpc'],
  blockExplorer: const BlockExplorer(
    name: 'Tronscan',
    url: 'https://nile.tronscan.org',
  ),
);

/// Tron Shasta (chain id 2494104990).
final Chain tronShasta = Chain(
  id: 2494104990,
  name: 'Tron Shasta',
  nativeCurrency: const NativeCurrency(
    name: 'TRON',
    symbol: 'TRX',
    decimals: 6,
  ),
  rpcUrls: const ['https://api.shasta.trongrid.io/jsonrpc'],
  blockExplorer: const BlockExplorer(
    name: 'Tronscan',
    url: 'https://shasta.tronscan.org',
  ),
);

/// Ubiq Mainnet (chain id 8).
final Chain ubiq = Chain(
  id: 8,
  name: 'Ubiq Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'UBQ',
    symbol: 'UBQ',
    decimals: 18,
  ),
  rpcUrls: const ['https://pyrus2.ubiqscan.io'],
  blockExplorer: const BlockExplorer(
    name: 'Ubiq Scan',
    url: 'https://ubiqscan.io',
  ),
);

/// Ultra EVM (chain id 19991).
final Chain ultra = Chain(
  id: 19991,
  name: 'Ultra EVM',
  nativeCurrency: const NativeCurrency(
    name: 'Ultra Token',
    symbol: 'UOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.ultra.eosusa.io'],
  blockExplorer: const BlockExplorer(
    name: 'Ultra EVM Explorer',
    url: 'https://evmexplorer.ultra.io',
  ),
);

/// Ultra EVM Testnet (chain id 18881).
final Chain ultraTestnet = Chain(
  id: 18881,
  name: 'Ultra EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ultra Token',
    symbol: 'UOS',
    decimals: 18,
  ),
  rpcUrls: const ['https://evm.test.ultra.eosusa.io'],
  blockExplorer: const BlockExplorer(
    name: 'Ultra EVM Testnet Explorer',
    url: 'https://evmexplorer.testnet.ultra.io',
  ),
);

/// Ultron Mainnet (chain id 1231).
final Chain ultron = Chain(
  id: 1231,
  name: 'Ultron Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ULX',
    symbol: 'ULX',
    decimals: 18,
  ),
  rpcUrls: const ['https://ultron-rpc.net'],
  blockExplorer: const BlockExplorer(
    name: 'Ultron Scan',
    url: 'https://ulxscan.com',
  ),
);

/// Ultron Testnet (chain id 1230).
final Chain ultronTestnet = Chain(
  id: 1230,
  name: 'Ultron Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ULX',
    symbol: 'ULX',
    decimals: 18,
  ),
  rpcUrls: const ['https://ultron-dev.io'],
  blockExplorer: const BlockExplorer(
    name: 'Ultron Scan',
    url: 'https://explorer.ultron-dev.io',
  ),
);

/// Unichain (chain id 130).
final Chain unichain = Chain(
  id: 130,
  name: 'Unichain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.unichain.org/'],
  blockExplorer: const BlockExplorer(
    name: 'Uniscan',
    url: 'https://uniscan.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// Unichain Sepolia (chain id 1301).
final Chain unichainSepolia = Chain(
  id: 1301,
  name: 'Unichain Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.unichain.org'],
  blockExplorer: const BlockExplorer(
    name: 'Uniscan',
    url: 'https://sepolia.uniscan.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// Unique Mainnet (chain id 8880).
final Chain unique = Chain(
  id: 8880,
  name: 'Unique Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'UNQ',
    symbol: 'UNQ',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.unique.network'],
  blockExplorer: const BlockExplorer(
    name: 'Unique Subscan',
    url: 'https://unique.subscan.io/',
  ),
);

/// Opal Testnet (chain id 8882).
final Chain uniqueOpal = Chain(
  id: 8882,
  name: 'Opal Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'OPL',
    symbol: 'OPL',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-opal.unique.network'],
  blockExplorer: const BlockExplorer(
    name: 'Opal Subscan',
    url: 'https://opal.subscan.io/',
  ),
);

/// Quartz Mainnet (chain id 8881).
final Chain uniqueQuartz = Chain(
  id: 8881,
  name: 'Quartz Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'QTZ',
    symbol: 'QTZ',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-quartz.unique.network'],
  blockExplorer: const BlockExplorer(
    name: 'Quartz Subscan',
    url: 'https://quartz.subscan.io/',
  ),
);

/// Unreal (chain id 18233).
final Chain unreal = Chain(
  id: 18233,
  name: 'Unreal',
  nativeCurrency: const NativeCurrency(
    name: 'reETH',
    symbol: 'reETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.unreal-orbit.gelato.digital'],
  blockExplorer: const BlockExplorer(
    name: 'Unreal Explorer',
    url: 'https://unreal.blockscout.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x8b6B0e60D8CD84898Ea8b981065A12F876eA5677',
      blockCreated: 1745,
    ),
  },
);

/// VALYGO NFT (chain id 7773777).
final Chain valygoNft = Chain(
  id: 7773777,
  name: 'VALYGO NFT',
  nativeCurrency: const NativeCurrency(
    name: 'VYO',
    symbol: 'VYO',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-gw-1.vyoscan.com/ext/bc/2RyzsmGypNQZPby1miwMMV8spTvhgd9qd2peNRzU1mErUQqSSw/rpc',
    'https://rpc-gw-2.vyoscan.com/ext/bc/2RyzsmGypNQZPby1miwMMV8spTvhgd9qd2peNRzU1mErUQqSSw/rpc',
  ],
  blockExplorer: const BlockExplorer(
    name: 'VYOScan NFT',
    url: 'https://nft.vyoscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x4469693a04BAE365795329a89b24F4Eb1303Ea08',
    ),
  },
);

/// VALYGO Smartchain (chain id 7771777).
final Chain valygoSmartchain = Chain(
  id: 7771777,
  name: 'VALYGO Smartchain',
  nativeCurrency: const NativeCurrency(
    name: 'VYO',
    symbol: 'VYO',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-gw-1.vyoscan.com/ext/bc/2t51dXsuxUvd9teY9TKEJmgxmxMk3CRF88UYTA4HQgjeYZqzSX/rpc',
    'https://rpc-gw-2.vyoscan.com/ext/bc/2t51dXsuxUvd9teY9TKEJmgxmxMk3CRF88UYTA4HQgjeYZqzSX/rpc',
  ],
  blockExplorer: const BlockExplorer(
    name: 'VYOScan',
    url: 'https://vyoscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xeFa3c632BD275750597cE9ca2346A5becAA0F344',
    ),
  },
);

/// Vana (chain id 1480).
final Chain vana = Chain(
  id: 1480,
  name: 'Vana',
  nativeCurrency: const NativeCurrency(
    name: 'Vana',
    symbol: 'VANA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.vana.org/'],
  blockExplorer: const BlockExplorer(
    name: 'Vana Block Explorer',
    url: 'https://vanascan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xD8d2dFca27E8797fd779F8547166A2d3B29d360E',
      blockCreated: 716763,
    ),
  },
);

/// Vana Moksha Testnet (chain id 14800).
final Chain vanaMoksha = Chain(
  id: 14800,
  name: 'Vana Moksha Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Vana',
    symbol: 'VANA',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.moksha.vana.org'],
  blockExplorer: const BlockExplorer(
    name: 'Vana Moksha Testnet',
    url: 'https://moksha.vanascan.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xD8d2dFca27E8797fd779F8547166A2d3B29d360E',
      blockCreated: 732283,
    ),
  },
);

/// Vanar Mainnet (chain id 2040).
final Chain vanar = Chain(
  id: 2040,
  name: 'Vanar Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'VANRY',
    symbol: 'VANRY',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.vanarchain.com'],
  blockExplorer: const BlockExplorer(
    name: 'Vanar Mainnet Explorer',
    url: 'https://explorer.vanarchain.com/',
  ),
);

/// Vechain (chain id 100009).
final Chain vechain = Chain(
  id: 100009,
  name: 'Vechain',
  nativeCurrency: const NativeCurrency(
    name: 'VeChain',
    symbol: 'VET',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.vechain.org'],
  blockExplorer: const BlockExplorer(
    name: 'Vechain Explorer',
    url: 'https://explore.vechain.org',
  ),
);

/// Velas EVM Mainnet (chain id 106).
final Chain velas = Chain(
  id: 106,
  name: 'Velas EVM Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'VLX',
    symbol: 'VLX',
    decimals: 18,
  ),
  rpcUrls: const ['https://evmexplorer.velas.com/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Velas Explorer',
    url: 'https://evmexplorer.velas.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 55883577,
    ),
  },
);

/// Viction (chain id 88).
final Chain viction = Chain(
  id: 88,
  name: 'Viction',
  nativeCurrency: const NativeCurrency(
    name: 'Viction',
    symbol: 'VIC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.viction.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'VIC Scan',
    url: 'https://vicscan.xyz',
  ),
);

/// Viction Testnet (chain id 89).
final Chain victionTestnet = Chain(
  id: 89,
  name: 'Viction Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Viction',
    symbol: 'VIC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.viction.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'VIC Scan',
    url: 'https://testnet.vicscan.xyz',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 12170179,
    ),
  },
);

/// Vision (chain id 888888).
final Chain vision = Chain(
  id: 888888,
  name: 'Vision',
  nativeCurrency: const NativeCurrency(
    name: 'VISION',
    symbol: 'VS',
    decimals: 18,
  ),
  rpcUrls: const ['https://infragrid.v.network/ethereum/compatible'],
  blockExplorer: const BlockExplorer(
    name: 'Vision Scan',
    url: 'https://visionscan.org',
  ),
);

/// Vision Testnet (chain id 666666).
final Chain visionTestnet = Chain(
  id: 666666,
  name: 'Vision Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'VISION',
    symbol: 'VS',
    decimals: 18,
  ),
  rpcUrls: const ['https://vpioneer.infragrid.v.network/ethereum/compatible'],
  blockExplorer: const BlockExplorer(
    name: 'Vision Scan',
    url: 'https://visionscan.org/?chain=vpioneer',
  ),
);

/// Wanchain (chain id 888).
final Chain wanchain = Chain(
  id: 888,
  name: 'Wanchain',
  nativeCurrency: const NativeCurrency(
    name: 'WANCHAIN',
    symbol: 'WAN',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://gwan-ssl.wandevs.org:56891',
    'https://gwan2-ssl.wandevs.org',
  ],
  blockExplorer: const BlockExplorer(
    name: 'WanScan',
    url: 'https://wanscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcDF6A1566e78EB4594c86Fe73Fcdc82429e97fbB',
      blockCreated: 25312390,
    ),
  },
);

/// Wanchain Testnet (chain id 999).
final Chain wanchainTestnet = Chain(
  id: 999,
  name: 'Wanchain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'WANCHAIN',
    symbol: 'WANt',
    decimals: 18,
  ),
  rpcUrls: const ['https://gwan-ssl.wandevs.org:46891'],
  blockExplorer: const BlockExplorer(
    name: 'WanScanTest',
    url: 'https://wanscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x11c89bF4496c39FB80535Ffb4c92715839CC5324',
      blockCreated: 24743448,
    ),
  },
);

/// WeaveVM Alphanet (chain id 9496).
final Chain weaveVMAlphanet = Chain(
  id: 9496,
  name: 'WeaveVM Alphanet',
  nativeCurrency: const NativeCurrency(
    name: 'Testnet WeaveVM',
    symbol: 'tWVM',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.wvm.dev'],
  blockExplorer: const BlockExplorer(
    name: 'WeaveVM Alphanet Explorer',
    url: 'https://explorer.wvm.dev',
  ),
);

/// WEMIX (chain id 1111).
final Chain wemix = Chain(
  id: 1111,
  name: 'WEMIX',
  nativeCurrency: const NativeCurrency(
    name: 'WEMIX',
    symbol: 'WEMIX',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.wemix.com'],
  blockExplorer: const BlockExplorer(
    name: 'wemixExplorer',
    url: 'https://explorer.wemix.com',
  ),
);

/// WEMIX Testnet (chain id 1112).
final Chain wemixTestnet = Chain(
  id: 1112,
  name: 'WEMIX Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'WEMIX',
    symbol: 'tWEMIX',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.test.wemix.com'],
  blockExplorer: const BlockExplorer(
    name: 'wemixExplorer',
    url: 'https://testnet.wemixscan.com',
  ),
);

/// Westend Asset Hub (chain id 420420421).
final Chain westendAssetHub = Chain(
  id: 420420421,
  name: 'Westend Asset Hub',
  nativeCurrency: const NativeCurrency(
    name: 'Westies',
    symbol: 'WND',
    decimals: 18,
  ),
  rpcUrls: const ['https://westend-asset-hub-eth-rpc.polkadot.io'],
  blockExplorer: const BlockExplorer(
    name: 'subscan',
    url: 'https://westend-asset-hub-eth-explorer.parity.io',
  ),
);

/// Whitechain (chain id 1875).
final Chain whitechain = Chain(
  id: 1875,
  name: 'Whitechain',
  nativeCurrency: const NativeCurrency(
    name: 'WhiteBIT Coin',
    symbol: 'WBT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.whitechain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Whitechain Explorer',
    url: 'https://explorer.whitechain.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 25212237,
    ),
  },
);

/// Whitechain Sepolia (chain id 1874).
final Chain whitechainSepolia = Chain(
  id: 1874,
  name: 'Whitechain Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'WBT',
    symbol: 'WBT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.whitechain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Whitechain Testnet Explorer',
    url: 'https://explorer.testnet.whitechain.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Whitechain Testnet (chain id 2625).
final Chain whitechainTestnet = Chain(
  id: 2625,
  name: 'Whitechain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'WhiteBIT Coin',
    symbol: 'WBT',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet.whitechain.io'],
  blockExplorer: const BlockExplorer(
    name: 'Whitechain Explorer',
    url: 'https://testnet.whitechain.io',
  ),
);

/// WMC Testnet (chain id 42070).
final Chain wmcTestnet = Chain(
  id: 42070,
  name: 'WMC Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'WMTx',
    symbol: 'WMTx',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc-testnet-base.worldmobile.net'],
  blockExplorer: const BlockExplorer(
    name: 'WMC Explorer',
    url: 'https://explorer2-base-testnet.worldmobile.net',
  ),
);

/// WorldLand Mainnet (chain id 103).
final Chain worldLand = Chain(
  id: 103,
  name: 'WorldLand Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'WLC',
    symbol: 'WLC',
    decimals: 18,
  ),
  rpcUrls: const ['https://seoul.worldland.foundation'],
  blockExplorer: const BlockExplorer(
    name: 'WorldLand Scan',
    url: 'https://scan.worldland.foundation',
  ),
);

/// World Chain (chain id 480).
final Chain worldchain = Chain(
  id: 480,
  name: 'World Chain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://worldchain-mainnet.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Worldscan',
    url: 'https://worldscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// World Chain Sepolia (chain id 4801).
final Chain worldchainSepolia = Chain(
  id: 4801,
  name: 'World Chain Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://worldchain-sepolia.g.alchemy.com/public'],
  blockExplorer: const BlockExplorer(
    name: 'Worldscan Sepolia',
    url: 'https://sepolia.worldscan.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 0,
    ),
  },
);

/// X Layer Mainnet (chain id 196).
final Chain xLayer = Chain(
  id: 196,
  name: 'X Layer Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'OKB',
    symbol: 'OKB',
    decimals: 18,
  ),
  rpcUrls: const ['https://xlayerrpc.okx.com'],
  blockExplorer: const BlockExplorer(
    name: 'OKLink',
    url: 'https://www.oklink.com/xlayer',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 47416,
    ),
  },
);

/// X1 Testnet (chain id 1952).
final Chain xLayerTestnet = Chain(
  id: 1952,
  name: 'X1 Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'OKB',
    symbol: 'OKB',
    decimals: 18,
  ),
  rpcUrls: const ['https://xlayertestrpc.okx.com'],
  blockExplorer: const BlockExplorer(
    name: 'OKLink',
    url: 'https://www.oklink.com/xlayer-test',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 624344,
    ),
  },
);

/// Xai Mainnet (chain id 660279).
final Chain xai = Chain(
  id: 660279,
  name: 'Xai Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Xai',
    symbol: 'XAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://xai-chain.net/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://explorer.xai-chain.net',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 222549,
    ),
  },
);

/// Xai Testnet (chain id 37714555429).
final Chain xaiTestnet = Chain(
  id: 37714555429,
  name: 'Xai Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'sXai',
    symbol: 'sXAI',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-v2.xai-chain.net/rpc'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://testnet-explorer-v2.xai-chain.net',
  ),
);

/// XDC Network (chain id 50).
final Chain xdc = Chain(
  id: 50,
  name: 'XDC Network',
  nativeCurrency: const NativeCurrency(
    name: 'XDC',
    symbol: 'XDC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.xdcrpc.com'],
  blockExplorer: const BlockExplorer(
    name: 'XDCScan',
    url: 'https://xdcscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x0B1795ccA8E4eC4df02346a082df54D437F8D9aF',
      blockCreated: 75884020,
    ),
  },
);

/// Apothem Network (chain id 51).
final Chain xdcTestnet = Chain(
  id: 51,
  name: 'Apothem Network',
  nativeCurrency: const NativeCurrency(
    name: 'TXDC',
    symbol: 'TXDC',
    decimals: 18,
  ),
  rpcUrls: const ['https://erpc.apothem.network'],
  blockExplorer: const BlockExplorer(
    name: 'XDCScan',
    url: 'https://testnet.xdcscan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 59765389,
    ),
  },
);

/// XGR Mainnet (chain id 1643).
final Chain xgr = Chain(
  id: 1643,
  name: 'XGR Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'XGR',
    symbol: 'XGR',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.xgr.network'],
  blockExplorer: const BlockExplorer(
    name: 'XGR Explorer',
    url: 'https://explorer.xgr.network',
  ),
);

/// Xone Chain Mainnet (chain id 3721).
final Chain xoneMainnet = Chain(
  id: 3721,
  name: 'Xone Chain Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'XOC',
    symbol: 'XOC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.xone.org'],
  blockExplorer: const BlockExplorer(
    name: 'Xone Mainnet Explorer',
    url: 'https://xonescan.com',
  ),
);

/// Xone Chain Testnet (chain id 33772211).
final Chain xoneTestnet = Chain(
  id: 33772211,
  name: 'Xone Chain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'XOC',
    symbol: 'XOC',
    decimals: 18,
  ),
  rpcUrls: const [
    'https://rpc-testnet.xone.org',
    'https://rpc-testnet.xone.plus',
    'https://rpc-testnet.knight.center',
  ],
  blockExplorer: const BlockExplorer(
    name: 'Xone Testnet Explorer',
    url: 'https://testnet.xonescan.com',
  ),
);

/// Xphere Mainnet (chain id 20250217).
final Chain xphereMainnet = Chain(
  id: 20250217,
  name: 'Xphere Mainnet',
  nativeCurrency: const NativeCurrency(name: 'XP', symbol: 'XP', decimals: 18),
  rpcUrls: const ['https://en-bkk.x-phere.com'],
  blockExplorer: const BlockExplorer(
    name: 'Xphere Tamsa Explorer',
    url: 'https://xp.tamsa.io',
  ),
);

/// Xphere Testnet (chain id 1998991).
final Chain xphereTestnet = Chain(
  id: 1998991,
  name: 'Xphere Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'XPT',
    symbol: 'XPT',
    decimals: 18,
  ),
  rpcUrls: const ['http://testnet.x-phere.com'],
  blockExplorer: const BlockExplorer(
    name: 'Xphere Tamsa Explorer',
    url: 'https://xpt.tamsa.io',
  ),
);

/// CONX Chain (chain id 37).
final Chain xpla = Chain(
  id: 37,
  name: 'CONX Chain',
  nativeCurrency: const NativeCurrency(
    name: 'XPLA',
    symbol: 'XPLA',
    decimals: 18,
  ),
  rpcUrls: const ['https://dimension-evm-rpc.xpla.dev'],
  blockExplorer: const BlockExplorer(
    name: 'CONX Explorer',
    url: 'https://explorer.conx.xyz',
  ),
);

/// XR One (chain id 273).
final Chain xrOne = Chain(
  id: 273,
  name: 'XR One',
  nativeCurrency: const NativeCurrency(
    name: 'XR1',
    symbol: 'XR1',
    decimals: 18,
  ),
  rpcUrls: const ['https://xr1.calderachain.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://xr1.calderaexplorer.xyz',
  ),
);

/// XR Sepolia (chain id 2730).
final Chain xrSepolia = Chain(
  id: 2730,
  name: 'XR Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'tXR',
    symbol: 'tXR',
    decimals: 18,
  ),
  rpcUrls: const ['https://xr-sepolia-testnet.rpc.caldera.xyz/http'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'https://xr-sepolia-testnet.explorer.caldera.xyz',
  ),
);

/// XRPL EVM (chain id 1440000).
final Chain xrplevm = Chain(
  id: 1440000,
  name: 'XRPL EVM',
  nativeCurrency: const NativeCurrency(
    name: 'XRP',
    symbol: 'XRP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.xrplevm.org'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.xrplevm.org',
  ),
);

/// XRPL EVM Devnet (chain id 1440002).
final Chain xrplevmDevnet = Chain(
  id: 1440002,
  name: 'XRPL EVM Devnet',
  nativeCurrency: const NativeCurrency(
    name: 'XRP',
    symbol: 'XRP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.xrplevm.org/'],
  blockExplorer: const BlockExplorer(
    name: 'XRPLEVM Devnet Explorer',
    url: 'https://explorer.xrplevm.org/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x82Cc144D7d0AD4B1c27cb41420e82b82Ad6e9B31',
      blockCreated: 15237286,
    ),
  },
);

/// XRPL EVM Testnet (chain id 1449000).
final Chain xrplevmTestnet = Chain(
  id: 1449000,
  name: 'XRPL EVM Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'XRP',
    symbol: 'XRP',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.xrplevm.org'],
  blockExplorer: const BlockExplorer(
    name: 'blockscout',
    url: 'https://explorer.testnet.xrplevm.org',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0x82Cc144D7d0AD4B1c27cb41420e82b82Ad6e9B31',
      blockCreated: 492302,
    ),
  },
);

/// Yooldo Verse (chain id 50005).
final Chain yooldoVerse = Chain(
  id: 50005,
  name: 'Yooldo Verse',
  nativeCurrency: const NativeCurrency(
    name: 'OAS',
    symbol: 'OAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.yooldo-verse.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Yooldo Verse Explorer',
    url: 'https://explorer.yooldo-verse.xyz',
  ),
);

/// Yooldo Verse Testnet (chain id 50006).
final Chain yooldoVerseTestnet = Chain(
  id: 50006,
  name: 'Yooldo Verse Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'OAS',
    symbol: 'OAS',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.testnet.yooldo-verse.xyz'],
  blockExplorer: const BlockExplorer(
    name: 'Yooldo Verse Testnet Explorer',
    url: 'https://explorer.testnet.yooldo-verse.xyz',
  ),
);

/// ZenChain Testnet (chain id 8408).
final Chain zenchainTestnet = Chain(
  id: 8408,
  name: 'ZenChain Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ZTC',
    symbol: 'ZTC',
    decimals: 18,
  ),
  rpcUrls: const ['https://zenchain-testnet.api.onfinality.io/public'],
  blockExplorer: const BlockExplorer(
    name: 'Zentrace',
    url: 'https://zentrace.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 230019,
    ),
  },
);

/// Zeniq Mainnet (chain id 383414847825).
final Chain zeniq = Chain(
  id: 383414847825,
  name: 'Zeniq Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'ZENIQ',
    symbol: 'ZENIQ',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.zeniq.network'],
  blockExplorer: const BlockExplorer(
    name: 'Zeniq Explorer',
    url: 'https://zeniqscan.com',
  ),
);

/// 0G Newton Testnet (chain id 16600).
final Chain zeroG = Chain(
  id: 16600,
  name: '0G Newton Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'A0GI',
    symbol: 'A0GI',
    decimals: 18,
  ),
  rpcUrls: const ['https://evmrpc-testnet.0g.ai'],
  blockExplorer: const BlockExplorer(
    name: '0G BlockChain Explorer',
    url: 'https://chainscan-newton.0g.ai',
  ),
);

/// 0G Galileo Testnet (chain id 16601).
final Chain zeroGGalileoTestnet = Chain(
  id: 16601,
  name: '0G Galileo Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'A0GI',
    symbol: 'A0GI',
    decimals: 18,
  ),
  rpcUrls: const ['https://evmrpc-testnet.0g.ai'],
  blockExplorer: const BlockExplorer(
    name: '0G BlockChain Explorer',
    url: 'https://chainscan-galileo.0g.ai',
  ),
);

/// 0G Mainnet (chain id 16661).
final Chain zeroGMainnet = Chain(
  id: 16661,
  name: '0G Mainnet',
  nativeCurrency: const NativeCurrency(name: '0G', symbol: '0G', decimals: 18),
  rpcUrls: const ['https://evmrpc.0g.ai'],
  blockExplorer: const BlockExplorer(
    name: '0G Chainscan',
    url: 'https://chainscan.0g.ai',
  ),
);

/// 0G Galileo Testnet (chain id 16602).
final Chain zeroGTestnet = Chain(
  id: 16602,
  name: '0G Galileo Testnet',
  nativeCurrency: const NativeCurrency(name: '0G', symbol: '0G', decimals: 18),
  rpcUrls: const ['https://evmrpc-testnet.0g.ai'],
  blockExplorer: const BlockExplorer(
    name: '0G Chainscan',
    url: 'https://chainscan-galileo.0g.ai',
  ),
);

/// Zero Network (chain id 543210).
final Chain zeroNetwork = Chain(
  id: 543210,
  name: 'Zero Network',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.zerion.io/v1/zero'],
  blockExplorer: const BlockExplorer(
    name: 'Zero Network Explorer',
    url: 'https://explorer.zero.network',
  ),
);

/// ZetaChain (chain id 7000).
final Chain zetachain = Chain(
  id: 7000,
  name: 'ZetaChain',
  nativeCurrency: const NativeCurrency(
    name: 'Zeta',
    symbol: 'ZETA',
    decimals: 18,
  ),
  rpcUrls: const ['https://zetachain-evm.blockpi.network/v1/rpc/public'],
  blockExplorer: const BlockExplorer(
    name: 'ZetaScan',
    url: 'https://zetascan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 1632781,
    ),
  },
);

/// ZetaChain Athens Testnet (chain id 7001).
final Chain zetachainAthensTestnet = Chain(
  id: 7001,
  name: 'ZetaChain Athens Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Zeta',
    symbol: 'aZETA',
    decimals: 18,
  ),
  rpcUrls: const ['https://zetachain-athens-evm.blockpi.network/v1/rpc/public'],
  blockExplorer: const BlockExplorer(
    name: 'ZetaScan',
    url: 'https://testnet.zetascan.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 2715217,
    ),
  },
);

/// Zhejiang (chain id 1337803).
final Chain zhejiang = Chain(
  id: 1337803,
  name: 'Zhejiang',
  nativeCurrency: const NativeCurrency(
    name: 'Zhejiang Ether',
    symbol: 'ZhejETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.zhejiang.ethpandaops.io'],
  blockExplorer: const BlockExplorer(
    name: 'Beaconchain',
    url: 'https://zhejiang.beaconcha.in',
  ),
);

/// Zilliqa (chain id 32769).
final Chain zilliqa = Chain(
  id: 32769,
  name: 'Zilliqa',
  nativeCurrency: const NativeCurrency(
    name: 'Zilliqa',
    symbol: 'ZIL',
    decimals: 18,
  ),
  rpcUrls: const ['https://api.zilliqa.com'],
  blockExplorer: const BlockExplorer(
    name: 'Ethernal',
    url: 'https://evmx.zilliqa.com',
  ),
);

/// Zilliqa Testnet (chain id 33101).
final Chain zilliqaTestnet = Chain(
  id: 33101,
  name: 'Zilliqa Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Zilliqa',
    symbol: 'ZIL',
    decimals: 18,
  ),
  rpcUrls: const ['https://dev-api.zilliqa.com'],
  blockExplorer: const BlockExplorer(
    name: 'Ethernal',
    url: 'https://evmx.testnet.zilliqa.com',
  ),
);

/// Zircuit Mainnet (chain id 48900).
final Chain zircuit = Chain(
  id: 48900,
  name: 'Zircuit Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.zircuit.com'],
  blockExplorer: const BlockExplorer(
    name: 'Zircuit Explorer',
    url: 'https://explorer.zircuit.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// Zircuit Garfield Testnet (chain id 48898).
final Chain zircuitGarfieldTestnet = Chain(
  id: 48898,
  name: 'Zircuit Garfield Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://garfield-testnet.zircuit.com/'],
  blockExplorer: const BlockExplorer(
    name: 'Zircuit Garfield Testnet Explorer',
    url: 'https://explorer.garfield-testnet.zircuit.com',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
    ),
  },
);

/// ZKFair Mainnet (chain id 42766).
final Chain zkFair = Chain(
  id: 42766,
  name: 'ZKFair Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'USD Coin',
    symbol: 'USDC',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.zkfair.io'],
  blockExplorer: const BlockExplorer(
    name: 'zkFair Explorer',
    url: 'https://scan.zkfair.io',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xca11bde05977b3631167028862be2a173976ca11',
      blockCreated: 6090959,
    ),
  },
);

/// ZKFair Testnet (chain id 43851).
final Chain zkFairTestnet = Chain(
  id: 43851,
  name: 'ZKFair Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'USD Coin',
    symbol: 'USDC',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.zkfair.io'],
  blockExplorer: const BlockExplorer(
    name: 'zkFair Explorer',
    url: 'https://testnet-scan.zkfair.io',
  ),
);

/// zkLink Nova (chain id 810180).
final Chain zkLinkNova = Chain(
  id: 810180,
  name: 'zkLink Nova',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.zklink.io'],
  blockExplorer: const BlockExplorer(
    name: 'zkLink Nova Block Explorer',
    url: 'https://explorer.zklink.io',
  ),
);

/// zkLink Nova Sepolia Testnet (chain id 810181).
final Chain zkLinkNovaSepoliaTestnet = Chain(
  id: 810181,
  name: 'zkLink Nova Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'ETH',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.rpc.zklink.io'],
  blockExplorer: const BlockExplorer(
    name: 'zkLink Nova Block Explorer',
    url: 'https://sepolia.explorer.zklink.io',
  ),
);

/// zkXPLA Mainnet (chain id 375).
final Chain zkXPLA = Chain(
  id: 375,
  name: 'zkXPLA Mainnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.zkxpla.io'],
  blockExplorer: const BlockExplorer(
    name: 'zkXPLA Mainnet Explorer',
    url: 'https://explorer.zkxpla.io',
  ),
);

/// zkXPLA Testnet (chain id 475).
final Chain zkXPLATestnet = Chain(
  id: 475,
  name: 'zkXPLA Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet-rpc.zkxpla.io'],
  blockExplorer: const BlockExplorer(
    name: 'zkXPLA Testnet Explorer',
    url: 'https://testnet-explorer.zkxpla.io',
  ),
);

/// ZKsync Era (chain id 324).
final Chain zksync = Chain(
  id: 324,
  name: 'ZKsync Era',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://mainnet.era.zksync.io'],
  blockExplorer: const BlockExplorer(
    name: 'ZKsync Explorer',
    url: 'https://explorer.zksync.io/',
  ),
  contracts: const {
    'erc6492Verifier': ChainContract(
      address: '0xfB688330379976DA81eB64Fe4BF50d7401763B9C',
      blockCreated: 45659388,
    ),
    'multicall3': ChainContract(
      address: '0xF9cda624FBC7e059355ce98a31693d299FACd963',
      blockCreated: 3908235,
    ),
  },
);

/// ZKsync InMemory Node (chain id 260).
final Chain zksyncInMemoryNode = Chain(
  id: 260,
  name: 'ZKsync InMemory Node',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://localhost:8011'],
);

/// ZKsync CLI Local Custom Hyperchain (chain id 272).
final Chain zksyncLocalCustomHyperchain = Chain(
  id: 272,
  name: 'ZKsync CLI Local Custom Hyperchain',
  nativeCurrency: const NativeCurrency(
    name: 'BAT',
    symbol: 'BAT',
    decimals: 18,
  ),
  rpcUrls: const ['http://localhost:15200'],
  blockExplorer: const BlockExplorer(
    name: 'ZKsync explorer',
    url: 'http://localhost:15005/',
  ),
);

/// ZKsync CLI Local Hyperchain (chain id 270).
final Chain zksyncLocalHyperchain = Chain(
  id: 270,
  name: 'ZKsync CLI Local Hyperchain',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://localhost:15100'],
  blockExplorer: const BlockExplorer(
    name: 'ZKsync explorer',
    url: 'http://localhost:15005/',
  ),
);

/// ZKsync CLI Local Hyperchain L1 (chain id 9).
final Chain zksyncLocalHyperchainL1 = Chain(
  id: 9,
  name: 'ZKsync CLI Local Hyperchain L1',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://localhost:15045'],
  blockExplorer: const BlockExplorer(
    name: 'Blockscout',
    url: 'http://localhost:15001/',
  ),
);

/// ZKsync CLI Local Node (chain id 270).
final Chain zksyncLocalNode = Chain(
  id: 270,
  name: 'ZKsync CLI Local Node',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['http://localhost:3050'],
);

/// ZKsync Sepolia Testnet (chain id 300).
final Chain zksyncSepoliaTestnet = Chain(
  id: 300,
  name: 'ZKsync Sepolia Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.era.zksync.dev'],
  blockExplorer: const BlockExplorer(
    name: 'ZKsync Explorer',
    url: 'https://sepolia.explorer.zksync.io/',
  ),
  contracts: const {
    'erc6492Verifier': ChainContract(
      address: '0xfB688330379976DA81eB64Fe4BF50d7401763B9C',
      blockCreated: 3855712,
    ),
    'multicall3': ChainContract(
      address: '0xF9cda624FBC7e059355ce98a31693d299FACd963',
    ),
  },
);

/// Zora (chain id 7777777).
final Chain zora = Chain(
  id: 7777777,
  name: 'Zora',
  nativeCurrency: const NativeCurrency(
    name: 'Ether',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://rpc.zora.energy'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://explorer.zora.energy',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 5882,
    ),
  },
);

/// Zora Sepolia (chain id 999999999).
final Chain zoraSepolia = Chain(
  id: 999999999,
  name: 'Zora Sepolia',
  nativeCurrency: const NativeCurrency(
    name: 'Zora Sepolia',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://sepolia.rpc.zora.energy'],
  blockExplorer: const BlockExplorer(
    name: 'Zora Sepolia Explorer',
    url: 'https://sepolia.explorer.zora.energy/',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 83160,
    ),
  },
);

/// Zora Goerli Testnet (chain id 999).
final Chain zoraTestnet = Chain(
  id: 999,
  name: 'Zora Goerli Testnet',
  nativeCurrency: const NativeCurrency(
    name: 'Zora Goerli',
    symbol: 'ETH',
    decimals: 18,
  ),
  rpcUrls: const ['https://testnet.rpc.zora.energy'],
  blockExplorer: const BlockExplorer(
    name: 'Explorer',
    url: 'https://testnet.explorer.zora.energy',
  ),
  contracts: const {
    'multicall3': ChainContract(
      address: '0xcA11bde05977b3631167028862bE2a173976CA11',
      blockCreated: 189123,
    ),
  },
);
