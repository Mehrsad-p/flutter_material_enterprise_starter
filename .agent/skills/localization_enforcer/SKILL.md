---
name: Localization Enforcer
description: Strictly enforces that all user-facing text must be localized using easy_localization. The agent must check and add keys to fa.json and en.json automatically before using any text.
---

# Localization Rules

## 🌐 Strictly Enforced Localization Rules
- You are **STRICTLY PROHIBITED** from using raw hardcoded user-facing string literals in UI widget files (e.g., `Text('ثبت‌نام')` or `SnackBar(content: Text('خطا'))`).
- Every user-facing text must be wrapped inside the `.tr()` extension method called on a key from `LocaleKeys` (e.g., `Text(LocaleKeys.signup.tr())` instead of `tr('signup')`).
- You **MUST** import `package:easy_localization/easy_localization.dart` and `package:flutter_material_enterprise_starter/generated/locale_keys.g.dart` to use the type-safe `LocaleKeys` class.

## ✍️ Verification & Key Insertion Protocol
Every time you need to write user-facing text:
1. **Search existing keys**: Check the translation JSON files [fa.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/fa.json) and [en.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/en.json) to see if a key representing this text already exists.
2. **Reuse if present**: If the key exists, use it via `LocaleKeys.<key>.tr()`.
3. **Insert new key automatically if missing**: If the translation key does not exist:
   - Create a clean snake_case key (e.g. `login_error_message`).
   - Append the translation to [fa.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/fa.json) in Farsi.
   - Append the translation to [en.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/en.json) in English.
   - Run the generation command: `dart run easy_localization:generate -S assets/translations -f keys -O lib/generated -o locale_keys.g.dart` to generate the new keys.
   - Use the new key in the UI code with `LocaleKeys.<new_key>.tr()`.
