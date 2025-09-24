import 'package:test/test.dart';
import 'package:solid_assignment/domain/entities/circle.dart';
import 'package:solid_assignment/domain/entities/right_angled_triangle.dart';
import 'package:solid_assignment/domain/entities/square.dart';
import 'package:solid_assignment/domain/usecases/largest_shape_finder.dart';

void main() {
  group('LargestShapeFinder', () {
    test('Returns null on empty list', () {
      final finder = LargestShapeFinderImpl();
      expect(finder.findLargest([]), isNull);
    });

    test('Finds largest among shapes', () {
      final finder = LargestShapeFinderImpl();
      final shapes = [
        Circle(2), // ~12.56
        RightAngledTriangle(5, 6), // 15
        Square(5), // 25
      ];
      final largest = finder.findLargest(shapes);
      expect(largest, isA<Square>());
    });
  });
}
