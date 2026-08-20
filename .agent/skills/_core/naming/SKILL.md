---
name: Core Naming Enforcer
description: Enforces file, class, and provider naming conventions throughout the workspace.
---

# Core Naming Enforcer

## Purpose
Ensures that all filenames, class declarations, and Riverpod provider symbols match the exact naming style of the enterprise boilerplate.

## Scope
All source files under `lib/`.

## Dependencies
### Required
None.

## Rules
1. **File Naming**:
   - Must use `snake_case`.
   - DTO: `<name>_dto.dart`
   - Mapper: `<name>_mapper.dart`
   - DataSource: `<name>_datasource.dart` (or `<name>_local_datasource.dart`, `<name>_remote_datasource.dart`)
   - Repository: `<name>_repository.dart` and `<name>_repository_impl.dart`
   - Usecase: `<name>_usecase.dart`
   - Controller: `<name>_controller.dart`
   - State: `<name>_state.dart`
   - View/Page: `<name>_view.dart` or `<name>_page.dart` (and `<name>_body.dart` if applicable)
2. **Class Naming**:
   - Must use `PascalCase`.
   - DTO: `[Name]Dto`
   - Mapper Extension: `[Name]DtoMapper`
   - DataSource: `[Name]DataSource` / `[Name]DataSourceImpl`
   - Repository: `[Name]Repository` / `[Name]RepositoryImpl`
   - Usecase: `[Name]UseCase`
   - Controller: `[Name]Controller`
   - State: `[Name]State`
   - View/Page: `[Name]View` or `[Name]Page`
3. **Provider Naming**:
   - Must use `camelCase`.
   - Generated providers automatically append `Provider` to the function or class name (e.g., `homeControllerProvider`, `homeRepositoryProvider`).

## Forbidden
- **Filenames** ❌ MUST NOT use camelCase or CapitalLetters.
- **Classes** ❌ MUST NOT omit their type suffixes (e.g. `UserRepositoryImpl` must not be named `UserRepositoryImplementation` or `UserRepoImpl`).

## Workflow
1. Check the target file path and verify that its name conforms to `snake_case` with the proper suffix.
2. Check the class declarations inside the file and ensure they end with the correct suffix.
3. Check generated provider usages to verify they match `camelCase` naming.

## Verification
- Run `flutter analyze` to ensure code matches declarations.
