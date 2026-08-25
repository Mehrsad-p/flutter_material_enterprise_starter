---
name: Riverpod Technology Enforcer
description: Regulates the usage of Riverpod state management, AsyncNotifier lifecycles, and generated provider wiring.
---

# Riverpod Technology Enforcer

## Purpose
Enforces standard Riverpod annotations, `AsyncNotifier` lifecycle purity, co-located feature/state directory structure, fine-grained controller architecture, computed providers, reactive UI side-effects, and provider testing guidelines.

## Scope
All provider and controller files under `lib/` and unit test suites under `test/`.

## Dependencies
### Required
- `_core/naming`
- `_core/architecture`
- `layers/presentation`

---

## Strict Rules & Invariants

1. **Co-location of Controller & State**:
   - Standalone global `presentation/states/` flat directories are strictly forbidden.
   - Controllers and their corresponding Freezed state models MUST be co-located in dedicated sub-folders.
   - To avoid visual clutter caused by generated code, all state files and their generated files (`.freezed.dart`, `.g.dart`) MUST reside in a dedicated nested `state/` subdirectory inside that specific controller's folder. For example: `presentation/controllers/login/login_controller.dart` and `presentation/controllers/login/state/login_state.dart`.

2. **Lifecycle Purity**:
   - Synchronous `build()` methods MUST remain pure. `Future.microtask` or side-effects inside `build()` to trigger asynchronous initialization are **strictly forbidden**.
   - Async bootstrap controllers MUST use `AsyncNotifier<T>` with an `async build()` method returning `Future<T>`.

3. **Fine-Grained & Multi-Controller Subfolders**:
   - Enforce 1:1 Controller-to-State mapping. Monolithic controllers managing unrelated states are prohibited.
   - For multi-controller features, group controllers inside dedicated subdirectories: `lib/features/<feature>/presentation/controllers/<sub_domain>/`.

4. **Computed & Aggregated Providers**:
   - Combine multi-controller states or form validations using pure functional providers with fine-grained selectors (`ref.watch(provider.select(...))`).

5. **Zero BuildContext in Controllers & Reactive Side-Effects**:
   - Controllers act as pure ViewModels without `BuildContext` or navigation triggers.
   - UI side-effects (Snackbars, Dialogs, Navigation) are observed reactively in presentation views using `ref.listen`.

6. **Decoupled DI Provider Location & Optional UseCases**:
   - Data layer providers (DataSources, Repository implementations) live in `data/`.
   - Controllers watch abstract domain interfaces (e.g., `AuthRepository` or optional UseCases), never concrete implementation classes (`AuthRepositoryImpl`).
   - UseCases are completely **optional**. For standard CRUD or API forwarding operations, controllers should call abstract Domain Repository interfaces directly to avoid boilerplate. UseCases should only be introduced when there is complex client-side orchestration, multi-step actions, offline synchronization, or logic shared across multiple controllers.

---

## Production Code Templates (Riverpod 2.6+)

### 1. Pure AsyncNotifier Template (`auth_session_controller.dart`)
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/providers/auth_usecases_provider.dart';

part 'auth_session_controller.g.dart';

@riverpod
class AuthSessionController extends _$AuthSessionController {
  @override
  Future<UserEntity?> build() async {
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

    state = await AsyncValue.guard(() async {
      await result.when(
        success: (_) => null,
        error: (failure) => throw failure,
      );
      return null;
    });
  }
}
```

### 2. Multi-Controller & Co-Location Folder Structure (Nested state/)

For a complex feature such as login/auth, controllers and their states must be grouped in a sub-folder with states nested under `state/`:
```
lib/features/auth/presentation/controllers/login/
├── login_controller.dart
├── login_computed_providers.dart
└── state/
    ├── login_state.dart
    ├── login_state.freezed.dart
    └── login_state.g.dart
