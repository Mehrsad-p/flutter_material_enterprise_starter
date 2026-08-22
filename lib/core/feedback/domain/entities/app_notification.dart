import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';

part 'app_notification.freezed.dart';

enum AppNotificationType { success, error, warning, info }

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required AppNotificationType type,
    String? message,
    Failure? failure,
    String? actionLabel,
    @JsonKey(includeFromJson: false, includeToJson: false)
    void Function()? onAction,
  }) = _AppNotification;
}
