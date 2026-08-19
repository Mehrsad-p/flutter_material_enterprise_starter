import 'package:json_annotation/json_annotation.dart';

part 'home_summary_dto.g.dart';

@JsonSerializable()
class HomeSummaryDto {
  final String welcomeMessage;
  final int activeUsersCount;
  final int pendingTasksCount;

  const HomeSummaryDto({
    required this.welcomeMessage,
    required this.activeUsersCount,
    required this.pendingTasksCount,
  });

  factory HomeSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSummaryDtoToJson(this);
}
