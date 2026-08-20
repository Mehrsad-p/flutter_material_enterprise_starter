import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';

import 'package:flutter_material_enterprise_starter/core/design_system/widgets/app_form_field_config.dart';

export 'package:flutter_material_enterprise_starter/core/design_system/widgets/app_form_field_config.dart';
export 'package:flutter_material_enterprise_starter/core/design_system/widgets/app_validator.dart';

/// A reusable, declarative form builder that coordinates field validation,
/// text controllers, spacing tokens, and asynchronous submit state management.
///
/// ### External Loading State
/// When placed inside a shell page that already manages a loading state
/// (e.g. via a Riverpod controller), pass the page's [isLoading] notifier so
/// the submit button stays visually in sync with the shell's overlay:
///
/// ```dart
/// // Inside a ConsumerWidget build:
/// final isLoading = ValueNotifier(
///   ref.watch(myControllerProvider).maybeWhen(loading: () => true, orElse: () => false),
/// );
/// AppFormBuilder(
///   isLoading: isLoading,
///   ...
/// )
/// ```
///
/// When [isLoading] is not provided, the widget manages its own internal
/// loading state driven by the [onSubmit] future.
class AppFormBuilder extends StatefulWidget {
  final List<AppFormFieldConfig> fields;
  final String submitButtonText;
  final Future<void> Function(Map<String, String> values) onSubmit;
  final Widget? footer;

  /// Optional external loading notifier. When provided, the form button
  /// reflects this state instead of its own internal future-tracking state.
  /// Use this when the host page already shows a loading overlay (e.g. AuthView).
  final ValueListenable<bool>? isLoading;

  const AppFormBuilder({
    super.key,
    required this.fields,
    required this.submitButtonText,
    required this.onSubmit,
    this.footer,
    this.isLoading,
  });

  @override
  State<AppFormBuilder> createState() => _AppFormBuilderState();
}

class _AppFormBuilderState extends State<AppFormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  // Internal loading state — only used when no external isLoading is provided.
  bool _internalLoading = false;

  bool get _effectiveLoading =>
      widget.isLoading?.value ?? _internalLoading;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _controllers[field.name] = TextEditingController();
    }
    // Re-build whenever the external loading notifier changes.
    widget.isLoading?.addListener(_onExternalLoadingChanged);
  }

  @override
  void didUpdateWidget(AppFormBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading != widget.isLoading) {
      oldWidget.isLoading?.removeListener(_onExternalLoadingChanged);
      widget.isLoading?.addListener(_onExternalLoadingChanged);
    }
  }

  void _onExternalLoadingChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.isLoading?.removeListener(_onExternalLoadingChanged);
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Only manage internal state when no external notifier is wired.
      if (widget.isLoading == null) {
        setState(() => _internalLoading = true);
      }
      try {
        final values = _controllers.map(
          (key, controller) => MapEntry(key, controller.text),
        );
        await widget.onSubmit(values);
      } finally {
        if (mounted && widget.isLoading == null) {
          setState(() => _internalLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppSpacing.spacing,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...widget.fields.map((field) {
            return TextFormField(
              controller: _controllers[field.name],
              decoration: InputDecoration(
                labelText: field.label,
                prefixIcon: field.prefixIcon != null ? Icon(field.prefixIcon) : null,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.borderRadiusM,
                ),
              ),
              obscureText: field.obscureText,
              keyboardType: field.keyboardType,
              validator: field.validator != null
                  ? (value) => field.validator!(value, _controllers)
                  : null,
            );
          }),
          AppSpacing.verticalSpaceS,
          FilledButton(
            onPressed: _effectiveLoading ? null : _submit,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderRadiusM,
              ),
            ),
            child: _effectiveLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(widget.submitButtonText),
          ),
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }
}
