import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/datasources/launcher_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/mapper/launcher_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/entities/app_init_config.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/repositories/launcher_repository.dart';

class LauncherRepositoryImpl implements LauncherRepository {
  final LauncherLocalDataSource _localDataSource;

  const LauncherRepositoryImpl(this._localDataSource);

  @override
  Future<Result<AppInitConfig>> getInitConfig() {
    return safeCall(
      call: () async {
        final dto = await _localDataSource.fetchInitConfigMock();
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<bool>> checkUserSession() {
    return safeCall(
      call: () => _localDataSource.hasActiveSession(),
      errorMapper: (e) => CacheFailure(e.toString()),
    );
  }
}
