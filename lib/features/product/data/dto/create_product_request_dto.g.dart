// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateProductRequestDto _$CreateProductRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateProductRequestDto(
  title: json['title'] as String,
  price: (json['price'] as num).toDouble(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$CreateProductRequestDtoToJson(
  _CreateProductRequestDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'price': instance.price,
  if (instance.description case final value?) 'description': value,
};
