import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/balance_lookup.dart';

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return section([
      img(src: 'images/logo.svg', width: 80),
      h1([.text('viem_dart + Jaspr')]),
      p([.text('A pure-Dart Ethereum client, compiled to JS/Wasm.')]),
      div(styles: Styles(height: 100.px), []),
      const BalanceLookup(),
    ]);
  }
}
