import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/datasources/launcher_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/dto/app_init_dto.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/mapper/launcher_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/entities/app_init_config.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/repositories/launcher_repository.dart';

class LauncherRepositoryImpl implements LauncherRepository {
  final LauncherLocalDataSource _localDataSource;

  const LauncherRepositoryImpl(this._localDataSource);

  @override
  Future<Result<AppInitConfig>> getInitConfig() async {
    try {
      final json = await _localDataSource.fetchInitConfigMock();
      final dto = AppInitDto.fromJson(json);
      return Result.success(dto.toEntity());
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> checkUserSession() async {
    try {
      final sessionActive = await _localDataSource.hasActiveSession();
      return Result.success(sessionActive);
    } catch (e) {
      return Result.failure(CacheFailure(e.toString()));
    }
  }
}
