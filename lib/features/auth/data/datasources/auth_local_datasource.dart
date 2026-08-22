import 'package:flutter_material_enterprise_starter/core/storage/token_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_datasource.g.dart';

abstract interface class AuthLocalDataSource {
  /// Saves the session tokens and user metadata.
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String userEmail,
  });

  /// Retrieves the active access token.
  Future<String?> getAccessToken();

  /// Retrieves the active refresh token.
  Future<String?> getRefreshToken();

  /// Retrieves the persisted user ID.
  Future<String?> getUserId();

  /// Retrieves the persisted user email.
  Future<String?> getUserEmail();

  /// Clears all session and token data from local storage.
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final TokenStorage _tokenStorage;
  const AuthLocalDataSourceImpl(this._tokenStorage);

  static const String _userIdKey = 'auth_user_id';
  static const String _userEmailKey = 'auth_user_email';

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String userEmail,
  }) async {
    await _tokenStorage.saveAccessToken(accessToken);
    await _tokenStorage.saveRefreshToken(refreshToken);
    await _tokenStorage.write(key: _userIdKey, value: userId);
    await _tokenStorage.write(key: _userEmailKey, value: userEmail);
  }

  @override
  Future<String?> getAccessToken() => _tokenStorage.getAccessToken();

  @override
  Future<String?> getRefreshToken() => _tokenStorage.getRefreshToken();

  @override
  Future<String?> getUserId() => _tokenStorage.read(key: _userIdKey);

  @override
  Future<String?> getUserEmail() => _tokenStorage.read(key: _userEmailKey);

  @override
  Future<void> clearSession() async {
    await _tokenStorage.deleteAccessToken();
    await _tokenStorage.deleteRefreshToken();
    await _tokenStorage.delete(key: _userIdKey);
    await _tokenStorage.delete(key: _userEmailKey);
  }
}

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthLocalDataSourceImpl(tokenStorage);
}
