---
name: Localization Enforcer
description: Strictly enforces that all user-facing text must be localized using easy_localization. The agent must check and add keys to fa.json and en.json automatically before using any text.
---

# Localization Rules

## 🌐 Strictly Enforced Localization Rules
- You are **STRICTLY PROHIBITED** from using raw hardcoded user-facing string literals in UI widget files (e.g., `Text('ثبت‌نام')` or `SnackBar(content: Text('خطا'))`).
- Every user-facing text must be wrapped inside the `tr()` method from `easy_localization` (e.g., `Text(tr('signup'))`).

## ✍️ Verification & Key Insertion Protocol
Every time you need to write user-facing text:
1. **Search existing keys**: Check the translation JSON files [fa.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/fa.json) and [en.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/en.json) to see if a key representing this text already exists.
2. **Reuse if present**: If the key exists, use it directly (e.g. `tr('app_name')`).
3. **Insert new key automatically if missing**: If the translation key does not exist:
   - Create a clean snake_case key (e.g. `login_error_message`).
   - Append the translation to [fa.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/fa.json) in Farsi.
   - Append the translation to [en.json](file:///d:/Programming/flutter/flutter_material_enterprise_starter/assets/translations/en.json) in English.
   - Use the new key in the UI code with `tr('key')`.
