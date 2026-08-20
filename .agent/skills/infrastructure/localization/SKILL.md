---
name: Localization Enforcer
description: Strictly enforces that all user-facing text must be localized using easy_localization. The agent must search existing localization keys, reuse existing keys whenever possible, correctly distinguish global/common keys from feature-specific keys, automatically add missing keys to fa.json and en-US.json, regenerate LocaleKeys, and use type-safe LocaleKeys references in code.
---

# Localization Rules

## 🌐 Strictly Enforced Localization Rules

* You are **STRICTLY PROHIBITED** from using raw hardcoded user-facing string literals in UI widget files.

Examples of prohibited code:
```dart
Text('ثبتنام')
Text('Login')
Text('خطا')
SnackBar(content: Text('عملیات ناموفق بود'))
```

* Every user-facing text MUST use `easy_localization`.
* Every localized string MUST be accessed through the generated type-safe `LocaleKeys` class.

Correct:
```dart
Text(LocaleKeys.auth.login.tr())
```

Incorrect:
```dart
Text('Login')
Text('auth.login'.tr())
tr('auth.login')
```

* You MUST use:
```dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
```
when required by the file.

---

# 🔎 Search Before Create — MANDATORY

Before creating **ANY new localization key**, you MUST search the existing localization files.

Check:
```text
lib/core/localization/langs/fa.json
lib/core/localization/langs/en-US.json
```

Do NOT create a new key before performing this search.

The purpose is not only to find an exact key match.

You MUST search for:
1. Exact key matches
2. Similar key names
3. Similar English translations
4. Similar Persian translations
5. Semantically equivalent messages
6. Existing Common/Global keys
7. Existing keys inside the current Feature
8. Existing keys inside related Features

---

# ♻️ Reuse Before Create

The default behavior MUST be:
> **REUSE an existing localization key whenever it is semantically appropriate.**

Do NOT create a new key simply because:
* the wording is slightly different
* the text is used in another screen
* the key is located in another Feature
* the English wording is slightly different
* the Persian wording is slightly different

Example:
If this already exists:
```json
{
  "common": {
    "retry": "Retry"
  }
}
```

DO NOT create:
```json
{
  "projects": {
    "try_again": "Try again"
  }
}
```
if both messages represent the same generic action.

Use:
```dart
LocaleKeys.common.retry.tr()
```
instead.

---

# 🧠 Semantic Duplicate Detection

Exact text matching is NOT sufficient.

You must detect semantic duplicates.

For example, these may represent the same concept:
```text
retry
try_again
try_again_later
retry_request
retry_action
```

Before creating a new key, determine whether an existing key already represents the intended concept.

However, do NOT merge keys purely because their translations happen to be identical.

Context and meaning are more important than wording.

---

# 🗂️ Localization Architecture

Localization keys MUST be organized into two conceptual categories:

## 1. Common / Global
Use Common/Global keys for concepts that are reusable across multiple Features.

Examples:
```text
loading
retry
cancel
confirm
save
delete
edit
close
back
next
previous
search
filter
refresh
success
error
network_error
server_error
unknown_error
no_data
no_results
required
invalid_input
permission_denied
```

These should NOT be duplicated inside individual Features unless the Feature requires a genuinely different meaning or message.

---

## 2. Feature-specific
Use Feature namespaces for business/domain-specific content.

Examples:
```json
{
  "auth": {
    "login": "...",
    "logout": "...",
    "invalid_credentials": "...",
    "session_expired": "..."
  },

  "projects": {
    "create": "...",
    "delete": "...",
    "empty": "...",
    "created_successfully": "..."
  },

  "settings": {
    "title": "...",
    "language": "..."
  }
}
```

The exact Feature names MUST follow the existing architecture of the project.

Do not invent a new namespace if an existing appropriate namespace already exists.

---

# ⚖️ Common vs Feature-Specific Decision

When creating a new key, ask:

### Question 1
Is this concept reusable across multiple Features?
If YES:
→ Prefer Common/Global.
If NO:
→ Continue.

### Question 2
Does the text contain business/domain-specific meaning?
If YES:
→ Put it under the appropriate Feature.
If NO:
→ Reconsider whether an existing Common key can be reused.

---

# 🚨 Loading / Error / Success / Empty States

Pay special attention to generic application states.

Before creating Feature-specific versions of these messages, ALWAYS search for existing global keys.

Examples:
```text
loading
error
success
retry
something_went_wrong
operation_failed
operation_successful
network_error
server_error
no_data
no_results
```

