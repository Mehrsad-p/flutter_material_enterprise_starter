import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/entities/app_init_config.dart';

abstract interface class LauncherRepository {
  Future<Result<AppInitConfig>> getInitConfig();
  Future<Result<bool>> checkUserSession();
}
