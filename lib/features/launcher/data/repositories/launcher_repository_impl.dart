import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/datasources/launcher_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/mapper/launcher_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/entities/app_init_config.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/repositories/launcher_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launcher_repository_impl.g.dart';

class LauncherRepositoryImpl implements LauncherRepository {
  final LauncherLocalDataSource _localDataSource;

  const LauncherRepositoryImpl(this._localDataSource);

  @override
  Future<Result<AppInitConfig>> getInitConfig() {
    return safeApiCall(
      call: () async {
        final dto = await _localDataSource.fetchInitConfigMock();
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<bool>> checkUserSession() {
    return safeApiCall(
      call: () => _localDataSource.hasActiveSession(),
      errorMapper: (e) => CacheFailure(e.toString()),
    );
  }
}

@riverpod
LauncherRepository launcherRepository(LauncherRepositoryRef ref) {
  final dataSource = ref.watch(launcherLocalDataSourceProvider);
  return LauncherRepositoryImpl(dataSource);
}

