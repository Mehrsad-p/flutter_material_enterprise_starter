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

/// Simulated mock data source for development and testing.
class MockAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const MockAuthRemoteDataSourceImpl();

  @override
  Future<UserDto> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return UserDto(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      email: email.isNotEmpty ? email : 'demo@enterprise.com',
      accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<UserDto> signup(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return UserDto(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      email: email.isNotEmpty ? email : 'demo@enterprise.com',
      accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<UserDto> refreshToken(String refreshToken) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return UserDto(
      id: 'usr_mock_session',
      email: 'demo@enterprise.com',
      accessToken: 'mock_refreshed_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: refreshToken,
    );
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  // Return MockAuthRemoteDataSourceImpl for seamless development testing
  return const MockAuthRemoteDataSourceImpl();
}
