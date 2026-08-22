import 'dart:async';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth/auth_session_controller.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/providers/auth_usecases_provider.dart';
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

    state = await AsyncValue.guard(() async {
      final user = result.when(
        success: (user) => user,
        error: (failure) => throw failure,
      );
      ref.read(authSessionControllerProvider.notifier).updateSession(user);
    });
  }
}
