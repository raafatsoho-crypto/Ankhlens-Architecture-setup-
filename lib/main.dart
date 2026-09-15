import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ankh_lens/app/app.dart';
import 'package:ankh_lens/app/bootstrap.dart';

Future<void> main() async {
  final result = await bootstrap();

  runApp(
    UncontrolledProviderScope(
      container: result.container,
      child: const AnkhLensApp(),
    ),
  );
}
