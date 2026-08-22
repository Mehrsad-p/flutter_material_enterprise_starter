import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/presentation.dart';

/// General Auth Container Shell View that coordinates loading screen overlays and error snacks.
class AuthView extends ConsumerWidget {
  final Widget child;

  const AuthView({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Listen to login error states to show Snackbar notifications
    ref.listen<AsyncValue<void>>(loginControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final message = error.toLocalizedMessage(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        },
      );
    });

    // Listen to signup error states to show Snackbar notifications
    ref.listen<AsyncValue<void>>(signupControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final message = error.toLocalizedMessage(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        },
      );
    });

    // Listen to logout or session error states to show Snackbar notifications
    ref.listen<AsyncValue<dynamic>>(authSessionControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final message = error.toLocalizedMessage(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        },
      );
    });

    return Scaffold(body: child);
  }
}
