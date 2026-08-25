import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/dto/create_product_request_dto.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/mapper/product_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/entities/product_entity.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository_impl.g.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  const ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<ProductEntity>> getProduct(String id) {
    return safeApiCall(
      call: () async {
        final dto = await _remoteDataSource.getProduct(id);
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Result<ProductEntity>> createProduct({
    required String title,
    required double price,
    String? description,
  }) {
    return safeApiCall(
      call: () async {
        final request = CreateProductRequestDto(
          title: title,
          price: price,
          description: description,
        );
        final dto = await _remoteDataSource.createProduct(request);
        return dto.toEntity();
      },
    );
  }
}

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
}
