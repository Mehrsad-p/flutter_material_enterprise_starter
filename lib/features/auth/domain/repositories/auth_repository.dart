import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';

/// Abstract contract for authentication data operations.
abstract interface class AuthRepository {
  /// Authenticates a user using their email and password credentials.
  Future<Result<UserEntity>> login(String email, String password);

  /// Registers a new user using their email and password credentials.
  Future<Result<UserEntity>> signup(String email, String password);

  /// Renews the active user session tokens using the saved refresh token.
  Future<Result<void>> refreshToken();

  /// Restores the authenticated user session from local storage if available.
  Future<Result<UserEntity?>> restoreSession();

  /// Logs out the active user, clearing local tokens and ending the session.
  Future<Result<void>> logout();
}