For example, do NOT create:
```text
projects.loading
tasks.loading
users.loading
dashboard.loading
```
if the application already has a generic:
```text
common.loading
```
that communicates the same concept.

However, a Feature-specific message is appropriate when the message itself contains Feature context.

For example:
```text
projects.no_projects
tasks.no_tasks
users.no_users
```
may be appropriate if the message is specifically describing that Feature's empty state.

---

# 🧩 Generic Actions

Common actions should normally be reused.

Examples:
```text
save
cancel
delete
edit
add
remove
create
update
close
confirm
retry
refresh
search
filter
clear
select
download
upload
```

Before creating:
```text
projects.delete
```
ask whether the UI actually needs:
```text
common.delete
```
or whether the Feature requires a more descriptive message such as:
```text
projects.delete_project
```

Do not create Feature-specific copies of generic actions without a semantic reason.

---

# 📝 Key Naming Convention

New keys MUST follow the project's established naming convention.

The current convention is:
```text
snake_case
```

Examples:
```text
login
login_error_message
invalid_credentials
password_required
project_created
delete_confirmation
network_error
```

Do NOT introduce camelCase or random naming if the existing localization files use snake_case.

Avoid meaningless names:
```text
text1
message1
error1
label2
data
string
temp
new_text
```

Names should describe the semantic meaning of the localized content.

---

# 🏗️ Feature Namespace Rules

New Feature-specific keys MUST be placed under the appropriate Feature namespace.

Example:
```json
{
  "auth": {
    "login": "ورود",
    "logout": "خروج",
    "invalid_credentials": "اطلاعات ورود صحیح نیست"
  },

  "projects": {
    "create": "ایجاد پروژه",
    "delete_confirmation": "آیا از حذف پروژه مطمئن هستید؟"
  }
}
```

Do NOT put Feature-specific keys at the root.

Bad:
```json
{
  "login_error_message": "...",
  "project_created": "...",
  "task_deleted": "..."
}
```
if the project architecture already supports Feature namespaces.

---

# 🌍 Common Keys

Generic reusable keys should live in the project's Common/Global section.

If the project currently uses a root-level structure for Common keys, preserve that convention.

Do NOT create a `common` namespace solely because this rule says so if the existing project architecture intentionally keeps generic keys flat.

The existing project structure is the source of truth.

---

# 🔐 Backend / API Error Localization

Backend/API errors MUST NOT be directly shown to users unless explicitly intended by the architecture.

Never hardcode localized messages inside:
* Data Sources
* Repositories
* API clients
* Dio interceptors
* HTTP clients

Instead, map technical errors/codes to domain failures and resolve them to localized messages at the appropriate presentation layer.

Example:
```text
auth/invalid-credentials
        ↓
Failure.invalidCredentials
        ↓
LocaleKeys.auth.invalid_credentials.tr()
```

Example:
```text
401
↓
UnauthorizedFailure
↓
LocaleKeys.common.unauthorized.tr()
```

The exact architecture must follow the existing project's error-handling pattern.

---

# ➕ Automatic Key Creation

If a required localization key does NOT exist:
1. Determine whether it belongs to Common/Global or a Feature.
2. Create an appropriate `snake_case` key.
3. Add the key to `fa.json`.
4. Add the same key to `en-US.json`.
5. Preserve the existing JSON structure and formatting.
6. Add the Persian translation to `fa.json`.
7. Add the English translation to `en-US.json`.
8. Ensure both files contain exactly the same key structure.
9. Run:
```bash
dart run easy_localization:generate -S lib/core/localization/langs -f keys -O lib/generated -o locale_keys.g.dart
```
10. Verify that the generated `LocaleKeys` contains the new key.
11. Use the generated key in the code.

Example:
```dart
Text(LocaleKeys.auth.login.tr())
```

---

# 🔄 Translation Synchronization

Whenever a key is added:
```text
fa.json
en-US.json
LocaleKeys
```
MUST remain synchronized.

Never add a key to only one language.

Never use a key in Dart code before ensuring that the generated `LocaleKeys` contains it.

---

# 🧪 Placeholder Consistency

When localized text contains variables, placeholders MUST be identical between languages.

Example:
```json
{
  "welcome_user": "Welcome, {name}"
}
```
and:
```json
{
  "welcome_user": "خوش آمدید {name}"
}
```

The `{name}` placeholder must remain exactly the same.

Never silently rename, remove, or change placeholders between languages.

---

