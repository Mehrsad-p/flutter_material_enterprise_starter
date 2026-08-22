import 'package:flutter_material_enterprise_starter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_usecases_provider.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
}

@riverpod
SignupUseCase signupUseCase(SignupUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignupUseCase(repository);
}

@riverpod
RefreshTokenUseCase refreshTokenUseCase(RefreshTokenUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshTokenUseCase(repository);
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
