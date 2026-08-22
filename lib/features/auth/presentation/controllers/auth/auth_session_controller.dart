import 'dart:async';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/domain.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/providers/auth_usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthSessionController extends _$AuthSessionController {
  @override
  Future<UserEntity?> build() async {
    final useCase = ref.watch(restoreSessionUseCaseProvider);
    final result = await useCase.execute();
    return result.when(success: (user) => user, error: (_) => null);
  }

  /// Sets/updates the session state directly.
  void updateSession(UserEntity? user) {
    state = AsyncValue.data(user);
  }

  /// Logs out the user and clears secure keys.
  Future<void> logout() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(logoutUseCaseProvider);
    final result = await useCase.execute();

    state = result.when(
      success: (_) => const AsyncValue.data(null),
      error: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }
}
