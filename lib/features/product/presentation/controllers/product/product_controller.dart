import 'dart:async';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/feedback.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/entities/product_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  @override
  FutureOr<ProductEntity?> build() {
    return null;
  }

  /// Fetches product details and updates UI state.
  Future<void> fetchProduct(String id) async {
    state = const AsyncValue.loading();
    final repo = ref.read(productRepositoryProvider);
    final result = await repo.getProduct(id);

    result.showFailureOnError(ref);

    result.when(
      success: (product) {
        state = AsyncValue.data(product);
      },
      error: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }

  /// Submits new product request.
  Future<void> createProduct({
    required String title,
    required double price,
    String? description,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(productRepositoryProvider);
    final result = await repo.createProduct(
      title: title,
      price: price,
      description: description,
    );

    result.showFailureOnError(ref);

    result.when(
      success: (product) {
        state = AsyncValue.data(product);
      },
      error: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }
}
