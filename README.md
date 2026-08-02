# Flutter Enterprise Starter Kit

A production-ready, feature-first Enterprise Flutter Starter Template built with Material Design 3, Clean Architecture, and Riverpod.

---

## 🚀 Key Features

- Feature-First Clean Architecture: Scalable Data, Domain, and Presentation separation per feature.
- Material 3 Design System: Centralized design tokens for colors, typography, spacing, and adaptive UI.
- State Management: Robust state flows powered by flutter_riverpod (v2+).
- Navigation & Routing: Declarative routing with go_router.
- Type-Safe Networking: dio paired with retrofit and code generation.
- Local Data Handling: drift for SQLite and flutter_secure_storage for sensitive data.
- Result Pattern: Strict domain error mapping via explicit Result<T> types.

---

## 📁 Directory Structure

lib/
├── app/                  # App setup, router, global providers, bootstrap
├── core/                 # Shared utilities, networking, database, design system
│   └── design_system/    # M3 Theme, tokens, reusable components, feedback
└── features/             # Business modules (e.g., auth, profile)
    └── <feature>/
        ├── data/         # DataSources, DTOs, Repositories
        ├── domain/       # Entities, Repository Interfaces, UseCases
        └── presentation/ # ViewModels (Controllers), States, Views, Widgets

---

## 🛠️ Tech Stack & Tooling

| Domain | Technology / Library |
|---|---|
| Framework | Flutter (Latest Stable) |
| Design Language | Material Design 3 |
| State Management | flutter_riverpod |
| Router | go_router |
| Local Database | drift (SQLite) |
| Networking | dio + retrofit |
| Code Generation | freezed, json_serializable, build_runner |

---

## 🏁 Getting Started

### 1. Prerequisites
Ensure you have the Flutter SDK installed on your machine:
```bash
flutter doctor

```

### 2. Installation

Clone this repository and fetch the dependencies:

```bash
git clone [https://github.com/your-username/flutter_enterprise_starter.git](https://github.com/your-username/flutter_enterprise_starter.git)
cd flutter_enterprise_starter
flutter pub get

```

### 3. Code Generation

Run the code generator to build Freezed, Drift, and Retrofit files:

```bash
dart run build_runner build --delete-conflicting-outputs

```

---

## 📜 Architectural Rules & AI Standards

This project enforces strict AI and engineering guidelines defined in:

* AI_ARCHITECTURE_GUIDE.md: Core rules for layers, Riverpod usages, and folder layouts.
* PROJECT_CONTEXT.md: Tech stack definitions and system context.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

```

```
