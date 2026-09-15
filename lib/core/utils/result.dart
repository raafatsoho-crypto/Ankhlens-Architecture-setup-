import 'package:ankh_lens/core/errors/failures.dart';

/// Lightweight Either-style result type so we don't need to pull in a
/// full functional programming package for this. Used as the return
/// type of every UseCase.
sealed class Result<T> {
  const Result();

  factory Result.ok(T value) = Ok<T>;
  factory Result.err(Failure failure) = Err<T>;

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  R when<R>({
    required R Function(T value) ok,
    required R Function(Failure failure) err,
  }) {
    final self = this;
    if (self is Ok<T>) return ok(self.value);
    if (self is Err<T>) return err(self.failure);
    throw StateError('Unreachable');
  }
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

final class Err<T> extends Result<T> {
  final Failure failure;
  const Err(this.failure);
}
