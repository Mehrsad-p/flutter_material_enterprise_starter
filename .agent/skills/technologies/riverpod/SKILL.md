---
name: Riverpod Technology Enforcer
description: Regulates the usage of Riverpod state management and generated provider wiring.
---

# Riverpod Technology Enforcer

## Purpose
Enforces standard Riverpod annotations, notifier inheritance, and provider declarations inside functional features.

## Scope
All provider and controller files under `lib/`.

## Dependencies
### Required
- `_core/naming`

## Rules
1. **Riverpod Generator Usage**:
   - Use `@riverpod` annotations to define providers (classes and functions).
   - Class controllers must inherit from generated superclasses (e.g. `class HomeController extends _$HomeController`).
2. **Decoupled DI Provider Location**:
   - Define concrete providers (like DataSources and Repositories) directly inside their respective implementation files in the `data/` layer (e.g. `auth_local_datasource.dart`, `auth_repository_impl.dart`). This avoids cluttering presentation files.
   - UseCase providers should be declared in the presentation layer or composition roots (like `auth_controller.dart`), instantiating UseCases by watching the abstract repository providers.
3. **Purity of Dependency Imports**:
   - When watching providers inside controllers or UseCases, reference the abstract interface type (e.g. `AuthRepository`) rather than the concrete implementation (`AuthRepositoryImpl`). This ensures the presentation layer does not import or couple to the `data/` layer directly.
4. **Dependency Retrieval**:
   - Within controllers, read other providers via `ref.read` (inside methods) or watch them via `ref.watch` (inside constructor/build/other providers).

## Forbidden
- **UI Views** ❌ MUST NOT use manual `setState` for business logic or coordinate async tasks directly.
- **Provider declarations** ❌ MUST NOT use legacy `StateNotifierProvider` or manual `ChangeNotifier`.

## Workflow
1. Declare Notifier class with `@riverpod` annotation and `part 'filename.g.dart';`.
2. Declare helper provider functions for usecases and repositories.
3. Run `dart run build_runner build` to compile providers.

## Verification
- Verify that all generated `.g.dart` files compile successfully.
