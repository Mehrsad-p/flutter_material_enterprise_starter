import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_init_dto.freezed.dart';
part 'app_init_dto.g.dart';

@freezed
abstract class AppInitDto with _$AppInitDto {
  const factory AppInitDto({
    required bool isMaintenanceMode,
    required String minimumVersion,
  }) = _AppInitDto;

  factory AppInitDto.fromJson(Map<String, dynamic> json) =>
      _$AppInitDtoFromJson(json);
}
