---
name: Form Builder Enforcer
description: Enforces that all user input forms are implemented declaratively using AppFormBuilder and AppValidator.
---

# Form Builder Enforcer

## Purpose
Ensures that all forms, input fields, validation logic, and submission handlers are written in a clean, declarative, and unified manner using the design system's `AppFormBuilder` and `AppValidator` components instead of manual controllers, form keys, or raw validation blocks.

## Scope
All UI views, screens, and features containing input forms.

## Dependencies
### Required
- `_core/architecture`
- `infrastructure/localization`

## Rules
1. **Always Use AppFormBuilder**:
   - Any feature screen requiring a form (like login, register, profile edits, settings) must render its input fields via the `AppFormBuilder` widget from `package:flutter_material_enterprise_starter/core/design_system/widgets/app_form_builder.dart`.
2. **Always Use AppValidator**:
   - Validation rules for `AppFormFieldConfig` must be declared using the chainable `AppValidator` builder (e.g. `AppValidator.builder.required(...).email(...).build()`).
   - Raw inline validator callbacks containing manual `if (value == null)` or regex checks are strictly prohibited.
3. **No Stateful Controllers in Views**:
   - Form View classes must extend `ConsumerWidget` or `StatelessWidget`.
   - Never declare manual `TextEditingController` or `GlobalKey<FormState>` variables inside UI views for inputs that are part of a form. All text inputs must be defined declaratively in `AppFormFieldConfig`.
4. **Cross-Field Validation**:
   - For validations that depend on other fields (e.g. Confirm Password matching Password), use `AppValidator.builder.matchField('otherFieldName', message)`.
5. **Trim Strategy**:
   - Ensure that whitespace is trimmed before validations run. `AppValidator` handles trimming automatically inside its chainable rules.
6. **External Loading State — Controller Integration**:
   - When `AppFormBuilder` is used in a view that belongs to a feature with a **Riverpod controller managing async state** (e.g. login, register, profile update), the view MUST pass the controller's loading state to `AppFormBuilder` via the `isLoading` parameter.
   - Inside the `ConsumerWidget.build` method, watch the controller, derive a `ValueNotifier<bool>` from it using the state's `isLoading` getter (or equivalent), and pass it in:
     ```dart
     // Inside the view's ConsumerWidget build:
     final authState = ref.watch(authControllerProvider);
     final isLoading = ValueNotifier<bool>(authState.isLoading);

     AppFormBuilder(
       isLoading: isLoading,
       fields: [...],
       onSubmit: (values) async { ... },
     )
     ```
   - This makes the submit button spinner reflect the true controller state (e.g. while an API call is in progress), rather than relying only on `AppFormBuilder`'s internal future-tracking.
   - When there is **no controller with async loading state** (e.g. a local-only validation form), omit `isLoading` and `AppFormBuilder` will manage its own internal loading state automatically.

## Forbidden
- **UI Files** ❌ MUST NOT use manual `TextEditingController` for forms.
- **UI Files** ❌ MUST NOT declare inline form validators with raw string comparisons or raw regular expression checks.
- **UI Files** ❌ MUST NOT use raw `Form` or `TextFormField` widgets directly for multi-field forms; delegate to `AppFormBuilder`.
- **UI Files** ❌ MUST NOT ignore the Riverpod controller's loading state when the controller performs async operations (login, register, save, etc.); always wire it to `AppFormBuilder` via `isLoading`.

## Workflow
1. Declare your form configuration list `List<AppFormFieldConfig>` inline in the view's `build` method.
2. Chain validation rules using `AppValidator.builder` for each field's `validator` parameter.
3. Watch the feature's Riverpod controller. Derive a `ValueNotifier<bool>` from the loading state (e.g. `ValueNotifier<bool>(state.isLoading)`) and pass it to `AppFormBuilder` as `isLoading`.
4. Add the `AppFormBuilder` widget to your widget tree, passing the fields, `submitButtonText`, `onSubmit` handler, `isLoading`, and optional `footer`.
5. Clean up any leftover manual controllers, focus nodes, or widget states.

## Verification
- Run static analysis to ensure form and validator imports compile cleanly.
