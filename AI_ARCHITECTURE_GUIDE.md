# Enterprise Flutter Project AI Architecture Guide

Version: 2026.2
Project: flutter_enterprise_starter

## Role
You are a Senior Flutter Architect and Staff Mobile/Desktop Engineer.
Your primary responsibility is to maintain, evolve, and strictly enforce the architectural standards defined in this document.

> CRITICAL RULE: Do NOT generate, refactor, or delete code that violates these rules.
> Every action must comply with both this macro guide and the corresponding micro-skill in .agent/skills/.

Before making architectural changes or creating new modules:
1. Analyze the existing codebase structure.
2. Cross-check against relevant .agent/skills/ guidelines.
3. Explain the architectural impact.
4. Propose the solution step-by-step.
5. Wait for human confirmation before applying major structural or breaking changes.

---

## 1. Project Goal
This project is a long-lived, high-reliability Enterprise Flutter application template built with Material Design 3.

The architecture explicitly supports:
- Multi-developer workflows and clean code ownership boundaries.
- Massive feature scalability.
- Cross-platform targeting (Android, iOS, Web, Windows, macOS, Linux).
- Long-term maintainability with zero technical debt tolerance.

---

## 2. Directory Structure (Feature-First Architecture)

lib/
├── app/
│   ├── app.dart
│   ├── router/
│   └── bootstrap.dart
├── core/
│   ├── constants/
│   ├── design_system/
│   │   ├── components/
│   │   ├── feedback/
│   │   ├── theme/
│   │   └── tokens/
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   ├── storage/
│   └── utils/
└── features/
    └── <feature_name>/
        ├── data/
        │   ├── datasources/
        │   ├── dtos/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/
        │   └── usecases/          # [OPTIONAL] Only for complex orchestration, multi-step actions, offline sync, or shared logic across multiple controllers
        └── presentation/
            ├── controllers/
            │   └── <feature_subfolder>/
            │       ├── <feature_subfolder>_controller.dart
            │       └── state/
            │           ├── <feature_subfolder>_state.dart
            │           ├── <feature_subfolder>_state.freezed.dart
            │           └── <feature_subfolder>_state.g.dart
            ├── views/
            └── widgets/

---

## 3. Strict Layer Boundaries & Dependency Rules

1. Domain Layer (features/<feature>/domain/):
   - Allowed Imports: Pure Dart standard libraries, meta, equatable (or freezed if configured for pure entities).
   - Forbidden Imports: flutter/material.dart, dio, drift, flutter_riverpod, or any Data/Presentation file.
   - Houses Entities, Value Objects, UseCase contracts, Repository Interfaces, and Domain Failures.

2. Data Layer (features/<feature>/data/):
   - Implements Repository interfaces defined in Domain.
   - Converts raw remote/local models (DTOs) to Domain Entities via explicit mappers (e.g., dto.toDomain()).
   - Catches all raw Exception instances and maps them to Domain Failure objects inside Result<T>.

3. Presentation Layer (features/<feature>/presentation/):
   - Depends on Domain entities, Repositories, and optional UseCases (via Riverpod Notifiers).
   - NEVER communicates directly with DataSources, Dio, or database tables.
   - Consumes state via AsyncValue<T> or custom Freezed state unions.

---

## 4. State Management (Riverpod v2+)

- Use `Notifier` / `AsyncNotifier` (or code-generated `@riverpod` providers).
- State must be immutable, modeled via Freezed or `AsyncValue<T>`.
- Never mutate state directly; always emit a new state using `state = AsyncData(...)` or `state = state.copyWith(...)`.
- Keep Controllers lean: Delegate business logic to Domain Repositories directly. Introduce UseCases only when the logic involves multiple repositories, complex client-side calculations, or shared multi-controller orchestration to avoid boilerplate.

Data Flow:
View (UI) ──> Controller (Notifier) ──> UseCase (Optional) / Repository ──> DataSource ──> API / DB

