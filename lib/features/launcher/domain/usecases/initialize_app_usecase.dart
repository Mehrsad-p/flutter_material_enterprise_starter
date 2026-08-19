import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/entities/app_init_config.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/repositories/launcher_repository.dart';

class InitializeAppUseCase {
  final LauncherRepository _repository;

  const InitializeAppUseCase(this._repository);

  Future<Result<AppInitConfig>> execute() async {
    return _repository.getInitConfig();
  }
}
