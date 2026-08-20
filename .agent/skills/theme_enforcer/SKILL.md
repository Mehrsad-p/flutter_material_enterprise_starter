---

name: theme-enforcer
description: Enforces the application's centralized theming and design system. Use this skill whenever creating, modifying, or refactoring UI code, especially when working with colors, typography, component styling, states, spacing, borders, icons, or other visual properties. Prevents hardcoded visual values and ensures UI consistently uses the project's ThemeData, ColorScheme, TextTheme, ThemeExtensions, and existing design tokens/components.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Theme Enforcer

## Purpose

This skill enforces the application's centralized visual design system.

The application Theme is the **single source of truth for visual styling**.

When implementing or modifying UI, do not invent local colors, typography, or visual tokens when an existing theme value, design token, ThemeExtension, or reusable component can be used.

The goal is to keep the entire application:

* Visually consistent
* Theme-aware
* Dark-mode compatible
* Maintainable
* Customizable from one central location
* Free from duplicated visual constants

---

# When This Skill Must Be Used

Use this skill whenever the task involves:

* Creating a new UI
* Modifying an existing UI
* Refactoring widgets
* Adding colors
* Adding text styles
* Adding buttons
* Adding cards
* Adding dialogs
* Adding inputs
* Adding icons
* Adding borders
* Adding shadows
* Adding hover states
* Adding selected/disabled states
* Adding empty/loading/error states
* Changing typography
* Changing spacing
* Changing border radius
* Creating reusable UI components
* Implementing desktop UI
* Implementing responsive UI

If the task changes how something looks, this skill applies.

---

# 1. Theme First

Before introducing a visual value, inspect the existing theme architecture.

Check for:

1. `ThemeData`
2. `ColorScheme`
3. `TextTheme`
4. `ThemeExtension`
5. Design tokens
6. Existing reusable UI components
7. Existing styling utilities

Do not assume the project only uses `ColorScheme`.

The project's existing theme architecture is the source of truth.

---

# 2. Colors

## Forbidden

Do not introduce arbitrary hardcoded colors into UI code.

Examples:

```dart
Colors.red
Colors.blue
Colors.grey
Colors.grey.shade200
Color(0xFF123456)
Color.fromARGB(...)
Color.fromRGBO(...)
```

unless the value is explicitly required by the component's purpose, such as a color picker or user-selected arbitrary color.

## Required

Prefer:

```dart
final theme = Theme.of(context);
```

then use:

```dart
theme.colorScheme.primary
theme.colorScheme.onPrimary
theme.colorScheme.secondary
theme.colorScheme.onSecondary
theme.colorScheme.surface
theme.colorScheme.onSurface
theme.colorScheme.surfaceContainer
theme.colorScheme.onSurfaceVariant
theme.colorScheme.outline
theme.colorScheme.error
theme.colorScheme.onError
```

Choose the token based on its **semantic meaning**, not its current visual appearance.

Do not think:

> "I need grey."

Think:

> "I need a secondary surface."

Then choose the appropriate theme token.

---

# 3. Semantic Colors

Do not invent semantic colors locally.

For example, do not create:

```dart
Colors.green // success
Colors.orange // warning
Colors.red // error
```

unless the project explicitly defines those values.

First check:

```text
ColorScheme
ThemeExtension
DesignTokens
AppTheme
existing components
```

If the application already defines:

```text
success
warning
info
danger
```

reuse those tokens.

If the entire application genuinely needs a new semantic color, it should normally be added to the centralized theme/design system rather than hardcoded in one widget.

---

# 4. Text Styles

Typography must come from the application's `TextTheme` whenever possible.

Prefer:

```dart
final theme = Theme.of(context);

Text(
  title,
  style: theme.textTheme.titleLarge,
)
```

over:

```dart
Text(
  title,
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

Use semantic styles:

```text
displayLarge
displayMedium
displaySmall

headlineLarge
headlineMedium
headlineSmall

titleLarge
titleMedium
titleSmall

bodyLarge
bodyMedium
bodySmall

