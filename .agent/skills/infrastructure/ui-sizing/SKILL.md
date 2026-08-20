---
name: UI Sizing Enforcer
description: Strictly enforces spacing and radius layout constraints to prevent hardcoded numeric values in Flutter views.
---

# UI Sizing Enforcer

## Purpose
Enforces design token boundaries to keep the user interface consistent and prevent developers/agents from using arbitrary numeric sizes.

## Scope
All UI widget files.

## Dependencies
### Required
None.

## Rules
1. **Design Tokens Only**:
   - All paddings, margins, container heights/widths, and border radii must use constants from `AppSpacing` or `AppRadius`.
2. **Column/Row Spacing**:
   - MUST NOT use manual `SizedBox(height: ...)` or `AppSpacing.verticalSpaceS` inside a `Column` or `Row` to separate adjacent list children.
   - Use the native `spacing` parameter: `Column(spacing: AppSpacing.spacing, children: [...])`.
3. **Allowed Sizing Constants**:
   - **Spacing**: `xs` (4.0), `s` (8.0), `m` (12.0), `l` (16.0), `xl` (24.0), `xxl` (32.0), `spacingMin` (8.0), `spacing` (16.0), `spacingMax` (24.0).
   - **Radius**: `xs` (4.0), `s` (8.0), `m` (12.0), `l` (16.0), `xl` (24.0), `circular` (999.0).

## Forbidden
- **UI Code** ❌ MUST NOT contain hardcoded numeric layout dimensions (e.g. `EdgeInsets.all(12)` or `BorderRadius.circular(16)`).

## Workflow
1. Use `AppSpacing` or `AppRadius` tokens when defining layouts.
2. Use native `spacing` parameters in Columns/Rows.

## Verification
- Inspect files to verify that no raw doubles or numeric edge insets are present.
