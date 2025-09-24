import 'package:test/test.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/shapes_computation_use_case_impl.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/largest_shape_finder_impl.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/circle.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/right_angled_triangle.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/square.dart';

void main() {
  group('ShapesComputationUseCaseImpl', () {
    final useCase = ShapesComputationUseCaseImpl(largestFinder: LargestShapeFinderImpl());

    test('computes shapes and largest correctly', () {
      final summary = useCase.compute(
        circleRadius: 3,
        triangleWidth: 4,
        triangleHeight: 5,
        squareSide: 6,
      );
      expect(summary.shapes.length, 3);
      expect(summary.shapes.whereType<Circle>(), isNotEmpty);
      expect(summary.shapes.whereType<RightAngledTriangle>(), isNotEmpty);
      expect(summary.shapes.whereType<Square>(), isNotEmpty);
      expect(summary.largest, isA<Square>());
      expect(summary.largest!.area(), 36);
    });

    test('throws when any dimension <= 0', () {
      expect(() => useCase.compute(circleRadius: 0, triangleWidth: 4, triangleHeight: 5, squareSide: 6), throwsArgumentError);
      expect(() => useCase.compute(circleRadius: 3, triangleWidth: -1, triangleHeight: 5, squareSide: 6), throwsArgumentError);
    });
  });
}
