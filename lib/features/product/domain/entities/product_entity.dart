/// Pure Domain Entity representing a Product.
class ProductEntity {
  final String id;
  final String title;
  final double price;
  final String? description;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    this.description,
  });
}
