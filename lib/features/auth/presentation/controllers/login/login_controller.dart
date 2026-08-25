import 'dart:async';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/feedback.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth/auth_session_controller.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/providers/auth_usecases_provider.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // Pure build method
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(email, password);

    // Automatically dispatch failure to global feedback queue if result is an error
    result.showFailureOnError(ref);

    if (result is Success) {
      final user = (result as Success).data;
      state = const AsyncValue.data(null);
      ref.read(authSessionControllerProvider.notifier).updateSession(user);
      ref.read(appFeedbackControllerProvider.notifier).showNotification(
            AppNotification(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              type: AppNotificationType.success,
              message: LocaleKeys.success_login,
            ),
          );
    } else if (result is ErrorResult) {
      state = AsyncValue.error(
        (result as ErrorResult).failure,
        StackTrace.current,
      );
    }
  }
}
