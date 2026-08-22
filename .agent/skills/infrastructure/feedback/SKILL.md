---
name: Platform-Agnostic Feedback Enforcer
description: Regulates the usage of the global feedback system, error notifications, toasts, and dialogs across presentation and controller layers without leakage of BuildContext or UI packages into logic.
---

# Platform-Agnostic Feedback Enforcer

## Purpose
Regulates the usage of the enterprise platform-agnostic feedback and error notification system. Enforces strict decoupling between notification dispatching (business logic) and notification rendering (UI delegates).

## Scope
All Riverpod controllers, notifiers, repositories, views, and widgets located under `lib/`.

## Dependencies
### Required
- `_core/architecture`
- `_core/naming`
- `layers/presentation`
- `technologies/riverpod`
- `infrastructure/localization`

---

## Strict Rules & Invariants

1. **Zero BuildContext in Business Logic & Controllers**:
   - Controllers, Notifiers, and ViewModels MUST NOT receive or reference `BuildContext`.
   - Direct calls to `ScaffoldMessenger.of(context)`, `showDialog()`, or `MaterialBanner` inside controllers are **strictly forbidden**.

2. **Domain Failure Dispatching (`showFailure`)**:
   - When a UseCase or Repository operation returns a `Result.error(failure)`, controllers dispatch the error via `AppFeedbackController`:
     ```dart
     ref.read(appFeedbackControllerProvider.notifier).showFailure(failure);
     ```
   - This wraps the pure `Failure` model in an `AppNotification` of type `error` without triggering immediate UI side-effects.

3. **Custom Notification Dispatching (`showNotification`)**:
   - For success toasts, info messages, warnings, or action alerts, construct an `AppNotification` and dispatch it via the controller:
     ```dart
     ref.read(appFeedbackControllerProvider.notifier).showNotification(
       AppNotification(
         id: DateTime.now().microsecondsSinceEpoch.toString(),
         type: AppNotificationType.success,
         message: 'Operation completed successfully',
         actionLabel: 'Undo',
         onAction: () => ref.read(myControllerProvider.notifier).undo(),
       ),
     );
     ```

4. **Decoupled UI Rendering & Localization Boundary**:
   - UI rendering is handled reactively by `GlobalFeedbackListener` wrapping the app router.
   - Translation of pure `Failure` models to localized UI strings occurs exclusively in the UI layer via `FailureMapperExtension.toLocalizedMessage(context)`.

---

## Production Code Templates

### 1. Handling Failures in Controllers (`login_controller.dart`)
```dart
import 'package:flutter_material_enterprise_starter/core/feedback/feedback.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/providers/auth_usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(email, password);

    result.when(
      success: (user) {
        state = const AsyncValue.data(null);
        // Dispatch success feedback globally
        ref.read(appFeedbackControllerProvider.notifier).showNotification(
              AppNotification(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                type: AppNotificationType.success,
                message: 'Welcome back!',
              ),
            );
      },
      error: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        // Dispatch failure to global feedback queue
        ref.read(appFeedbackControllerProvider.notifier).showFailure(failure);
      },
    );
  }
}
```

### 2. Dispatching Interactive Notifications with Action Callbacks
```dart
void triggerBackup(WidgetRef ref) {
  ref.read(appFeedbackControllerProvider.notifier).showNotification(
    AppNotification(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: AppNotificationType.info,
      message: 'Cloud backup initiated in background',
      actionLabel: 'View Details',
      onAction: () {
        // Pure action callback executed when user clicks the notification button
        ref.read(backupControllerProvider.notifier).openBackupDetails();
      },
    ),
  );
}
```

---

## Forbidden Practices ❌
- **BuildContext in Controllers** ❌ Controller methods MUST NOT take `BuildContext context` as a parameter.
- **Direct ScaffoldMessenger Calls in Controllers** ❌ Controllers MUST NOT call `ScaffoldMessenger.of(context).showSnackBar(...)`.
- **Direct showDialog Calls in Controllers** ❌ Controllers MUST NOT invoke `showDialog()` or `showModalBottomSheet()`.
- **Localization in Domain/Controller** ❌ MUST NOT call `.tr()` or import `easy_localization` inside controllers or domain entities.
- **UI Package Imports in Entities** ❌ `AppNotification` MUST NOT import `package:flutter/material.dart`.

---

## Workflow & Verification
1. Dispatch all errors and messages via `ref.read(appFeedbackControllerProvider.notifier)`.
2. Ensure `GlobalFeedbackListener` is present in `App` router builder.
3. Run `flutter analyze` to verify clean layer separation.
