import 'package:flutter_material_enterprise_starter/features/launcher/data/dto/app_init_dto.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/entities/app_init_config.dart';

extension AppInitDtoMapper on AppInitDto {
  AppInitConfig toEntity() {
    return AppInitConfig(
      isMaintenanceMode: isMaintenanceMode,
      minimumVersion: minimumVersion,
    );
  }
}
