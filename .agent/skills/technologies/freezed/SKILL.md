---
name: Freezed Technology Enforcer
description: Regulates the usage of the Freezed code-generation package in the codebase.
---

# Freezed Technology Enforcer

## Purpose
Specifies where Freezed is mandatory for immutability and state union pattern matching, and where it is strictly prohibited to keep code pure.

## Scope
All dart files using code generation.

## Dependencies
### Required
- `_core/naming`

## Rules
1. **Mandatory Freezed Locations**:
   - **DTOs** under `data/dto/`: Must use `@freezed` with `factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);` and part directives.
   - **UI States** under `presentation/states/`: Must use `@freezed` with union constructors representing different load phases (e.g. `initial()`, `loading()`, `success()`, `error()`).
   - **Core Outcome Wrappers** under `lib/core/errors/` (e.g. `Result` and `Failure`).
2. **Prohibited Freezed Locations**:
   - **Domain Entities** under `domain/entities/`: Must be written strictly as vanilla, standard Dart classes.
   - **Abstract interfaces** or contracts.
   - **Riverpod Notifier classes**: Only the state objects they manage are written with Freezed.

## Forbidden
- **Domain Entities** ❌ MUST NOT use `@freezed` or contain generated parts.

## Workflow
1. Declare class annotation `@freezed` and add `part 'filename.freezed.dart';` (and `part 'filename.g.dart';` if JSON parsing is needed).
2. Run build runner command: `dart run build_runner build --delete-conflicting-outputs`.

## Verification
- Verify that generated `.freezed.dart` files compile without issues.
