abstract interface class HomeLocalDataSource {
  Future<Map<String, dynamic>> fetchHomeSummaryMock();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<Map<String, dynamic>> fetchHomeSummaryMock() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return {
      'welcomeMessage': 'به داشبورد مدیریت خوش آمدید',
      'activeUsersCount': 142,
      'pendingTasksCount': 12,
    };
  }
}
