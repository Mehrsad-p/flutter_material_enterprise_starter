---
name: Feature Creator Orchestrator
description: High-level orchestrator skill to create new functional feature modules conforming to Clean Architecture.
---

# Feature Creator Orchestrator

## Purpose
Orchestrates the entire creation lifecycle of a new feature slice by resolving and loading layer-specific and technology-specific skills.

## Scope
Scaffolding functional features under `lib/features/`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `_core/folder-structure`
- `_core/coding-rules`
- `infrastructure/ui-sizing`
- `infrastructure/localization`

### Conditional
- **IF feature connects to REST API**:
  - Load `layers/domain-layer`
  - Load `layers/data-layer`
  - Load `technologies/freezed`
  - Load `technologies/dio`
- **IF feature utilizes State Management (Riverpod)**:
  - Load `layers/presentation-layer`
  - Load `technologies/riverpod`
  - Load `technologies/freezed`
- **IF feature requires Navigation Routing**:
  - Load `technologies/go-router`
- **IF feature requires Unit/Widget Tests**:
  - Load `testing/unit-testing`
  - Load `testing/widget-testing`

## Rules
1. **Scaffold Directory**:
   - Establish the standard directory structure defined in `_core/folder-structure`.
2. **Layer Dependencies**:
   - For all API actions, create Domain contracts (entities, repository interfaces, and optional usecases if required) before creating Data implementations (DTOs, DataSources).
3. **Encapsulate Barrel Exports**:
   - Write layer-specific barrel files (`domain/domain.dart`, `data/data.dart`, `presentation/presentation.dart`) and the root feature barrel file.

## Forbidden
- **Orchestration** ❌ MUST NOT rewrite or duplicate specific layer coding standards; it delegates these to child skills.

## Workflow
1. Parse the feature name and requested specifications (endpoints, states, UI requirements).
2. Resolve and load the required and conditional skills listed under Dependencies.
3. Generate Domain layer components (Entities, repository interface, and optional UseCases if complex orchestration is needed).
4. Generate Data layer components (Freezed DTOs, datasource file, mappers, repository implementations).
5. Generate Presentation layer components (Freezed UI State, Riverpod controller, views/widgets).
6. Update routing registration keys in `app_routes.dart` and register pages in `app_router.dart`.
7. Compile and run build generators:
   `dart run build_runner build --delete-conflicting-outputs`
8. Execute verification steps (linter + analysis).

## Verification
- Run `flutter analyze` to ensure code is compile-clean.
- Execute unit and widgets tests under `test/`.
