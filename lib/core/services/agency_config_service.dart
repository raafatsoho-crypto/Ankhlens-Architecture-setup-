import 'package:ankh_lens/core/errors/exceptions.dart';

/// Placeholder domain-facing contract for agency config access.
/// Full implementation (JSON parse, encrypted cache, remote sync)
/// lands in Step 2 alongside the `agency` feature. Declared here
/// because `bootstrap.dart` needs to depend on *something* to gate
/// the "agency config loaded" route guard from day one.
abstract interface class AgencyConfigService {
  Future<void> loadCachedOrDefault();
  Future<void> syncIfOnline();
  bool get isLoaded;
}

class AgencyConfigServiceStub implements AgencyConfigService {
  bool _loaded = false;

  @override
  bool get isLoaded => _loaded;

  @override
  Future<void> loadCachedOrDefault() async {
    // Step 2 replaces this with real local-JSON + secure-storage load.
    _loaded = true;
  }

  @override
  Future<void> syncIfOnline() async {
    // Step 2 replaces this with AgencyConfigService (remote) integration.
  }
}
