# SOLID Assignment – Feature-Based Refactor

## Table of Contents

- [Overview](#overview)
- [Architecture Snapshot](#architecture-snapshot)
  - [Layer Roles](#layer-roles)
  - [Barrel Export](#barrel-export)
- [SOLID Application](#solid-application)
- [Testing Strategy](#testing-strategy)
- [Public API (What Consumers Should Import)](#public-api-what-consumers-should-import)
- [Extending the Feature (Example: Add Rectangle)](#extending-the-feature-example-add-rectangle)

## Overview

Refactored from an imperative `main.dart` script (calculating and comparing a circle and right‑angled triangle) into a feature‑oriented, SOLID‑compliant Flutter codebase. The current scope intentionally supports only `Circle` and `RightAngledTriangle` (the previously added `Square` was removed to align with the original brief).

## Architecture Snapshot

```text
lib/
  core/
    ui/
      pages/                # App-level pages (host feature widgets)
  features/
    area_calculation/
      area_calculation.dart # Barrel (public API of the feature)
      domain/
        entities/           # shape.dart, circle.dart, right_angled_triangle.dart
        usecases/
          contracts/        # largest_shape_finder.dart, shapes_computation_use_case.dart
          implementations/  # *Impl classes (internal to feature)
      presentation/
        bloc/               # shape_calculation_bloc + events/states (internal)
        widgets/            # area_calculation_section.dart (public widget)
```

### Layer Roles

- **Domain**: Pure Dart shapes + use case contracts/implementations; framework‑agnostic, easy to test.
- **Presentation**: BLoC (`ShapeCalculationBloc`) and UI widgets consuming only contracts & entities.
- **Core UI**: (Optional) Higher-level pages/shells that host feature widgets without depending on internal implementation details.

### Barrel Export

Exports ONLY the stable surface:

- Entities: `Shape`, `Circle`, `RightAngledTriangle`
- Contracts: `LargestShapeFinder`, `ShapesComputationUseCase`
- Public widget: `AreaCalculationSection`

Internal implementation details (bloc classes, *Impl use cases) remain unexported, allowing refactors without breaking consumers.

## SOLID Application

| Principle | Applied By |
|-----------|------------|
| SRP | Entities model geometry; use cases focus on one responsibility; bloc manages state transitions; widget renders UI. |
| OCP | New shapes can be added via new entity + inclusion in computation without modifying existing abstractions. |
| LSP | All shapes honor the `Shape` contract (`area()`, `name`). |
| ISP | UI depends only on narrow contracts (no leakage of internal implementations). |
| DIP | Presentation depends on abstractions (`ShapesComputationUseCase`, `LargestShapeFinder`) rather than concrete classes. |

## Testing Strategy

Mirrors feature boundaries:

- Entity geometry: deterministic area calculations.
- Use cases: combined summary + largest shape selection correctness.
- Bloc: state sequence (initial → loading → success/failure) for valid & invalid flows.
- Widget: user interaction → event dispatch → rendered result.

## Public API (What Consumers Should Import)

```dart
import 'package:solid_assignment/features/area_calculation/area_calculation.dart';

// Provides: Shape, Circle, RightAngledTriangle,
// LargestShapeFinder, ShapesComputationUseCase,
// AreaCalculationSection widget.
```

Implementations are purposely NOT exposed—external code should depend on interfaces and supply its own instances (a DI layer could be added later if needed).

## Extending the Feature (Example: Add Rectangle)

1. Create `rectangle.dart` implementing `Shape`.
2. Add it to the computation logic (or evolve to a registry/factory if growth continues).
3. (Optional) Add UI inputs + bloc event fields for rectangle dimensions.
