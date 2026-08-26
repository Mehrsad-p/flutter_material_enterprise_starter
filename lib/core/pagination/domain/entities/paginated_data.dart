/// A pure generic domain entity representing a single page of items.
///
/// This entity remains 100% pure Dart, agnostic of any data serialization logic
/// or UI frameworks.
class PaginatedData<T> {
  final List<T> items;
  final int total;
  final bool hasMore;

  const PaginatedData({
    required this.items,
    required this.total,
    required this.hasMore,
  });

  /// Creates an empty paginated data instance.
  factory PaginatedData.empty() => const PaginatedData(
        items: [],
        total: 0,
        hasMore: false,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginatedData<T> &&
          runtimeType == other.runtimeType &&
          total == other.total &&
          hasMore == other.hasMore &&
          _listEquals(items, other.items);

  @override
  int get hashCode => items.hashCode ^ total.hashCode ^ hasMore.hashCode;

  static bool _listEquals<E>(List<E> a, List<E> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
