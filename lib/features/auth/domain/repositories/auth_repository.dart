import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';

/// Repository contract for Authentication logic.
abstract interface class AuthRepository {
  /// Signs in a user using credentials.
  Future<Result<User>> login(String email, String password);

  /// Registers a new user.
  Future<Result<User>> signup(String email, String password);

  /// Checks if a valid session exists in secure storage and restores the user.
  Future<Result<User?>> restoreSession();

  /// Logs out the user and clears all cached sessions.
  Future<Result<void>> logout();
}
