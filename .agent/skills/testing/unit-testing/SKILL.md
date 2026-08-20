---
name: Unit Testing Enforcer
description: Guidelines for writing unit tests for usecases, controllers, and repositories.
---

# Unit Testing Enforcer

## Purpose
Ensures that new business logic (usecases, controllers) is covered by comprehensive unit tests.

## Scope
Test files under `test/`.

## Dependencies
### Required
- `_core/naming`

## Rules
1. **Mocking**:
   - Use mock classes or fake implementations for network and database client interfaces.
2. **UseCase Tests**:
   - Usecases should be tested for both success and failure outcomes (e.g. mock repository returning `Result.success` and `Result.error`).
3. **Controller Tests**:
   - Test initial states, transitions to loading, and success/error resolutions using Riverpod `ProviderContainer`.

## Forbidden
- **Unit Tests** ❌ MUST NOT hit real API endpoints or read/write to local device databases.

## Workflow
1. Create a matching test file under `test/` (e.g., `test/features/auth/domain/usecases/login_usecase_test.dart`).
2. Write tests covering standard success and failure scenarios.
3. Run `flutter test`.

## Verification
- Run `flutter test` command.
