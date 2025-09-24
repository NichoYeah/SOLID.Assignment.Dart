/// Barrel export for the Area Calculation feature.
/// Exposes only public-facing entities, interfaces (contracts), and UI entry point widgets.
library;

// Entities
export 'domain/entities/shape.dart';
export 'domain/entities/circle.dart';
export 'domain/entities/right_angled_triangle.dart';

// Use case contracts (no implementations to keep consumers decoupled)
export 'domain/usecases/contracts/largest_shape_finder.dart';
export 'domain/usecases/contracts/shapes_computation_use_case.dart';

// Public UI (feature section widget) - can be embedded wherever needed
export 'presentation/widgets/area_calculation_section.dart';