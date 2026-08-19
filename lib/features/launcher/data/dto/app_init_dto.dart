import 'package:json_annotation/json_annotation.dart';

part 'app_init_dto.g.dart';

@JsonSerializable()
class AppInitDto {
  final bool isMaintenanceMode;
  final String minimumVersion;

  const AppInitDto({
    required this.isMaintenanceMode,
    required this.minimumVersion,
  });

  factory AppInitDto.fromJson(Map<String, dynamic> json) =>
      _$AppInitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppInitDtoToJson(this);
}
