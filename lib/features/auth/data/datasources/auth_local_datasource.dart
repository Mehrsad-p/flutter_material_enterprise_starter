abstract interface class AuthLocalDataSource {
  Future<Map<String, dynamic>> loginMock(String email, String password);
  Future<Map<String, dynamic>> signUpMock(String email, String password);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl();

  @override
  Future<Map<String, dynamic>> loginMock(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'id': '101',
      'email': email,
      'token': 'mock_token_xyz_123',
    };
  }

  @override
  Future<Map<String, dynamic>> signUpMock(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'id': '102',
      'email': email,
      'token': 'mock_token_abc_789',
    };
  }
}
