import 'package:flutter/widgets.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/domain/entities/app_notification.dart';

/// Abstract contract dictating how notifications and feedback dialogs are rendered in the UI.
abstract class FeedbackDelegate {
  const FeedbackDelegate();

  /// Displays a notification (e.g. SnackBar, Toast, or Banner) based on the notification type.
  void showNotification(BuildContext context, AppNotification notification);

  /// Displays a modal feedback dialog for critical notifications or actions.
  void showDialogFeedback(BuildContext context, AppNotification notification);
}
