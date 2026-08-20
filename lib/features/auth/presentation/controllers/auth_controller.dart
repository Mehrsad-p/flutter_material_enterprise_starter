import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/data.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/domain.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/states/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
}

@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(repository);
}

@riverpod
RestoreSessionUseCase restoreSessionUseCase(RestoreSessionUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RestoreSessionUseCase(repository);
}

@riverpod
LogoutUseCase logoutUseCase(LogoutUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    // Attempt session restoration immediately when the controller is initialized
    Future.microtask(() => restoreSession());
    return const AuthState.initial();
  }

  /// Attempts to restore the user session from secure storage.
  Future<void> restoreSession() async {
    state = const AuthState.loading();
    final useCase = ref.read(restoreSessionUseCaseProvider);
    final result = await useCase.execute();

    state = result.when(
      success: (user) {
        if (user != null) {
          return AuthState.authenticated(user);
        }
        return const AuthState.unauthenticated();
      },
      error: (_) => const AuthState.unauthenticated(),
    );
  }

  /// Logs in a user using credentials.
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(email, password);

    state = result.when(
      success: (user) => AuthState.authenticated(user),
      error: (failure) => AuthState.error(failure.message),
    );
  }

  /// Registers a new user and automatically logs them in upon success.
  Future<void> signup(String email, String password) async {
    state = const AuthState.loading();
    final useCase = ref.read(signUpUseCaseProvider);
    final result = await useCase.execute(email, password);

    state = result.when(
      success: (user) {
        // Post-Signup Flow: Log the user in automatically and transition state to authenticated.
        return AuthState.authenticated(user);
      },
      error: (failure) => AuthState.error(failure.message),
    );
  }

  /// Logs out the user and clears secure keys.
  Future<void> logout() async {
    state = const AuthState.loading();
    final useCase = ref.read(logoutUseCaseProvider);
    final result = await useCase.execute();

    state = result.when(
      success: (_) => const AuthState.unauthenticated(),
      error: (failure) => AuthState.error(failure.message),
    );
  }
}
