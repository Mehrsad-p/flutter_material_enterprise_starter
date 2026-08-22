import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/domain/entities/app_notification.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/presentation/controllers/app_feedback_controller.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/presentation/delegates/feedback_delegate.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/presentation/delegates/material_feedback_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Reactive wrapper widget that observes global notifications and delegates UI rendering.
class GlobalFeedbackListener extends ConsumerWidget {
  final Widget child;
  final FeedbackDelegate delegate;

  const GlobalFeedbackListener({
    super.key,
    required this.child,
    this.delegate = const MaterialFeedbackDelegate(),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<List<AppNotification>>(
      appFeedbackControllerProvider,
      (previous, next) {
        if (next.isNotEmpty) {
          final itemsToProcess = List<AppNotification>.from(next);
          for (final notification in itemsToProcess) {
            delegate.showNotification(context, notification);
            ref
                .read(appFeedbackControllerProvider.notifier)
                .removeNotification(notification.id);
          }
        }
      },
    );

    return child;
  }
}
