import 'package:dio/dio.dart';
import 'package:flutter_material_enterprise_starter/core/network/dio_client.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_datasource.g.dart';

abstract interface class AuthRemoteDataSource {
  /// Authenticates user credentials via API.
  Future<UserDto> login(String email, String password);

  /// Registers user credentials via API.
  Future<UserDto> signup(String email, String password);

  /// Requests a token refresh using the stored refresh token.
  Future<UserDto> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  const AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<UserDto> login(String email, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserDto> signup(String email, String password) async {
    final response = await _dio.post(
      '/auth/register',
      data: {'email': email, 'password': password},
    );
    return UserDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserDto> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
      options: Options(extra: {'isRefresh': true}),
    );
    return UserDto.fromJson(response.data as Map<String, dynamic>);
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final dioClient = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dioClient);
}
