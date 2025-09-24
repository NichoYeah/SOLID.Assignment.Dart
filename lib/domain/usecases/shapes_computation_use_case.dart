import '../entities/shape.dart';
import '../entities/shapes_summary.dart';
import '../entities/circle.dart';
import '../entities/right_angled_triangle.dart';
import '../entities/square.dart';
import 'largest_shape_finder.dart';

abstract class ShapesComputationUseCase {
  ShapesSummary compute({
    required int circleRadius,
    required int triangleWidth,
    required int triangleHeight,
    required int squareSide,
  });
}

class ShapesComputationUseCaseImpl implements ShapesComputationUseCase {
  final LargestShapeFinder largestFinder;

  ShapesComputationUseCaseImpl({required this.largestFinder});

  @override
  ShapesSummary compute({
    required int circleRadius,
    required int triangleWidth,
    required int triangleHeight,
    required int squareSide,
  }) {
    if (circleRadius <= 0 || triangleWidth <= 0 || triangleHeight <= 0 || squareSide <= 0) {
      throw ArgumentError('All dimensions must be > 0');
    }

    final shapes = <Shape>[
      Circle(circleRadius),
      RightAngledTriangle(triangleWidth, triangleHeight),
      Square(squareSide),
    ];

    final largest = largestFinder.findLargest(shapes);
    return ShapesSummary(shapes: shapes, largest: largest);
  }
}
