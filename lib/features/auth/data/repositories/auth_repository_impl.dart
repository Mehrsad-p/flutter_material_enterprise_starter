import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/mapper/auth_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Result<User>> login(String email, String password) {
    return safeApiCall(
      call: () async {
        final dto = await _localDataSource.loginMock(email, password);
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<User>> signUp(String email, String password) {
    return safeApiCall(
      call: () async {
        final dto = await _localDataSource.signUpMock(email, password);
        return dto.toEntity();
      },
    );
  }
}