labelLarge
labelMedium
labelSmall
```

Do not choose a TextTheme style merely based on its current font size.

Choose based on semantic purpose.

---

# 5. TextStyle Overrides

Small, intentional overrides are allowed.

Example:

```dart
theme.textTheme.titleMedium?.copyWith(
  fontWeight: FontWeight.w600,
)
```

However, do not use `copyWith()` to recreate a completely independent typography system.

Avoid:

```dart
theme.textTheme.bodyMedium?.copyWith(
  fontSize: 17,
  height: 1.8,
  letterSpacing: 2,
  fontWeight: FontWeight.w700,
)
```

when an existing semantic text style already satisfies the requirement.

If a new typography token is genuinely required throughout the application, consider adding it centrally rather than locally.

---

# 6. Font Family

Never hardcode a font family inside an individual widget.

Do not use:

```dart
TextStyle(
  fontFamily: 'Roboto',
)
```

unless explicitly required.

Font configuration belongs to the application theme.

---

# 7. Icons

Icons should inherit their styling from the surrounding component whenever possible.

Avoid:

```dart
Icon(
  Icons.delete,
  color: Colors.red,
)
```

Prefer:

```dart
Icon(
  Icons.delete,
  color: theme.colorScheme.error,
)
```

or allow the parent component's `IconTheme` to provide the color.

---

# 8. Borders

Do not hardcode border colors.

Bad:

```dart
Border.all(
  color: Colors.grey,
)
```

Prefer the appropriate theme token:

```dart
Border.all(
  color: theme.colorScheme.outline,
)
```

Use existing border tokens/components if the project provides them.

---

# 9. Border Radius

Before introducing:

```dart
BorderRadius.circular(...)
```

inspect the existing design system.

If the project provides standard radius tokens, use them.

Do not introduce arbitrary radii throughout different Features.

Avoid creating a new value such as:

```text
13
17
21
23
```

without a design reason.

Consistency is more important than arbitrary precision.

---

# 10. Spacing

Before adding arbitrary spacing values, inspect existing spacing tokens.

Check for things such as:

```text
AppSpacing
Spacing
DesignTokens
Gaps
Insets
```

If they exist, reuse them.

If no spacing system exists, follow the surrounding project's established spacing conventions.

Do not create a new spacing system inside a single Feature.

---

# 11. Elevation and Shadows

Prefer Material elevation and existing component styling.

Do not randomly introduce custom `BoxShadow` values.

Before writing:

```dart
BoxShadow(
  blurRadius: 20,
  spreadRadius: 5,
)
```

check whether an existing component or design token already provides the required visual hierarchy.

---

# 12. Opacity

Do not use opacity to compensate for an incorrect color choice.

Avoid arbitrary:

```dart
Colors.black.withValues(alpha: 0.5)
```

First select the correct Theme color.

If transparency is genuinely required, derive it from a Theme color:

```dart
theme.colorScheme.onSurface.withValues(alpha: 0.5)
```

Use the Flutter API version supported by the project.

---

# 13. Component States

Theme-aware styling must apply to all UI states:

* Default
* Hover
* Focus
* Pressed
* Selected
* Disabled
* Error
* Loading
* Dragged

Do not introduce arbitrary state colors.

Prefer Material components and the application's theme configuration.

---

# 14. Existing Components

Before manually styling a component, search for an existing reusable component.

Examples:

```text
AppButton
AppTextField
AppCard
AppDialog
AppChip
AppIconButton
AppDropdown
AppCheckbox
```

If an existing component already implements the required design, use it.

Do not create another visually similar component with slightly different styling.

---

# 15. Theme Extensions

If the application uses `ThemeExtension`, inspect it before introducing custom styling.

Example:

```dart
final theme = Theme.of(context);

final customTheme =
    theme.extension<AppThemeExtension>();
```

Reuse existing semantic properties.

Do not duplicate ThemeExtension values locally.

---

# 16. Light / Dark Theme

Every UI change must remain valid across all supported themes.

Never assume:

```text
white = background
black = text
grey = border
```

Always use Theme-provided values.

A UI implementation that only looks correct in Light Mode is considered incomplete.

---

# 17. Theme Access

When `BuildContext` is available:

```dart
final theme = Theme.of(context);
```

Prefer storing the theme locally inside the build method rather than repeatedly calling:

```dart
Theme.of(context)
```

throughout the same method.

Example:

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return Container(
    color: theme.colorScheme.surface,
    child: Text(
      title,
      style: theme.textTheme.titleMedium,
    ),
  );
}
```

