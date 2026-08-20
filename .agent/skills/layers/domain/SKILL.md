---
name: Domain Layer Enforcer
description: Regulates the purity of the Domain layer. Prohibits framework, database, and serialization dependencies.
---

# Domain Layer Enforcer

## Purpose
Ensures that the Domain layer (business rules, entities, usecases) remains completely decoupled from infrastructure, network clients, state management, and generated serialization files.

## Scope
All files under `lib/features/*/domain/`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`

## Rules
1. **Vanilla Domain Entities**:
   - Entities must be pure vanilla Dart classes (e.g. `class User { final String id; ... }`).
   - Must use `final` properties and a `const` constructor.
2. **Repository Contracts**:
   - Must be declared as `abstract interface class [Feature]Repository`.
   - Must return `Future<Result<T>>` to ensure all data errors are handled as failures.
3. **UseCases**:
   - Single-responsibility classes implementing an `execute()` method.
   - Must execute operations on the repository interface and return a `Future<Result<T>>`.
4. **Purity constraint**:
   - Do NOT import any serialization, database, state management, or network packages.
5. **No Session Tokens in Entities**:
   - Domain Entities must represent only core business attributes and identity parameters. They must never hold session tokens, refresh tokens, or other cache/infrastructure variables.

## Forbidden
- **Domain Entities** ❌ MUST NOT use `@freezed` annotations.
- **Domain files** ❌ MUST NOT import `package:flutter/material.dart` or `package:flutter_riverpod`.
- **Domain files** ❌ MUST NOT import `package:dio/dio.dart` or any data-layer class (e.g. DTOs, DataSources).

## Workflow
1. When creating a UseCase or Entity, make sure no database or serialization components are imported.
2. Interface contracts must only use Domain Entities and core `Result`/`Failure` wrappers.

## Verification
- Linter checks: `flutter analyze` ensuring domain purity.