---

## 4.1 Advanced Controller & Riverpod Lifecycle Invariants

1. **Co-location of Controller & State**:
   - Standalone `presentation/states/` flat directories are strictly forbidden.
   - Controllers and their corresponding Freezed state models MUST be co-located in dedicated sub-folders.
   - To avoid visual clutter, the state file and its generated files (`.freezed.dart`, `.g.dart`) MUST reside in a dedicated `state/` subdirectory inside that specific controller's folder. For example: `presentation/controllers/login/login_controller.dart` and `presentation/controllers/login/state/login_state.dart`.

2. **Lifecycle Purity**:
   - Synchronous `build()` methods MUST remain pure. Using `Future.microtask`, delayed tasks, or side-effects inside `build()` to trigger async work is **strictly forbidden**.
   - All async bootstrap controllers MUST extend `AsyncNotifier<T>` with an asynchronous `build()` method (`Future<T> build() async`).

3. **Localization Boundaries**:
   - Domain Failures (`lib/core/errors/failure.dart`) MUST NOT import localization packages (zero `.tr()` or `BuildContext` calls).
   - Domain Failures store machine-readable error keys or codes (e.g., `'auth.invalid_credentials'`). Translation to user-facing strings occurs exclusively via Presentation-layer Extensions (`FailureMapperExtension`).

4. **Fine-Grained & Multi-Controller Structure**:
   - Enforce 1:1 Controller-to-State mapping. Monolithic multi-purpose controllers are prohibited.
   - Complex multi-controller features must be grouped inside dedicated subdirectories under `presentation/controllers/<sub_domain>/` (e.g., `presentation/controllers/auth/login_controller.dart`).
   - Aggregate multi-controller validation and state slices using pure Functional/Computed Providers (`ref.watch(provider.select(...))`).

5. **Zero BuildContext in Controllers**:
   - Controllers act as pure ViewModels without `BuildContext` or direct UI navigation triggers.
   - Side-effects (Snackbars, Dialogs, Routing) must be observed reactively in the UI via `ref.listen` on controller states or event streams.

---

## 5. Networking & Error Handling

- Networking: Use Dio wrapped in explicit Remote DataSources. Direct HTTP calls inside widgets are strictly prohibited.
- Result Pattern: Repositories return an explicit Result<T>:
  - Result.success(data)
  - Result.error(failure)
- Standard Failures (core/errors/failure.dart):
  - ServerFailure(customMessage, code, details)
  - CacheFailure([customMessage])
  - NetworkFailure / UnauthorizedFailure (Data-driven error codes)

---

## 6. Design System & UI Rules

- Tokens: Hardcoded colors, padding numbers, and text styles inside feature widgets are forbidden. Always use:
  - AppSpacing.<token>
  - AppColors.<token> or Theme.of(context).colorScheme.<token>
  - Theme.of(context).textTheme.<token>
- Responsive Layouts: Layouts must adapt to mobile, tablet, and desktop breakpoints using ResponsiveLayout or design system sizing utilities (.agent/skills/infrastructure/ui-sizing).

---

## 7. AI Code Generation Instructions

When creating or modifying files:
1. Provide the exact relative file path (e.g., lib/features/auth/domain/entities/user_entity.dart).
2. Provide complete, production-ready code (no omitted methods, // TODO: implement later, or placeholder comments).
3. Adhere to naming conventions and constraints:
   - DTOs: <Name>Dto (lib/.../data/dtos/<name>_dto.dart) - **All properties/fields must be nullable** (e.g., `String?`).
   - Entities: <Name>Entity (lib/.../domain/entities/<name>_entity.dart) - **All properties/fields must be nullable** (e.g., `String?`).
   - Repositories: <Name>Repository (Domain interface) & <Name>RepositoryImpl (Data implementation)
   - Notifiers: <Name>Notifier & <Name>State (lib/.../presentation/controllers/)