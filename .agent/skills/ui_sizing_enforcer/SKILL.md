---
name: UI Sizing Enforcer
description: Strictly enforces spacing and radius layout constraints to prevent hardcoded numeric values in Flutter views.
---

# Spacing & Radius Rules

## 📏 Enforced Spacing & Radius Rules
- You are **STRICTLY PROHIBITED** from using raw hardcoded numeric values (e.g., `12.0`, `16.0`, `EdgeInsets.all(8)`) for padding, margin, layout spacing, or border radius in UI widget files.
- All layout spacings, paddings, margins, and SizedBoxes must be retrieved exclusively from `AppSpacing` in [app_spacing.dart](file:///d:/Programming/flutter/flutter_material_enterprise_starter/lib/core/design_system/tokens/app_spacing.dart).
- All border radius configurations must be retrieved exclusively from `AppRadius` in [app_radius.dart](file:///d:/Programming/flutter/flutter_material_enterprise_starter/lib/core/design_system/tokens/app_radius.dart).

## 🔲 Column & Row Spacing Rules
- You **MUST NOT** use manual `SizedBox` widgets (e.g., `SizedBox(height: ...)`, `AppSpacing.verticalSpaceS`) inside a `Column` or `Row` to separate adjacent list children.
- Instead, you **MUST** leverage the native `spacing` parameter available on `Column` and `Row` widgets (e.g., `Column(spacing: AppSpacing.spacing, children: [...])`) for separating children items.
- Only use `SizedBox` for margins, absolute empty space constraints, or outside `Column`/`Row` contexts.

### 📐 Allowed Sizes
Only these standard sizes and their respective constants are allowed:
- **Spacing:** `xs` (4.0), `s` (8.0), `m` (12.0), `l` (16.0), `xl` (24.0), `xxl` (32.0).
- **Semantic Spacing:** `spacingMin` (8.0), `spacing` (16.0), `spacingMax` (24.0).
- **Radius:** `xs` (4.0), `s` (8.0), `m` (12.0), `l` (16.0), `xl` (24.0), `circular` (999.0).

### ❓ Size Verification Protocol
- If a design layout absolutely requires a size or configuration not present in the current `AppSpacing` or `AppRadius` tokens, you **MUST NOT** hardcode it under any circumstances.
- Instead, you **MUST** ask the user directly for confirmation to append the new size/token to the token files before proceeding.
