import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login(String email, String password);
  Future<Result<User>> signUp(String email, String password);
}
