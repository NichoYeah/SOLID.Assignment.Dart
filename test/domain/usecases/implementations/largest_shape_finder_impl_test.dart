import 'package:test/test.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/circle.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/right_angled_triangle.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/largest_shape_finder_impl.dart';

void main() {
  group('LargestShapeFinderImpl', () {
    test('Returns null on empty list', () {
      final finder = LargestShapeFinderImpl();
      expect(finder.findLargest([]), isNull);
    });

    test('Finds largest among shapes', () {
      final finder = LargestShapeFinderImpl();
      final shapes = [
        Circle(2), // area ~12.566
        RightAngledTriangle(5, 6), // area 15
      ];
      final largest = finder.findLargest(shapes);
      expect(largest, isA<RightAngledTriangle>());
    });
  });
}
