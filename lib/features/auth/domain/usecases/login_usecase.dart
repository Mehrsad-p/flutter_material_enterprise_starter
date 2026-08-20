import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';

/// Single responsibility UseCase for user login.
class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Result<User>> execute(String email, String password) async {
    return _repository.login(email, password);
  }
}
