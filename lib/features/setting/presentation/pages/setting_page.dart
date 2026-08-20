import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Shell scaffold for the Settings section.
/// Wraps all settings sub-pages with a shared AppBar and Scaffold,
/// and renders the active child route as the body.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key, required this.child});

  /// The currently active sub-page body (injected by GoRouter ShellRoute).
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.settings_title.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: AppSpacing.paddingAllXs,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: theme.colorScheme.onSurface,
                size: 20,
              ),
              onPressed: () => context.canPop() ? context.pop() : null,
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
