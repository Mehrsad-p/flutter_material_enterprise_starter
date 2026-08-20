---
name: Core Folder Structure Enforcer
description: Enforces the top-level directory structure of the app and standard feature layouts.
---

# Core Folder Structure Enforcer

## Purpose
Enforces folder structure compliance inside `lib/` and functional feature folders to maintain clean code boundaries and ease developer workflows.

## Scope
Directories under `lib/`.

## Dependencies
### Required
- `_core/architecture`

## Rules
1. **Top-Level Directories**:
   - `lib/app/`: Navigation router, bootstrap, and material app wrappers.
   - `lib/core/`: Common tools, networking clients, database configs, localizations, and design system.
   - `lib/features/`: Functional feature slices.
2. **Feature Folder Structure**:
   Each functional feature folder must contain:
   - `domain/` (entities, repositories, usecases)
   - `data/` (datasources, dto, mapper, repositories)
   - `presentation/` (controllers, states, views, widgets)
3. **Encapsulation Barrels**:
   - Every feature must have a root barrel file named after the feature (e.g. `auth.dart` or `home.dart`) located directly under `lib/features/<feature>/`.
   - Each layer folder inside the feature must have its own barrel file (e.g., `domain/domain.dart`, `data/data.dart`, `presentation/presentation.dart`).
   - The root barrel file MUST only export public layers (`domain` and `presentation`), keeping the internal implementation of `data/` hidden.

## Forbidden
- **Features** ❌ MUST NOT use horizontal directory structures at the root level (e.g., placing all pages under a global `lib/pages/` directory is prohibited).
- **Barrel Files** ❌ MUST NOT export `.freezed.dart` or `.g.dart` generated files.

## Workflow
1. When scaffolding a feature, verify that all three subdirectories (`data/`, `domain/`, `presentation/`) are created.
2. Create layer barrel files (`domain/domain.dart`, `presentation/presentation.dart`, `data/data.dart`).
3. Create the root feature barrel file exporting only `domain` and `presentation` layers.

## Verification
- Tree checking on feature directory path.
