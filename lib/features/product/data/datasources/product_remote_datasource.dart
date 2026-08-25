import 'package:flutter_material_enterprise_starter/core/network/dio_client.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/datasources/product_api.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/dto/product_dto.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/dto/create_product_request_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_remote_datasource.g.dart';

abstract interface class ProductRemoteDataSource {
  /// Retrieves a product by ID.
  Future<ProductDto> getProduct(String id);

  /// Submits product creation request.
  Future<ProductDto> createProduct(CreateProductRequestDto request);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductApi _api;
  const ProductRemoteDataSourceImpl(this._api);

  @override
  Future<ProductDto> getProduct(String id) => _api.getProduct(id);

  @override
  Future<ProductDto> createProduct(CreateProductRequestDto request) =>
      _api.createProduct(request);
}

@riverpod
ProductRemoteDataSource productRemoteDataSource(ProductRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSourceImpl(ProductApi(dio));
}
