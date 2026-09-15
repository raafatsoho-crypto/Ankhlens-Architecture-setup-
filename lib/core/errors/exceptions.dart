/// Data-layer exceptions. Thrown by Infrastructure/Data, caught at the
/// Repository implementation boundary, and translated into Failures
/// before crossing into Domain. Domain code never sees these types.
class DatabaseException implements Exception {
  final String message;
  final Object? cause;
  const DatabaseException(this.message, {this.cause});
}

class AssetLoadException implements Exception {
  final String message;
  final Object? cause;
  const AssetLoadException(this.message, {this.cause});
}

class InferenceException implements Exception {
  final String message;
  final Object? cause;
  const InferenceException(this.message, {this.cause});
}

class ConfigParseException implements Exception {
  final String message;
  final Object? cause;
  const ConfigParseException(this.message, {this.cause});
}

class RemoteSyncException implements Exception {
  final String message;
  final Object? cause;
  const RemoteSyncException(this.message, {this.cause});
}
