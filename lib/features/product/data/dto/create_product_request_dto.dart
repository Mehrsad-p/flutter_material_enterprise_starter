import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_product_request_dto.freezed.dart';
part 'create_product_request_dto.g.dart';

@freezed
abstract class CreateProductRequestDto with _$CreateProductRequestDto {
  @JsonSerializable(includeIfNull: false)
  const factory CreateProductRequestDto({
    required String title,
    required double price,
    String? description,
  }) = _CreateProductRequestDto;

  factory CreateProductRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateProductRequestDtoFromJson(json);
}
