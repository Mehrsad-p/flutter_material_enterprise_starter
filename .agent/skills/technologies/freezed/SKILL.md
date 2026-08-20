---
name: Freezed Technology Enforcer
description: Regulates the usage of the Freezed code-generation package in the codebase. Clearly defines where Freezed must be used (DTOs, UI States, Union/Sealed wrappers) and where it is prohibited (Domain Entities, raw interfaces).
---

# Freezed Technology Enforcer

## Purpose
Specifies where Freezed is mandatory for immutability and state union pattern matching, and where it is strictly prohibited to keep code pure and stable.

## Scope
All Dart files using code generation and data modeling in the project.

## Dependencies
### Required
- `_core/naming`

---

## 🧊 1. Where Freezed MUST Be Used

### A. Data Transfer Objects (DTOs)
All models that represent network payloads, database schemas, or cache payloads (located under `lib/features/<feature>/data/dto/`) must use `@freezed`.
*   **Requirements**:
    *   Must define a `factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);`.
    *   Must have both `part '<file_name>.freezed.dart';` and `part '<file_name>.g.dart';` directives.
*   **Why**: Guarantees immutability and generates boilerplates for serialization automatically.

### B. Controller/Presentation States
All UI state models (located under `lib/features/<feature>/presentation/states/`) must use `@freezed` union constructors.
*   **Requirements**:
    *   Must define states like `.initial()`, `.loading()`, `.success()`, and `.error()`.
*   **Why**: Enforces compile-time exhaustiveness checking when building UI widgets using `.when()` or Dart 3 `switch` expressions.

### C. Core sealed outcomes/wrappers
Any core model representing alternative outcomes (such as `Result<T>` and `Failure` under `lib/core/errors/`) must use `@freezed`.
*   **Why**: Standardizes flow-control and pattern matching across the app.

---

## 🚫 2. Where Freezed MUST NOT Be Used

### A. Domain Entities
Domain entities (located under `lib/features/<feature>/domain/entities/`) must **NEVER** use Freezed. They must be written as vanilla, standard Dart classes.
*   **Why**: The Domain layer must be pure and independent of third-party libraries and generated code. This keeps the core business rules stable and decoupled.

### B. Abstract Interface Classes
Contracts (e.g. data sources, repository definitions, or service interfaces) must not use Freezed.
*   **Why**: Freezed is for data values, not behavioral contracts.

### C. Riverpod Notifiers/Controllers
State notifier classes (e.g., `HomeController`) must not use Freezed. Only the state *model* they manage (e.g., `HomeState`) is written with Freezed.

---

## ⚙️ 3. Execution & Generation Rule
After creating or modifying any Freezed class, you must run the build runner command to update generated code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Verification
- Verify that generated `.freezed.dart` files compile without issues.
