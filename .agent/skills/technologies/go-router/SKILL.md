---
name: GoRouter Technology Enforcer
description: Regulates the usage of GoRouter, page transitions, and route path declarations.
---

# GoRouter Technology Enforcer

## Purpose
Enforces correct routing path configuration, route keys, custom page transitions, and router integration rules.

## Scope
Router configuration files under `lib/app/router/`.

## Dependencies
### Required
- `_core/naming`

## Rules
1. **Route Path Keys**:
   - All route path strings must be defined as `static const String` constants inside `lib/app/router/app_routes.dart` (e.g. `static const String home = '/home';`).
2. **Router Registration**:
   - New feature pages must be registered inside the GoRouter routes list in `lib/app/router/app_router.dart`.
3. **Custom Page Transitions**:
   - Employs transitions from `AppPageTransition` (e.g. `slideHorizontal`, `fade`, `fadeThrough`).
   - RTL/LTR page transitions must slide appropriately based on target languages.
4. **Global Reactive Redirection**:
   - Session checks, role-based route access, and login/logout redirections must be managed reactively using GoRouter's `redirect` callback combined with a `refreshListenable` (e.g., listening to the authentication controller). Avoid executing manual redirects inside views like splash/launcher.
5. **ShellRoute & Nested Navigation**:
   - Features sharing a common structure (like settings with a shared layout, or auth screens with a unified scaffold, loader overlay, and snackbar listener) must be implemented using GoRouter's `ShellRoute`.
   - The Shell widget (e.g. `AuthView` or `SettingsPage`) must take a `Widget child` parameter and render it in its build tree, keeping nested child screens completely decoupled.
   - Toggling screens inside a shell must navigate via GoRouter paths (e.g. `context.go('/register')`) instead of updating local widget state variables.

## Forbidden
- **UI Pages** ❌ MUST NOT use hardcoded route path strings; they must use the constants from `AppRoutes`.
- **UI Pages** ❌ MUST NOT use legacy `Navigator.push` or `Navigator.pop` for features registered in the router; use `context.go()` or `context.push()` instead.

## Workflow
1. Declare the static route key in `app_routes.dart`.
2. Register the path in `app_router.dart`, mapping to the page widget using the correct `AppPageTransition`.

## Verification
- Run static analysis to check that all route routes are correctly referenced.
