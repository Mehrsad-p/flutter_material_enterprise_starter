import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_summary_dto.freezed.dart';
part 'home_summary_dto.g.dart';

@freezed
abstract class HomeSummaryDto with _$HomeSummaryDto {
  const factory HomeSummaryDto({
    required String welcomeMessage,
    required int activeUsersCount,
    required int pendingTasksCount,
  }) = _HomeSummaryDto;

  factory HomeSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryDtoFromJson(json);
}
