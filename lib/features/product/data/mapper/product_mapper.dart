import 'package:flutter_material_enterprise_starter/features/product/data/dto/product_dto.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/entities/product_entity.dart';

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() => ProductEntity(
        id: id ?? '',
        title: title ?? '',
        price: price ?? 0.0,
        description: description,
      );
}
