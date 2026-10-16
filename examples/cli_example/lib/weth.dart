/// A `viem_dart_builders`-generated typed contract for WETH9's read
/// surface — demoing contract code generation
/// alongside this example's other, runtime-ABI demos. See
/// `bin/cli_example.dart`'s `_demoGeneratedContract`.
library;

import 'package:viem_dart/abi.dart';
import 'package:viem_dart/codegen.dart';
import 'package:viem_dart/viem_dart.dart';

@GenerateAbi('lib/abi/weth.json', className: 'Weth')
part 'weth.g.dart';
