// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedState<T> _$PaginatedStateFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PaginatedState<T>(
  items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  isFetchingMore: json['isFetchingMore'] as bool? ?? false,
  hasMore: json['hasMore'] as bool? ?? true,
);

Map<String, dynamic> _$PaginatedStateToJson<T>(
  _PaginatedState<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'currentPage': instance.currentPage,
  'isFetchingMore': instance.isFetchingMore,
  'hasMore': instance.hasMore,
};
