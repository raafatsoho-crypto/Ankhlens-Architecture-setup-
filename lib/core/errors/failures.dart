/// Domain-level failure hierarchy. Pure Dart — no Flutter, no package imports.
/// UseCases return `Either<Failure, T>`-style results (via the Result type
/// below) so Presentation never has to catch raw exceptions.
sealed class Failure {
  final String message;
  final Object? cause;

  const Failure(this.message, {this.cause});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.cause});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.cause});
}

class InferenceFailure extends Failure {
  const InferenceFailure(super.message, {super.cause});
}

class ConfigFailure extends Failure {
  const ConfigFailure(super.message, {super.cause});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.cause});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.cause});
}
