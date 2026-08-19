import 'package:flutter_material_enterprise_starter/features/home/data/dto/home_summary_dto.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/entities/home_summary.dart';

extension HomeSummaryDtoMapper on HomeSummaryDto {
  HomeSummary toEntity() {
    return HomeSummary(
      welcomeMessage: welcomeMessage,
      activeUsersCount: activeUsersCount,
      pendingTasksCount: pendingTasksCount,
    );
  }
}
