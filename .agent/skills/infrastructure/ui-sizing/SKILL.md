---
name: theme-enforcer
description: Enforces the application's centralized theming, design system, layout spacing, and radius constraints. Use this skill whenever creating, modifying, or refactoring UI code, especially when working with colors, typography, component styling, layout spacing, borders, or other visual properties. Prevents hardcoded visual values/numbers and ensures UI consistently uses the project's ThemeData, ColorScheme, TextTheme, AppSpacing, and AppRadius.
---

# UI Sizing & Theme Enforcer

## Purpose
This skill enforces the application's centralized visual design system and layout constraints. The application Theme is the **single source of truth for visual styling**. When implementing or modifying UI, do not invent local colors, typography, spacing, or visual tokens.

## Scope
All UI widget files, presentation pages, and custom views.

---

## 📏 1. Enforced Spacing & Radius Rules

- You are **STRICTLY PROHIBITED** from using raw hardcoded numeric values (e.g., `12.0`, `16.0`, `EdgeInsets.all(8)`) for padding, margin, layout spacing, or border radius in UI widget files.
- All layout spacings, paddings, margins, and SizedBoxes must be retrieved exclusively from `AppSpacing` in [app_spacing.dart](file:///d:/Programming/flutter/flutter_material_enterprise_starter/lib/core/design_system/tokens/app_spacing.dart).
- All border radius configurations must be retrieved exclusively from `AppRadius` in [app_radius.dart](file:///d:/Programming/flutter/flutter_material_enterprise_starter/lib/core/design_system/tokens/app_radius.dart).

### 📐 Allowed Sizes
Only these standard sizes and their respective constants are allowed:
- **Spacing:** `xs` (4.0), `s` (8.0), `m` (12.0), `l` (16.0), `xl` (24.0), `xxl` (32.0), `spacingMin` (8.0), `spacing` (16.0), `spacingMax` (24.0).
- **Radius:** `xs` (4.0), `s` (8.0), `m` (12.0), `l` (16.0), `xl` (24.0), `circular` (999.0).

---

## 🔲 2. Column & Row Spacing Rules

- You **MUST NOT** use manual `SizedBox` widgets (e.g., `SizedBox(height: ...)`, `AppSpacing.verticalSpaceS`) inside a `Column` or `Row` to separate adjacent list children.
- Instead, you **MUST** leverage the native `spacing` parameter available on `Column` and `Row` widgets (e.g., `Column(spacing: AppSpacing.spacing, children: [...])`) for separating children items.
- Only use `SizedBox` for margins, absolute empty space constraints, or outside `Column`/`Row` contexts.

---

## 🎨 3. Colors

- Do not introduce arbitrary hardcoded colors into UI code (e.g., `Colors.red`, `Colors.grey`, `Color(0xFF123456)`).
- Prefer retrieving colors from `Theme.of(context).colorScheme` (e.g., `primary`, `onPrimary`, `surface`, `onSurface`, `surfaceContainer`, `outline`, `error`).
- Choose tokens based on their **semantic meaning**, not their current visual appearance (e.g., "I need a secondary surface", not "I need grey").
- Do not invent semantic colors locally (e.g., success, warning, danger). Reuse established theme colors.

---

## 🔤 4. Text Styles & Font Family

- Typography must come from the application's `TextTheme` (e.g., `titleLarge`, `bodyMedium`, `labelSmall`).
- Small, intentional overrides are allowed using `copyWith()` (e.g., `theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)`), but avoid recreating independent typography systems.
- Never hardcode a font family inside an individual widget (e.g., `TextStyle(fontFamily: 'Roboto')`). Font configuration belongs strictly to the centralized application theme.

---

## 🛍️ 5. Borders, Elevations, and Shadows

- Do not hardcode border colors. Use the appropriate theme token: `Border.all(color: theme.colorScheme.outline)`.
- Prefer Material elevation and existing card/component layouts. Do not randomly introduce custom `BoxShadow` values.
- Do not use opacity to compensate for an incorrect color choice. If transparency is required, derive it from a Theme color (e.g., `theme.colorScheme.onSurface.withValues(alpha: 0.5)`).

---

## 🌍 6. Theme Compatibility & Component States

- Every UI change must remain valid and legible across all supported themes (Light Mode, Dark Mode, High Contrast). Never assume white is the background or black is the text.
- Theme-aware styling must apply to all UI states (Default, Hover, Pressed, Selected, Disabled, Error, Loading).
- Before manually styling a custom component, search for an existing reusable component in `core/design_system/components/` (e.g., `AppButton`, `AppTextField`).

---

## 🚫 Forbidden

- **UI Code** ❌ MUST NOT contain hardcoded numeric layout dimensions (e.g. `EdgeInsets.all(12)` or `BorderRadius.circular(16)`).
- **UI Code** ❌ MUST NOT use manual `SizedBox` for child-spacing inside Columns/Rows.
- **UI Code** ❌ MUST NOT contain hardcoded visual values or colors.

---

## 🧪 Verification

- Verify that no raw doubles, numeric edge insets, or hardcoded hex colors are present in UI widget files.
- Ensure layouts render correctly in both Light and Dark mode.
