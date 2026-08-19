import 'package:flutter_material_enterprise_starter/features/home/data/dto/home_summary_dto.dart';

abstract interface class HomeLocalDataSource {
  Future<HomeSummaryDto> fetchHomeSummaryMock();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<HomeSummaryDto> fetchHomeSummaryMock() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final json = {
      'welcomeMessage': 'به داشبورد مدیریت خوش آمدید',
      'activeUsersCount': 142,
      'pendingTasksCount': 12,
    };
    return HomeSummaryDto.fromJson(json);
  }
}
