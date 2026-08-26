import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_state.freezed.dart';
part 'paginated_state.g.dart';

/// A pure generic Freezed state model representing paginated list data.
@Freezed(genericArgumentFactories: true)
abstract class PaginatedState<T> with _$PaginatedState<T> {
  const factory PaginatedState({
    @Default([]) List<T> items,
    @Default(1) int currentPage,
    @Default(false) bool isFetchingMore,
    @Default(true) bool hasMore,
  }) = _PaginatedState<T>;

  factory PaginatedState.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedStateFromJson(json, fromJsonT);
}
