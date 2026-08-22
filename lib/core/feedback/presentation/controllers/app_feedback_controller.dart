import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/domain/entities/app_notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_feedback_controller.g.dart';

@Riverpod(keepAlive: true)
class AppFeedbackController extends _$AppFeedbackController {
  @override
  List<AppNotification> build() {
    return const [];
  }

  /// Appends a new notification to the active queue.
  void showNotification(AppNotification notification) {
    state = [...state, notification];
  }

  /// Removes a notification from the queue by its identifier.
  void removeNotification(String id) {
    state = [
      for (final item in state)
        if (item.id != id) item
    ];
  }

  /// Helper method that wraps a domain [Failure] inside an error notification and appends it to the queue.
  void showFailure(Failure failure) {
    final notification = AppNotification(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: AppNotificationType.error,
      failure: failure,
    );
    showNotification(notification);
  }
}
