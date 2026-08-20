### 🎯 Enterprise Feature Scaffolder (Clean & Empty Canvas)

Please implement the **[feature_name, e.g., product_details]** feature according to **Feature-First Clean Architecture**, utilizing **Riverpod (v2+)** and **Freezed**.

---

#### 📂 1. Folder Structure Compliance
Generate clean, isolated code split into distinct files following this exact structure:

lib/features/[feature_name]/
├── domain/
│   ├── entities/          ← Pure Dart data classes 
│   ├── repositories/      ← Abstract interfaces returning Result<T>
│   └── usecases/          ← Single-responsibility classes returning Result<T>
├── data/
│   ├── api/               ← Endpoint definitions using Dio/Retrofit
│   ├── datasources/       ← Remote/Local DataSources
│   ├── dto/               ← Network models with json_serializable
│   ├── mapper/            ← Extension methods to map DTO -> Entity
│   └── repositories/      ← Repository implementations
└── presentation/
    ├── controllers/       ← AsyncNotifier/Notifier classes and their Providers
    ├── states/            ← State holder classes generated with Freezed
    ├── views/             ← Main entry point screen (must be named [feature_name]_view.dart)
    └── widgets/           ← Small, feature-specific Material 3 UI components

---

#### ⚙️ 2. Technical Requirements & Layer Rules

1. **Domain Layer (Core Business Rules):**
   - MUST be Pure Dart. Zero dependencies on `flutter/material.dart` or `flutter_riverpod`.
   - Use a `Result<T>` wrapper for all Repository and UseCase return types.

2. **Data Layer:**
   - DTO models must include `fromJson` and `toJson` methods using `@JsonSerializable`.
   - DataSources throw exceptions. Repositories catch these exceptions and map them to Domain Failures.
   - Include Riverpod `Provider` definitions for DataSources and Repositories.

3. **Presentation Layer & UI Entry Point (CRITICAL - KEEP UI BLANK):**
   - Define the **State** class using `@freezed` (Initial, Loading, Success, Error).
   - The **Controller** must inherit from `AsyncNotifier` (or `Notifier`), interact directly with UseCases.
   - **Main View (`views/[feature_name]_view.dart`):** Generate this as a `ConsumerWidget`.
   - **IMPORTANT:** Do NOT generate mock lists, custom cards, or hardcoded dummy UI elements in the `Success` state. Keep the View completely BLANK and minimal (e.g., a simple `Scaffold` with an `AppBar` and a `Center` containing an empty `SizedBox` or a basic placeholder text). I will design the UI components myself.

---

#### 🚦 3. Post-Generation Instruction (Routing Update)
- **Update `app_routes.dart`:** Provide the full updated content for `lib/app/router/app_routes.dart` including the new static route key for this feature:
  `static const String [feature_name] = '/[feature_name]';`
- **DO NOT modify `app_router.dart`:** Do NOT generate, rewrite, or modify `lib/app/router/app_router.dart`. Leave the GoRouter configuration intact.

---



#### 🤖 4. AI Generation Rules:
   - Provide the EXACT relative file path for every code block (e.g., `lib/features/...`).
   - Output **COMPLETE, executable file content** for the feature files. Do not use placeholders like `// ... rest of code`.
   - Include necessary build commands at the end.

---

#### 📝 Feature Specifications:
- **Feature Name:** [Insert feature name here]
- **Required Operations (Use Cases):** [e.g., Fetch List, Delete Item]
- **Main Model Fields:** [e.g., id (string), title (string)]