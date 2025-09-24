# SOLID Assignment (Refactored)

## Overview

This project refactors an initial imperative `main.dart` script that randomly created a circle and right-angled triangle, calculated their areas, and printed which was largest. The refactored version now implements a Flutter UI with a layered architecture (Domain + Presentation; Data deferred) and clean naming conventions while adding support for a new `Square` shape without modifying existing shape-related logic (Open/Closed Principle).

## Layered Architecture

- **Domain Layer**: Pure business logic. Contains `Shape` abstraction, entity implementations (`Circle`, `RightAngledTriangle`, `Square`), service (`RandomShapeFactory` - currently unused in UI), and use case interfaces declared with Dart's `abstract interface class` (`LargestShapeFinder`, `ShapesComputationUseCase`) plus their implementations.
- **Core UI Layer (Flutter)**: Located under `lib/core/ui/` containing `ShapeCalculationPage` (UI) + `ShapeCalculationBloc` (state management) depending only on domain interfaces.
- **Composition Root**: `lib/main.dart` wires interface implementations; future Data layer can be injected without touching core UI.

## Added Shape: Square

The `Square` entity was introduced by simply adding `square.dart` and registering its generator in `RandomShapeFactory`. No existing consumer code (BLoC, view, use cases) required changes—validating Open/Closed compliance for extending behavior.

## SOLID Principles Applied

### 1. Single Responsibility Principle (SRP)

Each class has one reason to change:

- Entities (`Circle`, `Square`, etc.) only model geometry & area calculation.
- Use case implementations (`LargestShapeFinderImpl`, `ShapesComputationUseCaseImpl`) each handle one operation.
- `ShapeCalculationBloc` manages state transitions only.
- `ShapeCalculationPage` renders UI only.
- `RandomShapeFactory` (when used) encapsulates random creation logic.

### 2. Open/Closed Principle (OCP)

New shapes are added by:

1. Creating a new entity implementing `Shape`.
2. Registering a generator in `RandomShapeFactory`.

No modifications to use cases, BLoC, or presentation were needed because they work with the `Shape` abstraction.

### 3. Liskov Substitution Principle (LSP)

All concrete shapes implement `Shape` and can be substituted anywhere a `Shape` is expected. Each provides a valid `area()` and `name`. No subclass violates expected behavior (e.g., no unimplemented or exception-throwing overrides).

### 4. Interface Segregation Principle (ISP)

Clients depend only on what they use:

Presentation depends only on the narrow interfaces it needs (`ShapesComputationUseCase`, which itself depends on `LargestShapeFinder`).

No class is forced to implement unused members.

### 5. Dependency Inversion Principle (DIP)

High-level modules (`ShapeCalculationBloc`, `ShapeCalculationPage`) depend on abstractions (`ShapesComputationUseCase`, `LargestShapeFinder`). Concrete implementations are supplied at the composition root (`main.dart`).

## Naming Conventions & Guidelines Compliance

- **Detailed & Clear**: Files like `largest_shape_finder_impl.dart`, `shapes_computation_use_case_impl.dart`, `shape_calculation_bloc.dart` describe purpose precisely.
- **Package/File Naming**: All lowercase with underscores per Dart guidelines.
- **Singular Nouns**: Entity files (`circle.dart`, `square.dart`, `shape_console_view.dart`) use singular context.
- **PascalCase Types**: All classes (`ShapeConsoleView`, `ShapeBloc`, `LargestShapeFinderImpl`) follow PascalCase.
- **Module Prefixing**: Shape-related presentation files prefixed with `shape_`; BLoC files grouped under `presentation/bloc/`.
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

## Mirrored Test Directory Structure

Tests mirror the `lib/` layout for fast navigation:

```text
lib/
  core/
    ui/
      bloc/                  # shape_calculation_bloc.dart (+ event/state)
      pages/                 # shape_calculation_page.dart
  domain/
    entities/
    usecases/
      contracts/
      implementations/

test/
  domain/
    entities/                # shape_area_test.dart
    usecases/
      implementations/        # largest_shape_finder_impl_test.dart, shapes_computation_use_case_impl_test.dart
  presentation/               # (legacy directory retained only if older tests remain) 
    bloc/                     # shape_calculation_bloc_test.dart (will migrate to core/ui bloc path if reorganized)
  pages/                    # shape_calculation_page_test.dart
```

Benefits:

- Easier discoverability (jump from `lib/...` file to corresponding `test/...` path).
- Encourages focused test ownership per layer.
- Scales cleanly when adding Data layer (`test/data/...`).

## Potential Further Improvements

- Add repository interfaces & data layer (e.g., persistence of last inputs).
- Add per-field validation and UI error states.
- Introduce dependency injection container (e.g., `get_it`) for cleaner composition root & easier overrides in tests.
- Golden tests for visual regression of `ShapeCalculationPage`.
- Contract tests ensuring all `Shape` implementations meet invariants (e.g., non-negative area).
- Performance / property-based tests for large numeric ranges.

## License

Internal assignment example (no license specified).

