import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/domain/entities/paginated_data.dart';

part 'paginated_response_dto.g.dart';

/// A generic response Data Transfer Object (DTO) for paginated API endpoints.
///
/// Designed to parse generic JSON payloads via `genericArgumentFactories: true`.
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponseDto<T> {
  final List<T>? items;
  final int? total;
  final bool? hasMore;

  const PaginatedResponseDto({
    this.items,
    this.total,
    this.hasMore,
  });

  factory PaginatedResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedResponseDtoToJson(this, toJsonT);

  /// Maps this network DTO to a pure domain [PaginatedData] entity using [itemMapper].
  PaginatedData<E> toEntity<E>(E Function(T dto) itemMapper) {
    final mappedItems = items?.map(itemMapper).toList() ?? <E>[];
    final totalCount = total ?? mappedItems.length;
    final isMoreAvailable = hasMore ?? false;

    return PaginatedData<E>(
      items: mappedItems,
      total: totalCount,
      hasMore: isMoreAvailable,
    );
  }
}
