import 'package:test/test.dart';
import 'package:solid_assignment/domain/entities/circle.dart';
import 'package:solid_assignment/domain/entities/right_angled_triangle.dart';
import 'package:solid_assignment/domain/entities/square.dart';
import 'package:solid_assignment/domain/usecases/find_largest_shape.dart';

void main() {
  group('FindLargestShapeUseCase', () {
    final useCase = FindLargestShapeUseCase();

    test('empty list returns null', () {
      expect(useCase([]), isNull);
    });

    test('finds largest among shapes', () {
      final shapes = [
        Circle(2), // area ~12.566
        RightAngledTriangle(5, 5), // area 12.5
        Square(4), // area 16
      ];
      final largest = useCase(shapes);
      expect(largest, isA<Square>());
    });

    test('tie returns first largest encountered after sort', () {
      final shapes = [Square(4), Square(4)];
      final largest = useCase(shapes);
      expect(largest, isNotNull);
      expect(largest!.area(), 16);
    });
  });
}
