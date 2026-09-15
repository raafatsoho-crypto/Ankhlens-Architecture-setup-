import 'package:connectivity_plus/connectivity_plus.dart';

/// Thin wrapper around connectivity_plus so Data-layer repositories
/// depend on this abstraction, not the plugin directly — keeps the
/// plugin swappable and makes repositories mockable in tests.
abstract interface class ConnectivityService {
  Future<bool> get isOnline;
  Stream<bool> get onStatusChange;
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityServiceImpl({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  @override
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
