import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure_mapper.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/domain/entities/app_notification.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/presentation/delegates/feedback_delegate.dart';

/// Concrete Material 3 implementation of [FeedbackDelegate].
class MaterialFeedbackDelegate extends FeedbackDelegate {
  const MaterialFeedbackDelegate();

  String _resolveMessage(BuildContext context, AppNotification notification) {
    if (notification.failure != null) {
      return notification.failure!.toLocalizedMessage(context);
    }
    final rawMessage = notification.message ?? '';
    return rawMessage.tr();
  }

  @override
  void showNotification(BuildContext context, AppNotification notification) {
    // If error has an action or action label, render as an AlertDialog
    if (notification.type == AppNotificationType.error &&
        (notification.onAction != null || notification.actionLabel != null)) {
      showDialogFeedback(context, notification);
      return;
    }

    final message = _resolveMessage(context, notification);
    if (message.isEmpty) return;

    final theme = Theme.of(context);

    switch (notification.type) {
      case AppNotificationType.success:
        _showSnackBar(
          context: context,
          message: message,
          backgroundColor: theme.colorScheme.primaryContainer,
          textColor: theme.colorScheme.onPrimaryContainer,
          icon: Icons.check_circle_outline_rounded,
          notification: notification,
        );
        break;

      case AppNotificationType.info:
        _showSnackBar(
          context: context,
          message: message,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          textColor: theme.colorScheme.onSurfaceVariant,
          icon: Icons.info_outline_rounded,
          notification: notification,
        );
        break;

      case AppNotificationType.warning:
        _showSnackBar(
          context: context,
          message: message,
          backgroundColor: theme.colorScheme.tertiaryContainer,
          textColor: theme.colorScheme.onTertiaryContainer,
          icon: Icons.warning_amber_rounded,
          notification: notification,
        );
        break;

      case AppNotificationType.error:
        _showSnackBar(
          context: context,
          message: message,
          backgroundColor: theme.colorScheme.errorContainer,
          textColor: theme.colorScheme.onErrorContainer,
          icon: Icons.error_outline_rounded,
          notification: notification,
        );
        break;
    }
  }

  void _showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    required AppNotification notification,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        action: notification.actionLabel != null
            ? SnackBarAction(
                label: notification.actionLabel!.tr(),
                textColor: textColor,
                onPressed: () {
                  notification.onAction?.call();
                },
              )
            : null,
      ),
    );
  }

  @override
  void showDialogFeedback(BuildContext context, AppNotification notification) {
    final message = _resolveMessage(context, notification);
    final theme = Theme.of(context);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            notification.type == AppNotificationType.error
                ? Icons.error_rounded
                : Icons.info_rounded,
            color: notification.type == AppNotificationType.error
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
          ),
          title: Text(
            notification.type == AppNotificationType.error
                ? 'Error'
                : 'Notification',
          ),
          content: Text(message),
          actions: [
            if (notification.actionLabel != null)
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  notification.onAction?.call();
                },
                child: Text(notification.actionLabel!.tr()),
              ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
