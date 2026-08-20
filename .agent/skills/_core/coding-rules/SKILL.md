---
name: Core Coding Rules Enforcer
description: General rules for code formatting, imports, and agent generations.
---

# Core Coding Rules Enforcer

## Purpose
Enforces code writing and file formatting standards during AI generation to ensure clean, executable, and compilable code blocks.

## Scope
All dart code blocks.

## Dependencies
### Required
None.

## Rules
1. **Complete Code Blocks**:
   - The Agent must output complete, executable file contents.
   - Prohibited: placeholder comments like `// ... rest of code` or `// implement other cases`.
2. **Relative Imports**:
   - Within the same feature layer or core folder, relative imports are permitted for simplicity.
   - For importing external core layers or other feature components, package-level absolute imports must be used (e.g. `import 'package:flutter_material_enterprise_starter/core/errors/result.dart';`).
3. **No Unused Imports**:
   - Do not import files that are not referenced in the code, to keep the compiler clean and avoid linter warnings.

## Forbidden
- **Generations** ❌ MUST NOT output code snippets or patch diffs without complete file contents unless requested.

## Workflow
1. Double-check imports before finishing file generation.
2. Ensure there are no code placeholders.

## Verification
- Run `flutter analyze` to ensure files compile without warnings.
