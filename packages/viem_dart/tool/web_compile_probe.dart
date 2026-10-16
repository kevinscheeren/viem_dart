// A CI-only build-verification probe (see .github/workflows/ci.yml's
// "Web/wasm compile smoke check" step) — importing every public subpath
// barrel here and compiling this file with `dart compile js`/`dart compile
// wasm` catches a stray unconditional `dart:io` (or other web-incompatible)
// import creeping into a shared code path, independent of the Flutter
// example that would catch it the expensive way.
//
// Not a real entrypoint: nothing here is meant to run, only to compile.
// ignore_for_file: unused_import
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/actions.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/codegen.dart';
import 'package:viem_dart/ens.dart';
import 'package:viem_dart/test_actions.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {}
