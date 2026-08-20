import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';

/// UseCase to verify and restore an existing active user session.
class RestoreSessionUseCase {
  final AuthRepository _repository;

  const RestoreSessionUseCase(this._repository);

  Future<Result<User?>> execute() async {
    return _repository.restoreSession();
  }
}
