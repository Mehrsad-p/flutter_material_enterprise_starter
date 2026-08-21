---
name: Riverpod Technology Enforcer
description: Regulates the usage of Riverpod state management, AsyncNotifier lifecycles, and generated provider wiring.
---

# Riverpod Technology Enforcer

## Purpose
Enforces standard Riverpod annotations, `AsyncNotifier` lifecycle purity, fine-grained controller architecture, computed providers, reactive UI side-effects, and provider testing guidelines.

## Scope
All provider and controller files under `lib/` and unit test suites under `test/`.

## Dependencies
### Required
- `_core/naming`
- `_core/architecture`
- `layers/presentation`

---

## Strict Rules & Invariants

1. **Lifecycle Purity**:
   - Synchronous `build()` methods MUST remain pure. `Future.microtask` or side-effects inside `build()` to trigger asynchronous initialization are **strictly forbidden**.
   - Async bootstrap controllers MUST use `AsyncNotifier<T>` with an `async build()` method returning `FutureOr<T>`.

2. **Fine-Grained & Multi-Controller Subfolders**:
   - Enforce 1:1 Controller-to-State mapping. Monolithic controllers managing unrelated states are prohibited.
   - For multi-controller features, group controllers inside dedicated subdirectories: `lib/features/<feature>/presentation/controllers/<sub_domain>/`.

3. **Computed & Aggregated Providers**:
   - Combine multi-controller states or form validations using pure functional providers with fine-grained selectors (`ref.watch(provider.select(...))`).

4. **Zero BuildContext in Controllers & Reactive Side-Effects**:
   - Controllers act as pure ViewModels without `BuildContext` or navigation triggers.
   - UI side-effects (Snackbars, Dialogs, Navigation) are observed reactively in presentation views using `ref.listen`.

5. **Decoupled DI Provider Location**:
   - Data layer providers (DataSources, Repository implementations) live in `data/`.
   - Controllers watch abstract domain interfaces (e.g. `AuthRepository`), never concrete implementation classes (`AuthRepositoryImpl`).

---

## Production Code Templates (Riverpod 2.6+)

### 1. Pure AsyncNotifier Template (`auth_session_controller.dart`)
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/usecases/restore_session_usecase.dart';

part 'auth_session_controller.g.dart';

@riverpod
class AuthSessionController extends _$AuthSessionController {
  @override
  FutureOr<User?> build() async {
    // Pure async initialization: return initial value or throw
    final useCase = ref.watch(restoreSessionUseCaseProvider);
    final result = await useCase.execute();

    return result.when(
      success: (user) => user,
      error: (_) => null,
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(logoutUseCaseProvider);
    final result = await useCase.execute();

    state = result.when(
      success: (_) => const AsyncValue.data(null),
      error: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }
}
```

### 2. Multi-Controller & Computed Provider Template

Directory structure:
```
lib/features/auth/presentation/controllers/login/
├── login_form_controller.dart
├── login_form_state.dart
└── login_computed_providers.dart
```

Computed Provider (`login_computed_providers.dart`):
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/login/login_form_controller.dart';

part 'login_computed_providers.g.dart';

@riverpod
bool isLoginFormValid(IsLoginFormValidRef ref) {
  final isEmailValid = ref.watch(
    loginFormControllerProvider.select((state) => state.isEmailValid),
  );
  final isPasswordValid = ref.watch(
    loginFormControllerProvider.select((state) => state.isPasswordValid),
  );

  return isEmailValid && isPasswordValid;
}
```

### 3. UI Side-Effect Observation via `ref.listen`

In View Widget (`login_view.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/login/login_form_controller.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure_mapper.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe controller state for side-effects reactively
    ref.listen<AsyncValue<void>>(
      loginFormControllerProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, _) {
            final message = error.toLocalizedMessage(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          data: (_) {
            // Navigate to home on success
            context.go('/home');
          },
        );
      },
    );

    final isLoading = ref.watch(
      loginFormControllerProvider.select((s) => s.isLoading),
    );

    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => ref.read(loginFormControllerProvider.notifier).submit(),
                child: const Text('Login'),
              ),
      ),
    );
  }
}
```

### 4. Unit Testing Template (Pure `ProviderContainer`)

Unit Test File (`test/features/auth/presentation/controllers/auth_session_controller_test.dart`):
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/usecases/restore_session_usecase.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth_session_controller.dart';

class MockRestoreSessionUseCase implements RestoreSessionUseCase {
  final Result<User?> resultToReturn;
  MockRestoreSessionUseCase(this.resultToReturn);

  @override
  Future<Result<User?>> execute() async => resultToReturn;
}

void main() {
  test('AuthSessionController initializes with restored user session', () async {
    const testUser = User(id: 'usr_1', email: 'test@enterprise.com');
    final mockUseCase = MockRestoreSessionUseCase(const Result.success(testUser));

    final container = ProviderContainer(
      overrides: [
        restoreSessionUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
    addTearDown(container.dispose);

    // Read async value
    final asyncState = await container.read(authSessionControllerProvider.future);

    expect(asyncState, equals(testUser));
  });
}
```

---

## Forbidden Practices ❌
- **Synchronous build() with Future.microtask** ❌ MUST NOT trigger async initialization via microtasks. Use `AsyncNotifier`.
- **BuildContext in Controllers** ❌ MUST NOT pass `BuildContext` into Notifier methods or trigger dialogs/routing inside controllers.
- **Monolithic Controllers** ❌ MUST NOT combine multiple unrelated sub-domain states into a single controller class.
- **Direct Data Layer Imports** ❌ Presentation Notifiers MUST NOT import `data/datasources/` or concrete implementation repositories.

---

## Workflow & Verification
1. Run `flutter pub run build_runner build --delete-conflicting-outputs`.
2. Run `flutter analyze` to ensure strict layer boundary adherence.
3. Run `flutter test` to verify pure `ProviderContainer` unit tests pass.

