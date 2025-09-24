import '../entities/shape.dart';

class FindLargestShapeUseCase {
  Shape? call(List<Shape> shapes) {
    if (shapes.isEmpty) return null;
    shapes.sort((a, b) => b.area().compareTo(a.area()));
    return shapes.first;
  }
}
