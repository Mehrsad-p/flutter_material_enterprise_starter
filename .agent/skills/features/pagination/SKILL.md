---
name: Enterprise Pagination Enforcer
description: Standardizes pagination implementation across Domain, Data, and Presentation layers, detailing decision matrices, layer purity, Notifier lifecycles, and failure handling.
---

# Enterprise Pagination Enforcer

## Purpose
Enforces the standardized pattern for implementing paginated list fetching, state management, error handling, and UI integration. Adhering to these rules guarantees smooth scrolling, robust load-more recovery, and zero leakage of raw networking details to the presentation/domain layers.

## Scope
All repositories, remote data sources, state models, controllers, and list views that display paginated data.

## Dependencies
- `_core/architecture`
- `technologies/riverpod`
- `technologies/retrofit`

---

## 1. Decision Matrix (When to use Pagination)

Agents must evaluate the dataset characteristics before deciding on a pagination strategy:

| Metric / Scenario | Pagination Strategy | Rationale |
|---|---|---|
| **Large/Dynamic Datasets** (e.g., > 50 items, feeds, transactions, products) | **Use Pagination** | Prevents high memory consumption, reduces network payload size, and speeds up initial page load. |
| **Search Results** | **Use Pagination** | Search results are unpredictable and can return hundreds of matching entries. |
| **Static Lookup Tables** (e.g., list of countries, currencies, simple categories) | **Do NOT Use Pagination** | A single fetch is faster, avoids multiple roundtrips, and allows instantaneous local filtering. |
| **User Settings & Small Configurations** (guaranteed < 50 items) | **Do NOT Use Pagination** | Overhead of pagination state adds unnecessary complexity without any UX benefits. |

---

## 2. Domain Layer Purity

The domain layer must remain pure and fully agnostic of pagination frameworks or API-specific response wrappers (like `BaseModel` or `ApiResponse`).

### Centralized Pagination Entity
Do NOT define custom pagination entities. The project uses a single centralized generic entity: `PaginatedData<T>`, located in `lib/core/pagination/domain/entities/paginated_data.dart` (or exposed via `package:flutter_material_enterprise_starter/core/pagination/pagination.dart`).

### Repository Signatures
Repository interfaces must return this core entity wrapped inside a standard `Result<T>` and accept a `DomainCancelToken?` for request cancellation:

```dart
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/pagination.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/entities/product_entity.dart';

abstract interface class ProductRepository {
  /// Fetches a paginated list of products.
  Future<Result<PaginatedData<ProductEntity>>> getProducts({
    required int page,
    required int limit,
    String? search,
    DomainCancelToken? cancelToken,
  });
}
```


---

## 3. Data Layer & Network Integration

The Data layer acts as the translation layer. It is responsible for calling the raw API, unwrapping the JSON response wrapper, and mapping data transfer objects (DTOs) to domain entities.

### Retrofit Endpoint Definition
In the API interface, page and limit query parameters must be explicitly defined. All paginated endpoints MUST use the generic `PaginatedResponseDto<T>` from core and accept a Dio `CancelToken` via `@CancelRequest()` to support physical request aborts:

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/pagination.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/dto/product_dto.dart';
import 'package:flutter_material_enterprise_starter/core/network/base_model.dart'; // hypothetical wrapper

part 'product_api.g.dart';

@RestApi()
abstract class ProductApi {
  factory ProductApi(Dio dio, {String baseUrl}) = _ProductApi;

