import 'package:flutter/material.dart';

/// Validator callback that has access to other field controllers for cross-field validation.
typedef AppFormBuilderValidator = String? Function(
  String? value,
  Map<String, TextEditingController> controllers,
);

/// Configuration schema for individual form fields.
class AppFormFieldConfig {
  final String name;
  final String label;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final AppFormBuilderValidator? validator;

  const AppFormFieldConfig({
    required this.name,
    required this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });
}
