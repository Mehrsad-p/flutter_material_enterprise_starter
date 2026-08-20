---
name: Core Architecture Enforcer
description: Core architectural boundaries and layer isolation rules. Enforces clean separation between Data, Domain, and Presentation layers.
---

# Core Architecture Enforcer

## Purpose
Enforces the fundamental architectural boundary rules of the project. Ensures that all layers are properly decoupled and dependencies flow in the correct direction.

## Scope
All source files located under `lib/`.

## Dependencies
### Required
None.

## Rules
1. **Dependency Flow Direction**:
   - Dependencies must flow strictly inward: `Presentation ──> Domain <── Data`.
   - Domain is the innermost core layer and must remain pure.
2. **Layer Isolation**:
   - **Domain** must NOT depend on any external I/O framework, package, or UI framework (e.g. Flutter, Dio, Shared Preferences, Drift).
   - **Data** depends on Domain (implements domain interfaces, maps DTOs to entities) and network/cache components.
   - **Presentation** depends on Domain (executes use cases, renders entities) and local view configurations.

## Forbidden
- **Domain** ❌ MUST NOT import `package:flutter/material.dart` or `package:flutter_riverpod`.
- **Domain** ❌ MUST NOT import Dio, Retrofit, Database components, or Data Sources.
- **Domain** ❌ MUST NOT import DTOs or Presentation components.
- **Presentation** ❌ MUST NOT import files from `data/` layers (e.g., `data/dto/`, `data/mapper/`, `data/repositories/` or `data/datasources/`), with the sole exception of registering providers inside the Controller file. Views and widgets must never import `data/` directly.

## Workflow
1. Analyze imports at the top of the file.
2. Verify that the file does not violate the Forbidden rules for its respective layer.
3. If a boundary rule is violated, halt and resolve the import issue.

## Verification
- Run `flutter analyze` to check for compilation issues.
- Verify that there are no forbidden imports using manual boundary checks.
