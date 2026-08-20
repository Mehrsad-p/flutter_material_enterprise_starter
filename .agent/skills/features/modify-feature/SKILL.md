---
name: Feature Modifier Orchestrator
description: Orchestrates modifications and enhancements to existing features while preserving Clean Architecture boundaries.
---

# Feature Modifier Orchestrator

## Purpose
Governs the extension or refactoring of existing features (e.g. adding a UseCase, modifying a state property, introducing a new view).

## Scope
Existing functional features under `lib/features/`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `_core/coding-rules`
- `infrastructure/ui-sizing`
- `infrastructure/localization`

### Conditional
- Same as `create-feature`, resolved dynamically based on what layers of the feature are being modified.

## Rules
1. **Purity Preservance**:
   - When adding features, verify that modifications do not leak dependencies across layer boundaries (e.g. adding Dio imports to domain usecases is prohibited).
2. **Backward Compatibility**:
   - Modifying data schemas or DTO fields requires updating mapper extension methods to map defaults or nullable types safely.

## Forbidden
- **Modifications** ❌ MUST NOT bypass code-generation rules. Any modified Freezed model or Riverpod controller must be compiled via build_runner.

## Workflow
1. Identify target directories and files to modify.
2. Resolve Layer dependencies.
3. Update entities and interfaces (if contracts are changing).
4. Update concrete datasource implementations and DTOs.
5. Update state definitions and view widgets.
6. Re-generate build runner files.

## Verification
- Run static analysis.
- Run tests to check for regressions.
