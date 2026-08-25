---
name: Retrofit Technology Enforcer
description: Regulates the creation and usage of Retrofit REST client interfaces in features.
---

# Retrofit Technology Enforcer

## Purpose
Ensures clean, annotation-driven REST client declarations, separating HTTP routing details from Repository and DataSource implementation logic.

## Scope
Retrofit API client interfaces located under `lib/features/<feature>/data/datasources/`.

## Dependencies
- `_core/architecture`
- `technologies/dio`

## Rules
1. **File Location**: Define Retrofit interface classes directly inside `lib/features/<feature>/data/datasources/` next to their respective DataSources.
2. **File Naming**: Name files in snake_case ending with `_api.dart` (e.g., `user_api.dart`).
3. **Class Naming**: Name the interface `<Feature>Api` (e.g., `UserApi`).
4. **Part Directive**: Always include the generated part file path: `part '<filename>.g.dart';` (e.g., `part 'user_api.g.dart';`).
5. **Class Declaration**: Use `abstract class` for the Retrofit definition.
6. **Factory Constructor**: Every Retrofit interface must define a factory constructor matching this pattern:
   ```dart
   factory FeatureApi(Dio dio, {String baseUrl}) = _FeatureApi;
   ```
7. **HTTP Methods & Routing**: Use standard Retrofit annotations: `@GET`, `@POST`, `@PATCH`, `@PUT`, `@DELETE`.
8. **Routing Paths**: Keep routes parameterized and clean. Define path segments using `@Path('<name>')` and query params using `@Query('<name>')`.
9. **Payload Binding**: Bind request bodies using `@Body()`.
10. **Data Types**: API methods must return `Future<*Dto>` or `Future<void>`. They must NEVER return domain entities directly.
11. **Cancel Token Support**: Optionally accept a `@CancelRequest() CancelToken? cancelToken` parameter to support request cancellation.

## Pattern
```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/dto/user_dto.dart';
import 'package:flutter_material_enterprise_starter/features/auth/data/dto/login_request_dto.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<UserDto> login(@Body() LoginRequestDto request);
}
```

## Generated Files
- Run code generation:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- Verify that `<filename>.g.dart` is correctly generated and compiles.