---

# 18. Do Not Create Local ThemeData

Do not create a new `ThemeData` inside a Feature or widget to solve a local styling problem.

Avoid:

```dart
Theme(
  data: ThemeData(...),
  child: ...
)
```

unless the task explicitly requires a deliberate local theme override.

The application-level Theme should remain the source of truth.

---

# 19. Centralize Global Design Changes

If a visual requirement applies across multiple parts of the application, do not implement it independently in each widget.

For example, if all cards need a different radius:

Do not change:

```text
Feature A → radius 12
Feature B → radius 12
Feature C → radius 12
```

individually.

First determine whether the value belongs in:

```text
ThemeData
ThemeExtension
Design Tokens
Reusable Component
```

Centralize it when appropriate.

---

# 20. Existing Architecture Has Priority

Do not invent a new design-system architecture.

Before introducing something like:

```text
AppColors
AppTextStyles
AppSpacing
AppRadius
```

check whether the project already has equivalent concepts.

If they already exist, use them.

If the project intentionally relies entirely on Material `ThemeData`, do not introduce a parallel design-token system.

---

# 21. Exceptions

Hardcoded visual values are allowed only when they are inherently part of the content or functionality and cannot reasonably come from the application theme.

Examples may include:

* User-selected colors
* Color picker values
* Data visualization colors explicitly defined by product requirements
* Brand colors when explicitly required and centrally documented
* Image/asset-specific colors
* Third-party library APIs requiring literal values

Even in these cases, first check whether the project already provides a suitable token.

Do not use exceptions as a workaround for the rules.

---

# 22. When a New Theme Token Is Required

If a new visual concept is genuinely required across multiple components:

1. Search existing Theme values.
2. Search ThemeExtensions.
3. Search design tokens.
4. Search reusable components.
5. Confirm that the value cannot be represented by an existing token.
6. Add the new token to the centralized theme architecture.
7. Update all relevant theme variants.
8. Use the new token from UI code.

Do not introduce the new token directly inside a Feature widget.

---

# 23. Minimal Overrides

Local styling is acceptable when it is:

* Intentional
* Small
* Semantically justified
* Not already represented by the Theme
* Not likely to be reused elsewhere

Avoid unnecessary customization.

The goal is not to make every widget completely dependent on Theme values; the goal is to prevent duplicated and arbitrary design decisions.

---

# 24. Flutter / Material vs Fluent UI

If the project uses multiple UI frameworks, identify which design system the current component belongs to.

For Material components:

```text
ThemeData
ColorScheme
TextTheme
```

should be the primary source.

For Fluent UI components, follow the project's existing Fluent theme/design system.

Do not blindly apply Material `ColorScheme` values to a Fluent component if the project already has a Fluent-specific theme.

Consistency with the existing architecture takes priority.

---

# 25. Verification

After implementing or modifying UI, verify:

* No unnecessary hardcoded colors
* No unnecessary hardcoded TextStyles
* Existing Theme was inspected
* Existing ColorScheme was inspected
* Existing TextTheme was inspected
* Existing ThemeExtensions were inspected
* Existing design tokens were inspected
* Existing reusable components were inspected
* Light Theme compatibility
* Dark Theme compatibility
* Hover/focus/disabled states
* No duplicated design tokens
* No unnecessary local ThemeData
* No parallel design system introduced

---

# Decision Process

For every visual value, follow:

```text
Need a visual value
        ↓
Search existing component
        ↓
Search design tokens
        ↓
Search ThemeExtension
        ↓
Search ColorScheme / TextTheme
        ↓
Can an existing value be reused?
        ↓
YES ───────────────→ REUSE
        │
        NO
        ↓
Is this a globally reusable design concept?
        ↓
YES ───────────────→ ADD CENTRALLY
        │
        NO
        ↓
Use a minimal local override
```

---

# Golden Rules

1. **Theme before hardcode.**
2. **Reuse before create.**
3. **Semantic token before visual value.**
4. **Centralize reusable design decisions.**
5. **Never create a parallel design system without explicit approval.**
6. **Every UI change must support the application's themes.**
7. **A widget should describe what it needs, not what color it should look like.**

The UI should depend on **semantic design tokens**, not arbitrary visual values.
