/// ENS resolution: `namehash`, `normalize`, Universal Resolver actions
/// (`getEnsAddress`, `getEnsName`, `getEnsAvatar`, `getEnsText`). Mirrors
/// viem's `viem/ens` subpath.
library;

export 'src/ens/avatar_uri.dart';
export 'src/ens/dns_encode.dart';
export 'src/ens/ens_actions.dart';
export 'src/ens/namehash.dart';
export 'src/ens/normalize.dart';
export 'src/ens/universal_resolver.dart';
export 'src/ens/vendor/ens_normalize/ens_normalize_base.dart'
    show DisallowedSequence;
export 'src/errors/ens_error.dart';
