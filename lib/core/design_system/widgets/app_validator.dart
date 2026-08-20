import 'package:flutter_material_enterprise_starter/core/design_system/widgets/app_form_field_config.dart';

/// Fluent API validation builder that supports rule-chaining, input trimming,
/// custom regex patterns, and cross-field dependency validations.
class AppValidator {
  final List<AppFormBuilderValidator> _rules = [];
  bool _isOptional = false;

  /// Private constructor. Use [AppValidator.builder] to instantiate.
  AppValidator._();

  /// Starts a new fluent validation chain.
  static AppValidator get builder => AppValidator._();

  /// Marks the field as optional. If the input is null, empty, or whitespace,
  /// all subsequent validations are skipped and the field is treated as valid.
  AppValidator optional() {
    _isOptional = true;
    return this;
  }

  /// Enforces that the field must not be null, empty, or whitespace.
  AppValidator required(String message) {
    _rules.add((value, _) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Validates standard email address formats using RegExp.
  AppValidator email(String message) {
    _rules.add((value, _) {
      if (value == null || value.trim().isEmpty) return null;
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value.trim())) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Enforces that the trimmed input value must be at least [length] characters long.
  AppValidator minLength(int length, String message) {
    _rules.add((value, _) {
      if (value == null || value.trim().isEmpty) return null;
      if (value.trim().length < length) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Validates mobile phone formats (Iranian mobile numbers and standard extensions).
  AppValidator phone(String message) {
    _rules.add((value, _) {
      if (value == null || value.trim().isEmpty) return null;
      final phoneRegex = RegExp(r'^(?:0|\+98|0098)?9\d{9}$');
      if (!phoneRegex.hasMatch(value.trim())) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Validates standard alphabetic names (supports Persian/Arabic and English characters).
  AppValidator name(String message) {
    _rules.add((value, _) {
      if (value == null || value.trim().isEmpty) return null;
      final nameRegex = RegExp(
        r'^[a-zA-Z\s\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+$',
      );
      if (!nameRegex.hasMatch(value.trim())) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Validates the input against a custom regular expression pattern.
  AppValidator pattern(RegExp regex, String message) {
    _rules.add((value, _) {
      if (value == null || value.trim().isEmpty) return null;
      if (!regex.hasMatch(value)) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Performs a custom validation assertion using a builder callback.
  AppValidator custom(AppFormBuilderValidator validator) {
    _rules.add(validator);
    return this;
  }

  /// Validates that the input matches the value of another field in the form.
  AppValidator matchField(String otherFieldName, String message) {
    _rules.add((value, controllers) {
      final otherValue = controllers[otherFieldName]?.text;
      if (value != otherValue) {
        return message;
      }
      return null;
    });
    return this;
  }

  /// Compiles the rule chain into a single compatible [AppFormBuilderValidator] function.
  AppFormBuilderValidator build() {
    return (value, controllers) {
      final isInputEmpty = value == null || value.trim().isEmpty;
      
      // If the field is optional and has no input, it is automatically valid
      if (_isOptional && isInputEmpty) {
        return null;
      }

      // Evaluate validation rules sequentially
      for (final rule in _rules) {
        final error = rule(value, controllers);
        if (error != null) {
          return error; // Return the first matched error message
        }
      }
      return null;
    };
  }
}
