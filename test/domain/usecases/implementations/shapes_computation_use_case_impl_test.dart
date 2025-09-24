import 'package:test/test.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/shapes_computation_use_case_impl.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/largest_shape_finder_impl.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/circle.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/right_angled_triangle.dart';

void main() {
  group('ShapesComputationUseCaseImpl', () {
    final useCase = ShapesComputationUseCaseImpl(largestFinder: LargestShapeFinderImpl());

    test('computes shapes and largest correctly', () {
      final summary = useCase.compute(
        circleRadius: 3,
        triangleWidth: 4,
        triangleHeight: 5,
      );
      expect(summary.shapes.length, 2);
      expect(summary.shapes.whereType<Circle>(), isNotEmpty);
      expect(summary.shapes.whereType<RightAngledTriangle>(), isNotEmpty);
      // Largest should be whichever has greater area between circle and triangle
      final circleArea = summary.shapes.whereType<Circle>().first.area();
      final triArea = summary.shapes.whereType<RightAngledTriangle>().first.area();
      if (circleArea >= triArea) {
        expect(summary.largest, isA<Circle>());
      } else {
        expect(summary.largest, isA<RightAngledTriangle>());
      }
    });

    test('throws when any dimension <= 0', () {
      expect(() => useCase.compute(circleRadius: 0, triangleWidth: 4, triangleHeight: 5), throwsArgumentError);
      expect(() => useCase.compute(circleRadius: 3, triangleWidth: -1, triangleHeight: 5), throwsArgumentError);
    });
  });
}
