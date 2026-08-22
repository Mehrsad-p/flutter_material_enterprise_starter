import 'package:flutter_material_enterprise_starter/features/launcher/data/dto/app_init_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launcher_local_datasource.g.dart';

abstract interface class LauncherLocalDataSource {
  Future<bool> hasActiveSession();
  Future<AppInitDto> fetchInitConfigMock();
}

class LauncherLocalDataSourceImpl implements LauncherLocalDataSource {
  const LauncherLocalDataSourceImpl();

  @override
  Future<bool> hasActiveSession() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return false;
  }

  @override
  Future<AppInitDto> fetchInitConfigMock() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final json = {
      'isMaintenanceMode': false,
      'minimumVersion': '1.0.0',
    };
    return AppInitDto.fromJson(json);
  }
}

@riverpod
LauncherLocalDataSource launcherLocalDataSource(LauncherLocalDataSourceRef ref) {
  return const LauncherLocalDataSourceImpl();
}

