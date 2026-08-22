import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';

extension UserDtoMapper on UserDto {
  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
      );
}
