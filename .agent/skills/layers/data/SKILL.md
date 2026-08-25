---
name: Data Layer Enforcer
description: Enforces strict conventions for the data layer in this Flutter project. Covers Freezed DTOs, DataSource pattern (abstract interface + impl in a single file), mapper extensions, and repository implementation. The agent must follow these rules when creating or editing any file under `lib/features/*/data/`.
---

# Data Layer Conventions

This skill governs everything inside `lib/features/<feature>/data/`. Follow these rules precisely whenever you create, edit, or review code in the data layer.

---

## 📁 Directory Structure

Each feature's `data/` layer must follow this exact structure:

```
lib/features/<feature>/data/
├── datasources/
│   └── <feature>_datasource.dart          # abstract interface + impl in same file
├── dto/
│   └── <model>_dto.dart                   # @freezed DTO
│   └── <model>_dto.freezed.dart           # generated — never edit
│   └── <model>_dto.g.dart                 # generated — never edit
├── mapper/
│   └── <model>_mapper.dart                # extension on DTO
└── repositories/
    └── <feature>_repository_impl.dart     # implements domain interface
```

---

## 🧊 Rule 1 — DTOs must use `@freezed`

**NEVER** use raw `@JsonSerializable()` classes for DTOs. All DTOs must be `@freezed` immutable value objects.

### ✅ Correct pattern

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    String? id,
    String? email,
    String? token,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
```

### ❌ Forbidden pattern — never do this

```dart
// ❌ FORBIDDEN: do not use @JsonSerializable directly
@JsonSerializable()
class UserDto {
  final String? id;
  const UserDto({this.id});
  factory UserDto.fromJson(...) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
```

### Rules

- Import **only** `freezed_annotation`, never `json_annotation` directly in DTO files.
- Always declare `part '<name>.freezed.dart';` AND `part '<name>.g.dart';` in that order.
- Use `abstract class` + `with _$<Name>` syntax for the class.
- Use `const factory` for the default constructor.
- **Nullability constraint**: All fields must use Dart's nullable syntax: `String? fieldName`. Do NOT use non-nullable types or `required` fields in DTO constructors to avoid parsing failures on missing fields.
- Use `@JsonKey(name: 'snake_case_field')` for fields with different API names.
- Run `dart run build_runner build --delete-conflicting-outputs` after every DTO change.

---

## 🔌 Rule 2 — DataSource: abstract interface + impl in one file

DataSources handle raw network/local I/O. They return DTOs, not domain entities.

### Pattern (Using Retrofit for Network Calls)

```dart
// lib/features/auth/data/datasources/auth_datasource.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/core/network/dio_client.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/datasources/auth_api.dart';

part 'auth_datasource.g.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserDto> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi _api;
  const AuthRemoteDataSourceImpl(this._api);

  @override
  Future<UserDto> login(String email, String password) {
    // Delegating HTTP calls to the Retrofit API client
    return _api.login(LoginRequestDto(email: email, password: password));
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(AuthApi(dio));
}
```

### Rules

- The `abstract interface class` (e.g., `<Feature>RemoteDataSource`) and its `Impl` (e.g., `<Feature>RemoteDataSourceImpl`) must be in the **same file**.
- Separate DataSource files into Remote (making HTTP calls via Retrofit API) and Local (interacting with database/storage/cache) subclasses to satisfy the Single Responsibility Principle (SRP).
- DataSources must **never** contain business logic.
- DataSources return **DTOs** (`*Dto`), not domain entities.
- DataSources are named `<Feature>RemoteDataSource` and `<Feature>RemoteDataSourceImpl`.
- Remote datasources take their respective Retrofit client (e.g., `<Feature>Api`) as a constructor argument, rather than executing raw HTTP requests manually.
- Local datasources take `SharedPreferences`, `Drift` database, or other local stores as needed.
- All methods must return `Future<T>`.
- DataSources must NOT handle errors; they propagate raw exceptions upward.

---

## 🗺️ Rule 3 — Mappers: extension methods on DTOs

Mappers convert DTOs → domain entities. They live in `data/mapper/` as extension files.

### Pattern

```dart
// lib/features/auth/data/mapper/user_mapper.dart

import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';

extension UserDtoMapper on UserDto {
  User toEntity() => User(
        id: id,
        email: email,
        token: token,
      );
}
```

### Rules

- Mapper files contain **only** extension methods — no classes.
- Extension name must be `<Dto>Mapper` (e.g., `UserDtoMapper`).
- The extension method must be named `toEntity()`.
- Never put mapping logic inside the DTO or entity.

---

## 🏛️ Rule 4 — Repository Implementation

Repository implementations live in `data/repositories/` and implement the abstract contract from `domain/repositories/`.

### Pattern

```dart
// lib/features/auth/data/repositories/auth_repository_impl.dart

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);
  final AuthDataSource _dataSource;

  @override
  Future<User> login(String email, String password) async {
    final dto = await _dataSource.login(email, password);
    return dto.toEntity();
  }
}
```

### Rules

- Repository impl **never** accesses Dio directly — always via a DataSource.
- Repository impl converts DTOs to entities using mapper extensions.
- Error handling (try/catch) and Result mapping live at the repository layer, not the datasource. Run datasource methods inside `safeApiCall()` blocks.
- Repository implementations are provided via Riverpod providers.
- **Secure Token Storage**: Sensitive session credentials (such as access tokens, refresh tokens, auth keys) must be stored in secure storage (using Android Keystore and iOS Keychain wrappers) rather than plain-text shared preferences.

---

## 🚫 Forbidden

- **DataSources** ❌ MUST NOT return Domain Entities.
- **Repository Implementations** ❌ MUST NOT access network clients (Dio) directly. All networking must be delegated to DataSources.
- **Mappers** ❌ MUST NOT declare classes; they must be written strictly as Dart `extension` structures.

---

## ⚙️ Code Generation & Verification

- Run code generation: `dart run build_runner build --delete-conflicting-outputs`.
- Run static analysis: `flutter analyze`.
