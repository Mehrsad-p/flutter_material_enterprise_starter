import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/states/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return const AuthLocalDataSourceImpl();
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

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
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(email, password);

    switch (result) {
      case Success(data: final user):
        state = AuthState.success(user);
      case FailureResult(failure: final failure):
        state = AuthState.error(failure.message);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AuthState.loading();

    final useCase = ref.read(signUpUseCaseProvider);
    final result = await useCase.execute(email, password);

    switch (result) {
      case Success(data: final user):
        state = AuthState.success(user);
      case FailureResult(failure: final failure):
        state = AuthState.error(failure.message);
    }
  }
}
