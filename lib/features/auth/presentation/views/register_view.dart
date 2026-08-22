import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/widgets/app_form_builder.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Declarative Register Form View.
class RegisterView extends ConsumerWidget {
  final VoidCallback onToggleView;

  const RegisterView({super.key, required this.onToggleView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final signupState = ref.watch(signupControllerProvider);
    final isLoading = ValueNotifier<bool>(signupState.isLoading);

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
                  LocaleKeys.auth_register_title.tr(),
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
                    AppFormFieldConfig(
                      name: 'confirmPassword',
                      label: LocaleKeys.auth_confirm_password_label.tr(),
                      prefixIcon: Icons.lock_clock_rounded,
                      obscureText: true,
                      validator: AppValidator.builder
                          .required(
                            LocaleKeys.auth_confirm_password_required.tr(),
                          )
                          .matchField(
                            'password',
                            LocaleKeys.auth_passwords_mismatch.tr(),
                          )
                          .build(),
                    ),
                  ],
                  submitButtonText: LocaleKeys.auth_register_btn.tr(),
                  onSubmit: (values) async {
                    await ref
                        .read(signupControllerProvider.notifier)
                        .signup(values['email']!.trim(), values['password']!);
                  },
                  footer: TextButton(
                    onPressed: onToggleView,
                    child: Text(LocaleKeys.auth_have_account.tr()),
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
