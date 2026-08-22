import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';

/// Single responsibility UseCase to register a new user.
class SignupUseCase {
  final AuthRepository _repository;

  const SignupUseCase(this._repository);

  Future<Result<UserEntity>> execute(String email, String password) {
    return _repository.signup(email, password);
  }
}
