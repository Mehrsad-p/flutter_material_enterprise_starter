// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_init_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppInitDto _$AppInitDtoFromJson(Map<String, dynamic> json) => _AppInitDto(
  isMaintenanceMode: json['isMaintenanceMode'] as bool,
  minimumVersion: json['minimumVersion'] as String,
);

Map<String, dynamic> _$AppInitDtoToJson(_AppInitDto instance) =>
    <String, dynamic>{
      'isMaintenanceMode': instance.isMaintenanceMode,
      'minimumVersion': instance.minimumVersion,
    };
