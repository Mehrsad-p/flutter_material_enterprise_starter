import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import '../entities/product_entity.dart';

abstract interface class ProductRepository {
  /// Fetches a product by its unique ID.
  Future<Result<ProductEntity>> getProduct(String id);

  /// Creates a new product on the backend.
  Future<Result<ProductEntity>> createProduct({
    required String title,
    required double price,
    String? description,
  });
}
