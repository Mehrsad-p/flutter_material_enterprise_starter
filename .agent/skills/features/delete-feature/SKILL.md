---
name: Feature Deletion Orchestrator
description: Guidelines for deleting features and updating route dependencies safely.
---

# Feature Deletion Orchestrator

## Purpose
Ensures that feature modules are deleted cleanly without leaving orphaned imports, routes, or files behind in the codebase.

## Scope
Entire feature folder removals under `lib/features/`.

## Dependencies
### Required
- `technologies/go-router`

## Rules
1. **Router Deregistration**:
   - Before deleting the feature folder, remove its route references in `lib/app/router/app_router.dart` and the routing key constant in `lib/app/router/app_routes.dart`.
2. **Directory Purge**:
   - Delete the entire `lib/features/[feature_name]/` directory.
3. **DI Provider Cleanup**:
   - Ensure that any other features importing or watching the deleted feature's providers are refactored.

## Forbidden
- **Deletions** ❌ MUST NOT leave dangling imports in `app_router.dart` or other controller files.

## Workflow
1. Remove GoRouter route registrations.
2. Remove localization assets if unique to this feature.
3. Delete the folder.
4. Run `build_runner` and verify that the app compiles cleanly.

## Verification
- Run `flutter analyze` to ensure there are no compilation errors.
