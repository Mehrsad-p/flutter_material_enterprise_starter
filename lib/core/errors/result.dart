import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';

sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(Failure failure) = FailureResult<T>;
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}

/// A global helper to safely perform asynchronous operations and map errors to a [Result].
///
/// If an error is thrown, it defaults to a [ServerFailure] unless a custom [errorMapper] is provided.
Future<Result<T>> safeCall<T>({
  required Future<T> Function() call,
  Failure Function(dynamic error)? errorMapper,
}) async {
  try {
    final response = await call();
    return Result.success(response);
  } catch (e) {
    if (errorMapper != null) {
      return Result.failure(errorMapper(e));
    }
    return Result.failure(ServerFailure(e.toString()));
  }
}
