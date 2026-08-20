import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';

/// Single responsibility UseCase for user logout.
class LogoutUseCase {
  final AuthRepository _repository;

  const LogoutUseCase(this._repository);

  Future<Result<void>> execute() async {
    return _repository.logout();
  }
}
