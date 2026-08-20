import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/widgets/app_form_builder.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/features/auth/auth.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Declarative Login Form View.
class LoginView extends ConsumerWidget {
  final VoidCallback onToggleView;

  const LoginView({super.key, required this.onToggleView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);
    final isLoading = ValueNotifier<bool>(authState.isLoading);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.paddingAllXl,
            child: Column(
              spacing: AppSpacing.spacing,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocaleKeys.auth_login_title.tr(),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppFormBuilder(
                  isLoading: isLoading,
                  fields: [
                    AppFormFieldConfig(
                      name: 'email',
                      label: LocaleKeys.auth_email_label.tr(),
                      prefixIcon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidator.builder
                          .required(LocaleKeys.auth_email_required.tr())
                          .email(LocaleKeys.auth_email_invalid.tr())
                          .build(),
                    ),
                    AppFormFieldConfig(
                      name: 'password',
                      label: LocaleKeys.auth_password_label.tr(),
                      prefixIcon: Icons.lock_rounded,
                      obscureText: true,
                      validator: AppValidator.builder
                          .required(LocaleKeys.auth_password_required.tr())
                          .minLength(6, LocaleKeys.auth_password_short.tr())
                          .build(),
                    ),
                  ],
                  submitButtonText: LocaleKeys.auth_login_btn.tr(),
                  onSubmit: (values) async {
                    await ref
                        .read(authControllerProvider.notifier)
                        .login(values['email']!.trim(), values['password']!);
                  },
                  footer: TextButton(
                    onPressed: onToggleView,
                    child: Text(LocaleKeys.auth_no_account.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
