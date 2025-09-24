# SOLID Assignment (Refactored)

## Overview

This project refactors an initial imperative `main.dart` script that randomly created a circle and right-angled triangle, calculated their areas, and printed which was largest. The refactored version applies a layered architecture (Domain, Application/BLoC, Presentation) and clean naming conventions while adding support for a new `Square` shape without modifying existing shape-related logic (Open/Closed Principle).

## Layered Architecture

- **Domain Layer**: Pure business logic. Contains `Shape` abstraction, entity implementations (`Circle`, `RightAngledTriangle`, `Square`), service (`RandomShapeFactory`), and use case interfaces (`LargestShapeFinder`, `ShapeAreaFormatter`) with their implementations.
  - Use case abstractions now declared using Dart's `abstract interface class` for explicit interface semantics (Dart 3 feature) to emphasize contract-based design.
- **Application Layer (BLoC)**: `ShapeBloc` orchestrates generation and evaluation of shapes via domain interfaces. Responds to `GenerateRandomShapes` events, emitting `ShapeState` variants.
- **Presentation Layer** (Flutter): `ShapeCalculationPage` (UI) + `ShapeCalculationBloc` manage user-entered dimensions and show computed areas & largest shape.
- **Composition Root**: `lib/main.dart` wires implementations (Domain abstractions into BLoC) – Data layer intentionally deferred.

## Added Shape: Square

The `Square` entity was introduced by simply adding `square.dart` and registering its generator in `RandomShapeFactory`. No existing consumer code (BLoC, view, use cases) required changes—validating Open/Closed compliance for extending behavior.

## SOLID Principles Applied

### 1. Single Responsibility Principle (SRP)

Each class has one reason to change:

- Entities (`Circle`, `Square`, etc.) only model geometry & area calculation.
- Use case implementations (`LargestShapeFinderImpl`, `ShapeAreaFormatterImpl`) each handle one operation.
- `ShapeBloc` manages state transitions only.
- `ShapeConsoleView` handles console I/O only.
- `RandomShapeFactory` encapsulates random creation logic.

### 2. Open/Closed Principle (OCP)

New shapes are added by:

1. Creating a new entity implementing `Shape`.
2. Registering a generator in `RandomShapeFactory`.

No modifications to use cases, BLoC, or presentation were needed because they work with the `Shape` abstraction.

### 3. Liskov Substitution Principle (LSP)

All concrete shapes implement `Shape` and can be substituted anywhere a `Shape` is expected. Each provides a valid `area()` and `name`. No subclass violates expected behavior (e.g., no unimplemented or exception-throwing overrides).

### 4. Interface Segregation Principle (ISP)

Clients depend only on what they use:

- View depends on `ShapeAreaFormatter` not a larger utility class.
- BLoC depends on `LargestShapeFinder` and `ShapeFactory` separately.

No class is forced to implement unused members.

### 5. Dependency Inversion Principle (DIP)

High-level modules (`ShapeCalculationBloc`, `ShapeCalculationPage`) depend on abstractions (`ShapesComputationUseCase`, `LargestShapeFinder`). Concrete implementations are supplied at composition root (`main.dart`).

## Naming Conventions & Guidelines Compliance

- **Detailed & Clear**: Files like `largest_shape_finder.dart`, `shape_area_formatter.dart`, `shape_console_view.dart` describe purpose precisely.
- **Package/File Naming**: All lowercase with underscores per Dart guidelines.
- **Singular Nouns**: Entity files (`circle.dart`, `square.dart`, `shape_console_view.dart`) use singular context.
- **PascalCase Types**: All classes (`ShapeConsoleView`, `ShapeBloc`, `LargestShapeFinderImpl`) follow PascalCase.
- **Module Prefixing**: Shape-related presentation file prefixed with `shape_`; BLoC files grouped under `application/shapes/`.
- **Avoid Acronyms/Abbrev.**: No unclear abbreviations introduced.
- **Consistency & Reuse**: Interfaces separated to promote future reuse (e.g., alternative formatters, different finder strategies).

## Running (Flutter App)

From project root:

```bash
flutter pub get
flutter run
```

### Platform-Specific Commands

Android (debug):

```bash
flutter run -d android
```

Web (if enabled):

```bash
flutter run -d chrome
```

Windows Desktop (if enabled):

```bash
flutter run -d windows
```

iOS (macOS host only):

```bash
flutter build ios --no-codesign
```

Release APK:

```bash
flutter build apk --release
```

Release App Bundle (Play Store):

```bash
flutter build appbundle
```

## Extending With a New Shape Example (e.g., Rectangle)

1. Create `rectangle.dart` implementing `Shape`.
2. Register constructor in `RandomShapeFactory` generators.
3. Run—automatically included in random selection.

## Potential Further Improvements

- Add repository interfaces & data layer (e.g., persistence of last inputs).
- Add form validation & error highlighting per field.
- Introduce dependency injection (e.g., `get_it`).
- Add widget & BLoC tests (goldens, state tests).

## License

Internal assignment example (no license specified).