  @GET('/products')
  Future<BaseModel<PaginatedResponseDto<ProductDto>>> getProducts(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('q') String? search,
    @CancelRequest() CancelToken? cancelToken,
  );
}
```

### Mapping & Repository Implementation
Inside `ProductRepositoryImpl`, adapt the pure `DomainCancelToken` to a Dio `CancelToken` using the `.toDioToken()` adapter extension, and pass it to the remote data source call:

```dart
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/pagination.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/data/cancellation/cancel_token_adapter.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/mapper/product_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/entities/product_entity.dart';
import 'package:flutter_material_enterprise_starter/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  const ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<PaginatedData<ProductEntity>>> getProducts({
    required int page,
    required int limit,
    String? search,
    DomainCancelToken? cancelToken,
  }) {
    return safeApiCall(
      call: () async {
        final BaseModel<PaginatedResponseDto<ProductDto>> responseWrapper = 
            await _remoteDataSource.getProducts(
              page: page,
              limit: limit,
              search: search,
              cancelToken: cancelToken?.toDioToken(),
            );

        final paginatedDto = responseWrapper.data; // unwrap BaseModel

        // Map DTO list to Domain Entity list using the built-in core helper
        return paginatedDto.toEntity((dto) => dto.toEntity());
      },
    );
  }
}
```

---

## 4. Presentation Layer (State & Riverpod)

### 1. AsyncNotifier Controller Implementation
The controller extends `AutoDisposeAsyncNotifier` and mixes in `PaginationNotifierMixin<T>` to manage the generic `PaginatedState<T>` state.

```dart
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/pagination.dart';
import 'package:flutter_material_enterprise_starter/features/product/data/repositories/product_repository_impl.dart';

part 'product_list_controller.g.dart';

@riverpod
class ProductListController extends _$ProductListController
    with PaginationNotifierMixin<ProductEntity> {
  static const int _pageSize = 20;
  Timer? _debounceTimer;
  String _searchQuery = '';

  @override
  FutureOr<PaginatedState<ProductEntity>> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    // Delegate initial load to mixin helper
    return initialLoad();
  }

  @override
  Future<Result<PaginatedData<ProductEntity>>> fetchPage(
    int page, {
    DomainCancelToken? cancelToken,
  }) {
    final repo = ref.read(productRepositoryProvider);
    return repo.getProducts(
      page: page,
      limit: _pageSize,
      search: _searchQuery.isNotEmpty ? _searchQuery : null,
      cancelToken: cancelToken,
    );
  }

  /// Handles search query inputs with debouncing.
  void search(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // refreshPaginated is provided by PaginationNotifierMixin
      refreshPaginated();
    });
  }
}
``````

---

## 5. Declarative UI Integration

The Presentation layer renders the paginated data using the centralized `PaginatedListView<T>` widget from core. This component handles scroll notifications, scroll threshold detection, and bottom loading spinners natively.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/pagination.dart';
import 'package:flutter_material_enterprise_starter/features/product/presentation/controllers/product_list/product_list_controller.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(productListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: stateAsync.when(
        data: (state) => PaginatedListView(
          items: state.items,
          hasMore: state.hasMore,
          isFetchingMore: state.isFetchingMore,
          onLoadMore: () => ref.read(productListControllerProvider.notifier).loadMore(),
          onRefresh: () async => ref.refresh(productListControllerProvider.future),
          itemBuilder: (context, item, index) {
            return ListTile(
              title: Text(item.name ?? 'Unnamed Product'),
              subtitle: Text('\$${item.price ?? 0.0}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
```

---

## Forbidden Practices ❌

- **Domain Contamination** ❌ The Domain layer must NEVER import API classes, Retrofit classes, DTOs, or package `dio`.
- **Destructive Load-More Errors** ❌ Do not clear `items` or set the controller state to `AsyncError` when `loadMore()` fails. Doing so disrupts the user's viewport.
- **Microtasks in build()** ❌ Do not use `Future.microtask` inside `build()` to fetch paginated data asynchronously. Always return a proper Future from the async `build()` method.
- **Direct UI Popups in Controller** ❌ Do not call dialogs, snackbars, or access `BuildContext` inside the controller. Dispatch errors to `AppFeedbackController` or expose standard state wrappers that the UI can listen to.
- **Undebounced Searches** ❌ Do not fire network requests on every keystroke in search views. Search inputs tied to paginated endpoints must be debounced natively.
