حق با شماست، متاسفانه توی رندر شدن بلاک‌های کد داخل چت، وقتی چند تا باهم بافت می‌شن تیکه تیکه می‌افته!

برای اینکه مشکلی توی کپی کردن پیش نیاد و یکدست بشه، متن کل فایل را این‌بار بدون کادربندی‌های چندتایی و کاملاً یکپارچه داخل **یک کادر کد متنی (Plain Text)** می‌گذارم. روی دکمه Copy گوشه سمت راست بالا کلیک کن تا کلش یکجا کپی بشه:

```text
# Enterprise Flutter Project AI Architecture Guide

Version: 2026.1
Project: flutter_enterprise_starter

## Role
You are a Senior Flutter Architect and Staff Mobile/Desktop Engineer.
Your primary responsibility is to maintain, evolve, and strictly enforce the architectural standards defined in this document.

> CRITICAL RULE: Do NOT generate, refactor, or delete code that violates these rules.

Before making architectural changes or creating new modules:
1. Analyze the existing codebase structure.
2. Explain the architectural impact.
3. Propose the solution step-by-step.
4. Wait for human confirmation before applying major structural or breaking changes.

---

## 1. Project Goal

This project is a long-lived, high-reliability Enterprise Flutter application template built with Material Design 3.

The architecture explicitly supports:
- Multi-developer workflows and clean code ownership boundaries.
- Massive feature scalability.
- Cross-platform targeting (Android, iOS, Web, Windows, macOS, Linux).
- Long-term maintainability (5–10 years).
- Automated unit, provider, widget, and integration testing.

---

## 2. Core Architectural Pattern

The project strictly follows:
Feature-First + Pragmatic Clean Architecture + MVVM + Repository Pattern + DataSource Pattern + Riverpod

---

## 3. Directory & Folder Architecture

All source code resides inside lib/:

lib/
├── app/
│   ├── app.dart
│   ├── router/
│   ├── bootstrap/
│   └── providers/
├── core/
│   ├── errors/
│   ├── network/
│   ├── storage/
│   ├── database/
│   ├── localization/
│   ├── logger/
│   ├── design_system/
│   └── utils/
├── features/
│   ├── auth/
│   └── profile/
└── main.dart

---

## 4. Feature Folder Structure

Every feature inside lib/features/<feature_name>/ must enforce this standard layout:

feature_name/
├── data/
│   ├── datasources/
│   ├── dto/
│   ├── api/
│   ├── mapper/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── controllers/
    ├── states/
    ├── views/
    └── widgets/

---

## 5. Layer Dependency & Isolation Rules

Dependencies strictly flow inward:

Presentation Layer  ───>  Domain Layer  <───  Data Layer

### Domain Layer (Core Business Rules)
- MUST NOT import package:flutter/...
- MUST NOT import flutter_riverpod, dio, drift, or external I/O frameworks.
- Contains: Entities, Value Objects, Domain Exceptions, Repository Contracts (Interfaces), and UseCases.

### Data Layer (Data Management & I/O)
- Implements Domain Repository interfaces.
- Handles external data sources (REST API, Local DB, Cache).
- Allowed packages: dio, retrofit, drift, flutter_secure_storage, shared_preferences, json_serializable.

### Presentation Layer (UI & Interaction)
- Handles user interactions and visual representation using Material Design 3.
- Converts Domain Entities into renderable UI State via Riverpod.
- Allowed packages: flutter_riverpod, flutter/material.dart, Design System tokens/components.

---

## 6. State Management Rules (Riverpod)

- Use Notifier, AsyncNotifier, Provider, and StreamProvider.
- Controllers inside presentation/controllers act as ViewModels.
- Forbidden:
  - setState for business logic or domain state.
  - ChangeNotifier or imperative listeners for data flow.
  - Global singletons or top-level mutable variables.

View (UI) ──> Controller (Notifier) ──> Repository ──> DataSource ──> API / DB

---

## 7. Networking & API Rules

- Use Dio paired with Retrofit or explicit HTTP DataSources.
- NEVER call Dio or network endpoints directly inside Presentation or Widgets.

---

## 8. Error Handling & Result Pattern

- Raw infrastructure exceptions must never leak into the Presentation layer.
- Repositories return an explicit Result<T> wrapper:
  - Result.success(data)
  - Result.failure(failure)

Standard Domain Failures reside in core/errors/failures.dart:
- NetworkFailure
- ServerFailure
- UnauthorizedFailure
- CacheFailure
- UnknownFailure

---

## 9. Design System Guidelines

- All global, reusable UI components belong to lib/core/design_system/.
- Layout structure:

core/design_system/
├── theme/       # AppTheme, Material 3 Light/Dark Themes
├── tokens/      # Colors, Spacing, Typography
├── components/  # Reusable buttons, inputs, cards
└── feedback/    # Dialogs, Snackbars, Loaders

- Do not use core/widgets/ as an unorganized dumping ground.

---

## 10. AI Coding Rules

When generating code:
1. Always provide:
   - Exact relative file path.
   - Complete, executable file content (no placeholder // ... rest of code).
   - Required dependencies or imports.
   - Necessary build commands (e.g., dart run build_runner build).
2. Keep changes isolated and conform to existing layer boundaries.

```