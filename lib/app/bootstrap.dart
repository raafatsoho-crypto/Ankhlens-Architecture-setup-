import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ankh_lens/core/services/connectivity_service.dart';
import 'package:ankh_lens/core/services/local_database.dart';
import 'package:ankh_lens/core/services/agency_config_service.dart';

/// The ONLY place in the app allowed to do first-run I/O: opens the
/// Drift DB, loads AgencyConfig, and builds the Riverpod override
/// container. Nothing else — no widget, no controller — should touch
/// DB-open or config-load directly.
class BootstrapResult {
  final ProviderContainer container;
  const BootstrapResult(this.container);
}

Future<BootstrapResult> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await LocalDatabase.open();
  final connectivity = ConnectivityServiceImpl();
  final agencyConfig = AgencyConfigServiceStub();

  await agencyConfig.loadCachedOrDefault();
  // Non-blocking: per system architecture, sync is optional and must
  // never block app-ready.
  unawaited(agencyConfig.syncIfOnline());

  final container = ProviderContainer(
    overrides: [
      localDatabaseProvider.overrideWithValue(db),
      connectivityServiceProvider.overrideWithValue(connectivity),
      agencyConfigServiceProvider.overrideWithValue(agencyConfig),
    ],
  );

  return BootstrapResult(container);
}

// --- Root providers (overridden above, consumed via core/ everywhere) ---

final localDatabaseProvider = Provider<LocalDatabase>(
  (ref) => throw UnimplementedError('Overridden in bootstrap()'),
);

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => throw UnimplementedError('Overridden in bootstrap()'),
);

final agencyConfigServiceProvider = Provider<AgencyConfigService>(
  (ref) => throw UnimplementedError('Overridden in bootstrap()'),
);

void unawaited(Future<void> future) {}
