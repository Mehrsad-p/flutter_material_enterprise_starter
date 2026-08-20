---
name: Data Layer Enforcer
description: Standardizes DTOs, single-file DataSources, extension mappers, and repository implementations.
---

# Data Layer Enforcer

## Purpose
Enforces code layout and class structure conventions in the Data layer to ensure clean data-fetching operations, proper mapping, and robust error handling.

## Scope
All files under `lib/features/*/data/`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `technologies/freezed`
- `technologies/dio`

## Rules
1. **DTO Immutability**:
   - DTOs must use `@freezed` with JSON serialization generated files.
   - Located under `data/dto/`.
2. **Single-File DataSources**:
   - The `abstract interface class [Feature]DataSource` and its concrete implementation class `[Feature]DataSourceImpl` must reside inside the **same file** under `data/datasources/`.
   - Separate DataSource files into Remote (making HTTP calls via Dio) and Local (interacting with storage) subclasses to satisfy the Single Responsibility Principle (SRP).
   - DataSources must only execute raw I/O operations (fetching network data, accessing local storage) and return DTO models, not Domain Entities.
   - DataSources must NOT handle errors; they propagate raw exceptions upward.
3. **Mappers**:
   - Conversion from DTOs to Domain Entities must be implemented as extension methods on the DTO class inside `data/mapper/`.
   - Name must be `[DtoName]Mapper` and the method must be named `toEntity()`.
4. **Repository Implementation**:
   - Concrete repositories implement the domain contract, calling DataSource methods inside `safeApiCall()` blocks.
   - Converts returning DTO models to Domain Entities using mapper extension `.toEntity()`.
5. **Secure Token Storage**:
   - Sensitive session credentials (such as access tokens, refresh tokens, auth keys) must be stored in secure storage (using Android Keystore and iOS Keychain wrappers) rather than plain-text shared preferences.

## Forbidden
- **DataSources** ❌ MUST NOT return Domain Entities.
- **Repository Implementations** ❌ MUST NOT access network clients (Dio) directly. All networking must be delegated to DataSources.
- **Mappers** ❌ MUST NOT declare classes; they must be written strictly as Dart `extension` structures.

## Workflow
1. Create Freezed DTO under `data/dto/`.
2. Create abstract DataSource + concrete implementation inside the same file under `data/datasources/`.
3. Create mapper extension under `data/mapper/` mapping DTO `toEntity()`.
4. Create repository implementation under `data/repositories/` invoking datasources inside `safeApiCall()`.

## Verification
- Run code generation: `dart run build_runner build --delete-conflicting-outputs`.
- Run static analysis: `flutter analyze`.
