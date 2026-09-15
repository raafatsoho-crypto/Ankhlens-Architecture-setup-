import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// MaterialApp shell. Theme is a static default here in Step 1 —
/// Step 2 replaces `theme:` with a Consumer that rebuilds ThemeData
/// from AgencyTheme via core/theme/theme_builder.dart. Router wiring
/// (go_router) lands in Step 8; using a placeholder Scaffold for now
/// so this compiles and runs standalone.
class AnkhLensApp extends ConsumerWidget {
  const AnkhLensApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'AnkhLens',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('it'),
        Locale('ru'),
        Locale('ar'),
      ],
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: const _BootstrapPlaceholderHome(),
    );
  }
}

class _BootstrapPlaceholderHome extends StatelessWidget {
  const _BootstrapPlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('AnkhLens — core scaffold ready (router lands Step 8)'),
      ),
    );
  }
}
