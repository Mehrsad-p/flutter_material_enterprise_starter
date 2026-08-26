// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponseDto<T> _$PaginatedResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginatedResponseDto<T>(
  items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
  total: (json['total'] as num?)?.toInt(),
  hasMore: json['hasMore'] as bool?,
);

Map<String, dynamic> _$PaginatedResponseDtoToJson<T>(
  PaginatedResponseDto<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items?.map(toJsonT).toList(),
  'total': instance.total,
  'hasMore': instance.hasMore,
};
