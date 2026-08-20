import 'package:dio/dio.dart';
import 'package:flutter_material_enterprise_starter/core/network/dio_client.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_datasource.g.dart';

/// Remote data source handling authentication requests via REST API.
abstract interface class AuthRemoteDataSource {
  Future<UserDto> login(String email, String password);
  Future<UserDto> signup(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dio);
  // ignore: unused_field
  final Dio _dio;

  @override
  Future<UserDto> login(String email, String password) async {
    // In a real project, we make the actual network request:
    // final response = await _dio.post('/auth/login', data: {'email': email, 'password': password});
    // return UserDto.fromJson(response.data as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 800));
    if (email == 'error@example.com') {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/auth/login'),
          statusCode: 400,
          data: {'message': 'auth/invalid-credentials'},
        ),
      );
    }
    return UserDto(
      id: 'mock-user-123',
      email: email,
      token: 'mock-access-token-xyz',
      refreshToken: 'mock-refresh-token-abc',
    );
  }

  @override
  Future<UserDto> signup(String email, String password) async {
    // In a real project, we make the actual network request:
    // final response = await _dio.post('/auth/register', data: {'email': email, 'password': password});
    // return UserDto.fromJson(response.data as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 900));
    if (email == 'existing@example.com') {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/register'),
        response: Response(
          requestOptions: RequestOptions(path: '/auth/register'),
          statusCode: 400,
          data: {'message': 'auth/email-already-in-use'},
        ),
      );
    }
    return UserDto(
      id: 'mock-user-123',
      email: email,
      token: 'mock-access-token-xyz',
      refreshToken: 'mock-refresh-token-abc',
    );
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final dioClient = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dioClient);
}
