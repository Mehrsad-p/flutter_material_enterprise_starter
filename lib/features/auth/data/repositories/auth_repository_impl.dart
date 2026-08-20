import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/mapper/user_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

/// Repository implementation managing remote I/O and local secure token caching.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Result<User>> login(String email, String password) {
    return safeApiCall(
      call: () async {
        final dto = await _remoteDataSource.login(email, password);
        await _localDataSource.saveSession(
          accessToken: dto.token,
          refreshToken: dto.refreshToken ?? '',
          userId: dto.id,
          email: dto.email,
        );
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<User>> signup(String email, String password) {
    return safeApiCall(
      call: () async {
        final dto = await _remoteDataSource.signup(email, password);
        await _localDataSource.saveSession(
          accessToken: dto.token,
          refreshToken: dto.refreshToken ?? '',
          userId: dto.id,
          email: dto.email,
        );
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<User?>> restoreSession() {
    return safeApiCall(
      call: () async {
        final token = await _localDataSource.getAccessToken();
        if (token != null && token.isNotEmpty) {
          final id = await _localDataSource.getUserId();
          final email = await _localDataSource.getEmail();
          if (id != null && email != null) {
            return User(id: id, email: email);
          }
        }
        return null;
      },
    );
  }

  @override
  Future<Result<void>> logout() {
    return safeApiCall(
      call: () async {
        await _localDataSource.clearSession();
      },
    );
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remote, local);
}
