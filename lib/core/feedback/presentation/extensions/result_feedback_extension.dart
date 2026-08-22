import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/presentation/controllers/app_feedback_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ResultFeedbackExtension<T> on Result<T> {
  /// Dispatches the [Failure] to the global feedback queue if this result is an [ErrorResult].
  Result<T> showFailureOnError(Ref ref) {
    if (this is ErrorResult<T>) {
      final failure = (this as ErrorResult<T>).failure;
      ref.read(appFeedbackControllerProvider.notifier).showFailure(failure);
    }
    return this;
  }
}
