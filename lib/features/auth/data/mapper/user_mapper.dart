import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';

/// Extension mapper to convert network DTOs to Domain Entities.
extension UserDtoMapper on UserDto {
  User toEntity() {
    return User(
      id: id,
      email: email,
    );
  }
}
