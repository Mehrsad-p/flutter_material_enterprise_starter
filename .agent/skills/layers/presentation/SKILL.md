---
name: Presentation Layer Enforcer
description: Rules for views, widgets, controllers, and presentation state objects.
---

# Presentation Layer Enforcer

## Purpose
Regulates the structure, rendering logic, and viewmodel integrations within the UI layer.

## Scope
All files under `lib/features/*/presentation/`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `technologies/freezed`
- `technologies/riverpod`
- `infrastructure/ui-sizing`
- `infrastructure/localization`

## Rules
1. **View Scaffold (Blank UI Canvas)**:
   - When generating new features, the main view (e.g. `[feature_name]_view.dart`) must be generated as a `ConsumerWidget` or `ConsumerStatefulWidget`.
   - The view must be kept blank and minimal (e.g., a simple Scaffold with an AppBar and placeholder/loading indicators). No mockup listing or styling should be added unless specifically requested.
2. **ViewModel (Controllers)**:
   - UI Controllers act as ViewModels. They must inherit from Riverpod Notifiers and communicate with UseCases.
   - Controllers must never manage business rules directly; they delegate to UseCases.
3. **UI States**:
   - Presentation state must be represented as a Freezed union class with constructors (e.g. `initial()`, `loading()`, `success(Data data)`, `error(String message)`).

## Forbidden
- **UI Views** ❌ MUST NOT store local business states or do raw I/O calls.
- **Controllers** ❌ MUST NOT return raw DTO models to the UI; they must present UI-ready data or Domain Entities.

## Workflow
1. Create Freezed UI State class under `presentation/states/`.
2. Create Notifier Controller class under `presentation/controllers/`.
3. Create view page under `presentation/views/` watching the controller and mapping state constructors using `.when(...)`.

## Verification
- Run code generation.
- Run `flutter analyze` to verify type safety.
