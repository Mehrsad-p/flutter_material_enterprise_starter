---
name: Architecture Verification Enforcer
description: Guidelines for auditing code boundaries, folder structures, and known architectural concerns.
---

# Architecture Verification Enforcer

## Purpose
Enforces static verification checks to verify that the project's layer boundaries and dependency rules are not violated.

## Scope
Audit checks across the entire codebase.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `_core/folder-structure`

## Rules
1. **Layer Dependency Verification**:
   - Verify that Domain layer imports do NOT contain any references to Presentation or Data layers.
   - Verify that Presentation files (views, pages, widgets) do NOT import any Data layer file.
2. **Naming Suffix Check**:
   - Verify that all files match their layer conventions (e.g. `_dto.dart`, `_datasource.dart`, `_repository_impl.dart`).

## Known Architectural Concerns (Audited)
- **Concern**:
  *Presentation controllers (e.g. `auth_controller.dart`, `home_controller.dart`) import `datasources/` and `repository_impl.dart` directly.*
- **Classification**:
  *Known Architectural Concern*.
- **Note**:
  This coupling is currently permitted solely for registering the concrete implementation providers inside the controller files. Views and widgets remain strictly forbidden from importing these implementation files.

## Forbidden
- **Layer Violations** ❌ MUST NOT be introduced without explicit architectural auditing and documentation.

## Workflow
1. Run boundaries audit before committing feature changes.
2. Ensure that views do not import internal data classes directly.

## Verification
- Run code compilation analysis and manually check import boundaries.
