---
name: Widget Testing Enforcer
description: Guidelines for testing UI components, views, and Material 3 design widgets.
---

# Widget Testing Enforcer

## Purpose
Regulates the unit and integration testing of Material Design UI widgets, ensuring views render states correctly.

## Scope
Widget testing files under `test/`.

## Dependencies
### Required
- `_core/naming`

## Rules
1. **Mocking State**:
   - Provide overrides inside a mock `ProviderScope` to force controllers into success, loading, or error states.
2. **Localization Integration**:
   - Wrap the target widget with an `EasyLocalization` configuration or mock translation widgets to prevent missing key errors.
3. **M3 Compliance**:
   - Verify that standard Material 3 icons and widgets are present in the test finder.

## Forbidden
- **Widget Tests** ❌ MUST NOT use raw double layout values for assertions; verify elements by layout hierarchy and rendering.

## Workflow
1. Create a widget test file under `test/`.
2. Wrap the view/widget with localized mocks and watch provider overrides.
3. Run `flutter test`.

## Verification
- Run tests and check output.
