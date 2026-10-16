import 'package:flutter/material.dart';

import 'balance_screen.dart';

void main() => runApp(const MyApp());

/// The app root: a Material app with two tabs, a welcome page and the
/// balance lookup.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'flutter_example',
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    home: const HomeShell(),
  );
}

/// Persistent chrome: an app bar and a bottom navigation bar switching
/// between the tabs.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('flutter_example')),
    body: IndexedStack(
      index: _index,
      children: const [WelcomeScreen(), BalanceScreen()],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Balance',
        ),
      ],
    ),
  );
}

/// Landing screen.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Welcome', style: textTheme.headlineLarge),
        const SizedBox(height: 12),
        Text(
          'A plain Flutter app demoing viem_dart. Open the Balance tab to '
          'read a live ETH balance.',
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
