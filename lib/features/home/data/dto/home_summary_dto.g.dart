// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSummaryDto _$HomeSummaryDtoFromJson(Map<String, dynamic> json) =>
    HomeSummaryDto(
      welcomeMessage: json['welcomeMessage'] as String,
      activeUsersCount: (json['activeUsersCount'] as num).toInt(),
      pendingTasksCount: (json['pendingTasksCount'] as num).toInt(),
    );

Map<String, dynamic> _$HomeSummaryDtoToJson(HomeSummaryDto instance) =>
    <String, dynamic>{
      'welcomeMessage': instance.welcomeMessage,
      'activeUsersCount': instance.activeUsersCount,
      'pendingTasksCount': instance.pendingTasksCount,
    };
