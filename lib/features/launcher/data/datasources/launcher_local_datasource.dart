abstract interface class LauncherLocalDataSource {
  Future<bool> hasActiveSession();
  Future<Map<String, dynamic>> fetchInitConfigMock();
}

class LauncherLocalDataSourceImpl implements LauncherLocalDataSource {
  const LauncherLocalDataSourceImpl();

  @override
  Future<bool> hasActiveSession() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return false;
  }

  @override
  Future<Map<String, dynamic>> fetchInitConfigMock() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return {
      'isMaintenanceMode': false,
      'minimumVersion': '1.0.0',
    };
  }
}
