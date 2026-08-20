import 'package:flutter_material_enterprise_starter/core/storage/token_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_datasource.g.dart';

/// Local data source managing secure session token storage.
abstract interface class AuthLocalDataSource {
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String email,
  });
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<String?> getUserId();
  Future<String?> getEmail();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._tokenStorage);
  final TokenStorage _tokenStorage;

  static const String _userIdKey = 'userId';
  static const String _emailKey = 'email';

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String email,
  }) async {
    await _tokenStorage.saveAccessToken(accessToken);
    await _tokenStorage.saveRefreshToken(refreshToken);
    await _tokenStorage.write(key: _userIdKey, value: userId);
    await _tokenStorage.write(key: _emailKey, value: email);
  }

  @override
  Future<String?> getAccessToken() => _tokenStorage.getAccessToken();

  @override
  Future<String?> getRefreshToken() => _tokenStorage.getRefreshToken();

  @override
  Future<String?> getUserId() => _tokenStorage.read(key: _userIdKey);

  @override
  Future<String?> getEmail() => _tokenStorage.read(key: _emailKey);

  @override
  Future<void> clearSession() => _tokenStorage.clearAll();
}

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  final storage = ref.watch(tokenStorageProvider);
  return AuthLocalDataSourceImpl(storage);
}
