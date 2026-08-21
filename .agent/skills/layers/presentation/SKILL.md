---
name: Presentation Layer Enforcer
description: Rules for views, widgets, controllers, presentation states, and localization error mapping.
---

# Presentation Layer Enforcer

## Purpose
Regulates the structure, rendering logic, viewmodel integrations, localization boundaries, and reactive side-effect handling within the UI presentation layer.

## Scope
All files under `lib/features/*/presentation/` and `lib/core/errors/failure_mapper.dart`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `technologies/freezed`
- `technologies/riverpod`
- `infrastructure/ui-sizing`
- `infrastructure/localization`

---

## Rules & Standards

1. **View Scaffold**:
   - Main views (`[feature_name]_view.dart`) MUST be `ConsumerWidget` or `ConsumerStatefulWidget`.
   - Views remain minimal and clean, delegating layout to sub-widgets and state to Notifiers.

2. **ViewModel (Controllers) & Zero BuildContext**:
   - Controllers act as pure ViewModels. They inherit from `@riverpod` `Notifier` or `AsyncNotifier`.
   - Synchronous `build()` MUST remain pure. Async initialization MUST use `AsyncNotifier` with `async build()`. `Future.microtask` in `build()` is **forbidden**.
   - Controllers MUST NOT receive or reference `BuildContext`, show Snackbars/Dialogs, or trigger direct routing calls.

3. **Fine-Grained Multi-Controller Structure**:
   - 1:1 Controller-to-State mapping.
   - Organize complex feature controllers inside sub-directories: `lib/features/<feature>/presentation/controllers/<sub_domain>/`.

4. **Localization Boundary & Failure Translation**:
   - Domain `Failure` models (`lib/core/errors/failure.dart`) contain pure data and error codes (zero `.tr()` or UI imports).
   - Translation to localized UI strings occurs exclusively via a Presentation-layer `FailureMapperExtension`.

5. **Reactive Side-Effects**:
   - UI side-effects (Navigation, Snackbars, Toasts) are handled reactively inside the View `build()` using `ref.listen<AsyncValue<T>>`.

---

## Production Code Templates

### 1. Presentation Failure Mapper Extension (`lib/core/errors/failure_mapper.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

extension FailureMapperExtension on Object {
  /// Maps a pure data-driven [Failure] or Exception to a localized user-facing String.
  String toLocalizedMessage(BuildContext context) {
    final error = this;
    if (error is Failure) {
      return error.when(
        server: (customMessage, code, details) {
          if (customMessage == 'auth/invalid-credentials') {
            return LocaleKeys.auth_invalid_credentials.tr();
          } else if (customMessage == 'auth/email-already-in-use') {
            return LocaleKeys.auth_email_already_in_use.tr();
          }
          return customMessage.isNotEmpty
              ? customMessage
              : LocaleKeys.error_server.tr();
        },
        cache: (customMessage) =>
            customMessage ?? LocaleKeys.error_cache.tr(),
      );
    }
    return LocaleKeys.error_server.tr();
  }
}
```

### 2. View Side-Effect Handling (`auth_login_view.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/login/login_controller.dart';

class AuthLoginView extends ConsumerWidget {
  const AuthLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reactive side-effect listener
    ref.listen<AsyncValue<void>>(
      loginControllerProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toLocalizedMessage(context))),
            );
          },
          data: (_) {
            context.go('/dashboard');
          },
        );
      },
    );

    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: loginState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                onPressed: () => ref.read(loginControllerProvider.notifier).login('user@test.com', 'pass123'),
                child: const Text('Sign In'),
              ),
            ),
    );
  }
}
```

---

## Forbidden Practices ❌
- **Localization in Domain/Failure** ❌ `lib/core/errors/failure.dart` MUST NOT import `easy_localization` or `.tr()`.
- **BuildContext in Controllers** ❌ Controller methods MUST NOT take `BuildContext context` as a parameter.
- **Future.microtask in build()** ❌ Controllers MUST NOT run `Future.microtask()` inside `build()`.
- **Monolithic Controllers** ❌ Controllers MUST NOT manage multi-purpose unrelated states in one file.

---

## Workflow & Verification
1. Place failure mapping extensions under presentation/core layers.
2. Verify presentation controllers contain zero UI/localization packages.
3. Run `flutter analyze` to ensure zero compilation or architecture violations.

