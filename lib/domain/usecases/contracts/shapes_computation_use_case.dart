import '../../entities/shapes_summary.dart';

abstract interface class ShapesComputationUseCase {
  ShapesSummary compute({
    required int circleRadius,
    required int triangleWidth,
    required int triangleHeight,
    required int squareSide,
  });
}
