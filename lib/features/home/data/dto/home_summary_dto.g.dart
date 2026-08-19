// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeSummaryDto _$HomeSummaryDtoFromJson(Map<String, dynamic> json) =>
    _HomeSummaryDto(
      welcomeMessage: json['welcomeMessage'] as String,
      activeUsersCount: (json['activeUsersCount'] as num).toInt(),
      pendingTasksCount: (json['pendingTasksCount'] as num).toInt(),
    );

Map<String, dynamic> _$HomeSummaryDtoToJson(_HomeSummaryDto instance) =>
    <String, dynamic>{
      'welcomeMessage': instance.welcomeMessage,
      'activeUsersCount': instance.activeUsersCount,
      'pendingTasksCount': instance.pendingTasksCount,
    };