# 🖥️ UI Coverage

Localization MUST be considered for all user-facing UI elements, including:
* Text
* Button labels
* Dialog titles
* Dialog descriptions
* Confirmation messages
* Snackbars
* Toasts
* Tooltips
* Empty states
* Error states
* Loading states
* Success states
* Form validation
* Input hints
* Input labels
* Accessibility labels
* Semantic labels
* Menu items
* Dropdown items
* Tabs
* Navigation labels
* Bottom sheets
* Permission messages

---

# 🚫 Do Not Localize Technical Strings

Do NOT unnecessarily localize:
```text
API URLs
database fields
JSON keys
enum values
IDs
UUIDs
file extensions
regex
debug logs
developer comments
internal identifiers
technical constants
```
unless the value is actually presented to the user.

---

# 🔍 Existing Feature Inspection

When implementing or modifying a Feature:
1. Identify the Feature.
2. Inspect its existing localization keys.
3. Search Common/Global localization keys.
4. Search related Features.
5. Reuse existing keys where appropriate.
6. Only create missing keys.

Do NOT create a new localization namespace if an appropriate existing namespace already exists.

---

# 🛑 No Blind Refactoring

Do not reorganize, rename, or delete existing localization keys merely for aesthetic reasons while implementing an unrelated Feature.

Only modify existing keys when required by the current task or when necessary to prevent duplication/conflict.

Keep diffs minimal and focused.

---

# 🗑️ Removing Localization Keys

Never delete a localization key just because it appears unused in the current file.

Before deleting a key:
1. Search the entire project.
2. Check all language files.
3. Check generated `LocaleKeys`.
4. Check for dynamic key usage.
5. Check related Features.
6. Confirm that the key is genuinely unused.

If uncertain, do NOT delete it.

---

# ✏️ Renaming Localization Keys

When renaming a localization key:
1. Search all usages.
2. Update all Dart references.
3. Update `fa.json`.
4. Update `en-US.json`.
5. Regenerate `LocaleKeys`.
6. Search again to confirm the old key is no longer referenced.

Never rename only the JSON key.

---

# 📦 Generated LocaleKeys

`locale_keys.g.dart` is a generated file.

Do NOT manually edit it.

Always modify the source localization files:
```text
fa.json
en-US.json
```
and regenerate:
```bash
dart run easy_localization:generate -S lib/core/localization/langs -f keys -O lib/generated -o locale_keys.g.dart
```

---

# 🧠 Localization Is Part of Feature Implementation

When implementing a Feature, localization is NOT a separate cleanup task.

The implementation is considered incomplete if:
* user-facing text is hardcoded
* required localization keys are missing
* `fa.json` and `en-US.json` are inconsistent
* generated `LocaleKeys` is outdated
* an existing appropriate key was ignored and a duplicate was created

---

# ✅ Final Verification Checklist

Before considering the task complete, verify:
* [ ] No new hardcoded user-facing strings were introduced.
* [ ] Existing localization keys were searched first.
* [ ] Existing semantically equivalent keys were reused where appropriate.
* [ ] New keys are only created when necessary.
* [ ] Common/Global keys are not duplicated inside Features.
* [ ] Feature-specific keys are inside the correct Feature namespace.
* [ ] Key names follow the project's snake_case convention.
* [ ] `fa.json` was updated.
* [ ] `en-US.json` was updated.
* [ ] Both language files have matching key structures.
* [ ] Placeholders are consistent across languages.
* [ ] `LocaleKeys` was regenerated.
* [ ] The generated key is used through `LocaleKeys.<key>.tr()`.
* [ ] Backend/API errors are mapped instead of hardcoded.
* [ ] No unnecessary localization refactoring was performed.

---

# 🏆 Golden Rule

Always follow this order:
```text
SEARCH
  ↓
UNDERSTAND CONTEXT
  ↓
CHECK COMMON / GLOBAL KEYS
  ↓
CHECK FEATURE KEYS
  ↓
REUSE EXISTING KEY
  ↓
IF NO APPROPRIATE KEY EXISTS
  ↓
CREATE NEW KEY
  ↓
UPDATE fa.json + en-US.json
  ↓
GENERATE LocaleKeys
  ↓
USE LocaleKeys.<key>.tr()
  ↓
VERIFY
```

**Never skip the SEARCH step.**
**Never create a duplicate key when an appropriate existing key can be reused.**
**Never hardcode user-facing text.**
**Never manually modify generated `LocaleKeys`.**
