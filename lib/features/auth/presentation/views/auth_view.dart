import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/states/auth_state.dart';

/// General Auth Container Shell View that coordinates loading screen overlays and error snacks.
class AuthView extends ConsumerWidget {
  final Widget child;

  const AuthView({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(authControllerProvider);

    // Listen to error states to show Snackbar notifications
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(body: child);
  }
}
