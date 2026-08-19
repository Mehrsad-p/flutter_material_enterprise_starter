import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.error(Failure failure) = ErrorResult<T>;
}

/// A global helper to safely perform asynchronous API/Repository operations and map errors to a [Result].
///
/// If an error is thrown, it defaults to a [ServerFailure] (via Failure.fromException) unless a custom [errorMapper] is provided.
Future<Result<T>> safeApiCall<T>({
  required Future<T> Function() call,
  Failure Function(dynamic error)? errorMapper,
}) async {
  try {
    final response = await call();
    return Result.success(response);
  } catch (e) {
    if (errorMapper != null) {
      return Result.error(errorMapper(e));
    }
    return Result.error(Failure.fromException(e));
  }
}
