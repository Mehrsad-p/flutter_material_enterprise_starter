// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_init_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInitDto _$AppInitDtoFromJson(Map<String, dynamic> json) => AppInitDto(
  isMaintenanceMode: json['isMaintenanceMode'] as bool,
  minimumVersion: json['minimumVersion'] as String,
);

Map<String, dynamic> _$AppInitDtoToJson(AppInitDto instance) =>
    <String, dynamic>{
      'isMaintenanceMode': instance.isMaintenanceMode,
      'minimumVersion': instance.minimumVersion,
    };
