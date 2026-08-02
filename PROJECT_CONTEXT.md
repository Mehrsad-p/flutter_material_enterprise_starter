# Project Context & Environment Details

## 1. Project Overview
- Project Name: flutter_enterprise_starter
- Type: Enterprise-grade Flutter Boilerplate / Starter Kit
- Target Platforms: Cross-Platform (Android, iOS, Web, Windows, macOS, Linux)
- Design System: Material Design 3 (M3)

---

## 2. Tech Stack & Dependencies

| Layer / Domain | Selected Technology / Package |
|---|---|
| Framework | Flutter (Latest Stable) |
| Design Language | Material 3 (package:flutter/material.dart) |
| State Management | flutter_riverpod (v2+) |
| Routing | go_router |
| Local Database | drift (SQLite) |
| Secure Key-Value | flutter_secure_storage |
| Preferences | shared_preferences |
| Networking | dio + retrofit |
| Immutability & CodeGen | freezed, json_serializable, build_runner |

---

## 3. Core Architectural Highlights
1. Material 3 Tokenization: Colors, typography, and spacing defined as immutable design tokens inside lib/core/design_system/tokens/.
2. Adaptive Layouts: Support for dynamic screen sizes (Mobile, Tablet, Desktop NavigationRail/Sidebar) using Material 3 guidelines.
3. Strict Result Pattern: Explicit error catching in DataSources with Domain Failure mapping.
4. Clean Code Generation: Automated serialization via build_runner.

---

## 4. Guidance for AI Agents
- Maintain strict separation of concerns across Data, Domain, and Presentation layers.
- When generating UI views or widgets, strictly use Material 3 widgets and standard Theme.of(context) tokens.
- Keep business logic inside Riverpod Controllers (Notifier / AsyncNotifier).