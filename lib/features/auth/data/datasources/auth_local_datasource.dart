import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';

abstract interface class AuthLocalDataSource {
  Future<UserDto> loginMock(String email, String password);
  Future<UserDto> signUpMock(String email, String password);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl();

  @override
  Future<UserDto> loginMock(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final json = {
      'id': '101',
      'email': email,
      'token': 'mock_token_xyz_123',
    };
    return UserDto.fromJson(json);
  }

  @override
  Future<UserDto> signUpMock(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final json = {
      'id': '102',
      'email': email,
      'token': 'mock_token_abc_789',
    };
    return UserDto.fromJson(json);
  }
}
