================================================================================
FILE: PROJECT_CONTEXT.md
================================================================================

# Project Context & Environment Details

## 1. Project Overview
- Project Name: flutter_enterprise_starter
- Type: Enterprise-grade Flutter Boilerplate / Starter Kit
- Target Platforms: Cross-Platform (Android, iOS, Web, Windows, macOS, Linux)
- Design System: Material Design 3 (M3)

---

## 2. Tech Stack & Dependencies

| Layer / Domain | Selected Technology / Package |
|---|---|
| Framework | Flutter (Latest Stable) |
| Design Language | Material 3 (package:flutter/material.dart) |
| State Management | flutter_riverpod (v2+) |
| Routing | go_router |
| Local Database | drift (SQLite) |
| Secure Storage | flutter_secure_storage |
| Key-Value Preferences | shared_preferences |
| Networking | dio + retrofit |
| Immutability & CodeGen | freezed, json_serializable, build_runner |
| Localization | flutter_localizations, intl (ARB files) |

---

## 3. Agent Skills & Enforcement Map

All code generation and modifications by AI agents MUST strictly comply with the granular skills located under `.agent/skills/`:

.agent/skills/
├── _core/
│   ├── architecture/           # Core architectural invariants & boundaries
│   ├── coding-rules/           # Dart style, immutability, zero-magic-values
│   ├── folder-structure/       # Feature-first directory conventions
│   └── naming/                 # Exact naming conventions for files & classes
├── layers/
│   ├── data/                   # DataSources, DTOs, Repositories implementations
│   ├── domain/                 # Entities, Value Objects, UseCases, Failures
│   └── presentation/           # Pages, Widgets, Notifiers, ViewStates
├── technologies/
│   ├── riverpod/               # State management standards & lifecycle
│   ├── dio/                    # Interceptors, token refresh, error mapping
│   ├── freezed/                # Data modeling, copyWith, unions
│   └── go_router/              # Declarative routing & guards
├── features/
│   ├── Enterprise Feature Scaffolder/ # Boilerplate generation for new features
│   └── form-builder/           # Dynamic form & validation standards
├── infrastructure/
│   ├── localization/           # Multi-language & RTL support via ARB
│   └── ui-sizing/              # Adaptive breakpoints & responsive layout tokens
└── testing/
    ├── architecture-verification/ # Guardrail tests for layer isolation
    ├── unit-testing/           # Unit tests for Domain & Data logic
    └── widget-testing/         # UI & golden testing rules

---

## 4. Standard Build & Code Generation Commands

When generating or modifying models, entities, database tables, or routes, run the relevant commands:

flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs
flutter gen-l10n

---

## 5. Architectural Highlights
1. Material 3 Tokenization: Colors, typography, shapes, and spacing defined as immutable design tokens inside lib/core/design_system/tokens/.
2. Adaptive Layouts: Support for dynamic screen sizes (Mobile, Tablet, Desktop NavigationRail/Sidebar) using M3 guidelines.
3. Strict Result Pattern: Explicit error catching in DataSources with Domain Failure mapping (Result<T>).
4. Zero Cross-Layer Leakage: Domain layer contains zero third-party I/O imports or database models.


================================================================================
FILE: AI_ARCHITECTURE_GUIDE.md
================================================================================

# Enterprise Flutter Project AI Architecture Guide

Version: 2026.2
Project: flutter_enterprise_starter

## Role
You are a Senior Flutter Architect and Staff Mobile/Desktop Engineer.
Your primary responsibility is to maintain, evolve, and strictly enforce the architectural standards defined in this document.

> CRITICAL RULE: Do NOT generate, refactor, or delete code that violates these rules.
> Every action must comply with both this macro guide and the corresponding micro-skill in `.agent/skills/`.

Before making architectural changes or creating new modules:
1. Analyze the existing codebase structure.
2. Cross-check against relevant `.agent/skills/` guidelines.
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
        │   └── usecases/
        └── presentation/
            ├── controllers/
            ├── states/
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
   - Depends ONLY on Domain entities and UseCases (via Riverpod Notifiers).
   - NEVER communicates directly with DataSources, Dio, or database tables.
   - Consumes state via AsyncValue<T> or custom Freezed state unions.

---

## 4. State Management (Riverpod v2+)

- Use Notifier / AsyncNotifier (or code-generated @riverpod providers).
- State must be immutable, modeled via freezed.
- Never mutate state directly; always emit a new state using state = state.copyWith(...).
- Keep Controllers lean: Delegate business logic to UseCases or Domain Repositories.

Data Flow:
View (UI) ──> Controller (Notifier) ──> UseCase / Repository ──> DataSource ──> API / DB

---

## 5. Networking & Error Handling

- Networking: Use Dio wrapped in explicit Remote DataSources. Direct HTTP calls inside widgets are strictly prohibited.
- Result Pattern: Repositories return an explicit Result<T>:
  - Result.success(data)
  - Result.failure(failure)
- Standard Failures (core/errors/failures.dart):
  - NetworkFailure
  - ServerFailure(message, statusCode)
  - UnauthorizedFailure
  - CacheFailure
  - ValidationFailure
  - UnknownFailure

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
3. Adhere to naming conventions:
   - DTOs: <Name>Dto (lib/.../data/dtos/<name>_dto.dart)
   - Entities: <Name>Entity (lib/.../domain/entities/<name>_entity.dart)
   - Repositories: <Name>Repository (Domain interface) & <Name>RepositoryImpl (Data implementation)
   - Notifiers: <Name>Notifier & <Name>State (lib/.../presentation/controllers/)