```

#### A. Freezed State Model (`state/login_state.dart`)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'login_state.freezed.dart';
part 'login_state.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    required bool isEmailValid,
    required bool isPasswordValid,
    required AsyncValue<void> submissionStatus,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        isEmailValid: false,
        isPasswordValid: false,
        submissionStatus: AsyncValue.data(null),
      );
}
```

#### B. Controller (`login_controller.dart`)
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/login/state/login_state.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/providers/auth_usecases_provider.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth/auth_session_controller.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    // Pure build method: returns synchronous initial state
    return LoginState.initial();
  }

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      isEmailValid: email.contains('@') && email.isNotEmpty,
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      isPasswordValid: password.length >= 6,
    );
  }

  Future<void> submit() async {
    if (!state.isEmailValid || !state.isPasswordValid) return;

    state = state.copyWith(submissionStatus: const AsyncValue.loading());
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(state.email, state.password);

    result.when(
      success: (user) {
        ref.read(authSessionControllerProvider.notifier).updateSession(user);
        state = state.copyWith(submissionStatus: const AsyncValue.data(null));
      },
      error: (failure) {
        state = state.copyWith(
          submissionStatus: AsyncValue.error(failure, StackTrace.current),
        );
      },
    );
  }
}
```

#### C. Computed Provider (`login_computed_providers.dart`)
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/login/login_controller.dart';

part 'login_computed_providers.g.dart';

@riverpod
bool isLoginFormValid(IsLoginFormValidRef ref) {
  final isEmailValid = ref.watch(
    loginControllerProvider.select((state) => state.isEmailValid),
  );
  final isPasswordValid = ref.watch(
    loginControllerProvider.select((state) => state.isPasswordValid),
  );

  return isEmailValid && isPasswordValid;
}
```

### 3. UI Side-Effect Observation via `ref.listen`

In View Widget (`login_view.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/login/login_controller.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure_mapper.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe submission status for side-effects reactively
    ref.listen<AsyncValue<void>>(
      loginControllerProvider.select((s) => s.submissionStatus),
      (previous, next) {
        next.whenOrNull(
          error: (error, _) {
            final message = error.toLocalizedMessage(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          data: (_) {
            context.go('/home');
          },
        );
      },
    );

    final isSubmitting = ref.watch(
      loginControllerProvider.select((s) => s.submissionStatus.isLoading),
    );
    final isValid = ref.watch(isLoginFormValidProvider);

    return Scaffold(
      body: Center(
        child: isSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: isValid
                    ? () => ref.read(loginControllerProvider.notifier).submit()
                    : null,
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
import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_material_enterprise_starter/features/auth/domain/usecases/restore_session_usecase.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth/auth_session_controller.dart';

class MockRestoreSessionUseCase implements RestoreSessionUseCase {
  final Result<UserEntity?> resultToReturn;
  MockRestoreSessionUseCase(this.resultToReturn);

  @override
  Future<Result<UserEntity?>> execute() async => resultToReturn;
}

void main() {
  test('AuthSessionController initializes with restored user session', () async {
    const testUser = UserEntity(id: 'usr_1', email: 'test@enterprise.com');
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
- **Co-location Violation** ❌ MUST NOT place states in a flat global `presentation/states/` directory or directly in the controller folder (must use nested `state/` subdirectory).
- **Synchronous build() with Future.microtask** ❌ MUST NOT trigger async initialization via microtasks inside a sync build(). Use `AsyncNotifier`.
- **BuildContext in Controllers** ❌ MUST NOT pass `BuildContext` into Notifier methods or trigger dialogs/routing inside controllers.
- **Monolithic Controllers** ❌ MUST NOT combine multiple unrelated sub-domain states into a single controller class.
- **Direct Data Layer Imports** ❌ Presentation Notifiers MUST NOT import `data/datasources/` or concrete implementation repositories.

---

## Workflow & Verification
1. Run `flutter pub run build_runner build --delete-conflicting-outputs`.
2. Run `flutter analyze` to ensure strict layer boundary adherence.
3. Run `flutter test` to verify pure `ProviderContainer` unit tests pass.
