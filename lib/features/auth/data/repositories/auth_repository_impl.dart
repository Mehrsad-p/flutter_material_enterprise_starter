import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/mapper/auth_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Result<User>> login(String email, String password) async {
    try {
      final json = await _localDataSource.loginMock(email, password);
      final dto = UserDto.fromJson(json);
      return Result.success(dto.toEntity());
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<User>> signUp(String email, String password) async {
    try {
      final json = await _localDataSource.signUpMock(email, password);
      final dto = UserDto.fromJson(json);
      return Result.success(dto.toEntity());
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
