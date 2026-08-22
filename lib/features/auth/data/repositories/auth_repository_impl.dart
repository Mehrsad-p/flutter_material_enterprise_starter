import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/mapper/user_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<UserEntity>> login(String email, String password) {
    return safeApiCall(
      call: () async {
        final dto = await _remoteDataSource.login(email, password);
        await _localDataSource.saveSession(
          accessToken: dto.accessToken,
          refreshToken: dto.refreshToken,
          userId: dto.id,
          userEmail: dto.email,
        );
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<UserEntity>> signup(String email, String password) {
    return safeApiCall(
      call: () async {
        final dto = await _remoteDataSource.signup(email, password);
        await _localDataSource.saveSession(
          accessToken: dto.accessToken,
          refreshToken: dto.refreshToken,
          userId: dto.id,
          userEmail: dto.email,
        );
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<void>> refreshToken() async {
    final savedRefreshToken = await _localDataSource.getRefreshToken();
    if (savedRefreshToken == null) {
      return const Result.error(Failure.cache('No refresh token found'));
    }
    return safeApiCall(
      call: () async {
        final dto = await _remoteDataSource.refreshToken(savedRefreshToken);
        await _localDataSource.saveSession(
          accessToken: dto.accessToken,
          refreshToken: dto.refreshToken,
          userId: dto.id,
          userEmail: dto.email,
        );
      },
    );
  }

  @override
  Future<Result<UserEntity?>> restoreSession() {
    return safeApiCall(
      call: () async {
        final token = await _localDataSource.getAccessToken();
        if (token == null) return null;

        final id = await _localDataSource.getUserId();
        final email = await _localDataSource.getUserEmail();
        if (id != null && email != null) {
          return UserEntity(id: id, email: email);
        }
        return null;
      },
    );
  }

  @override
  Future<Result<void>> logout() {
    return safeApiCall(
      call: () => _localDataSource.clearSession(),
    );
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource, localDataSource);
}
