import '../entities/shape.dart';

abstract class LargestShapeFinder {
  Shape? findLargest(List<Shape> shapes);
}

class LargestShapeFinderImpl implements LargestShapeFinder {
  @override
  Shape? findLargest(List<Shape> shapes) {
    if (shapes.isEmpty) return null;
    shapes.sort((a, b) => b.area().compareTo(a.area()));
    return shapes.first;
  }
}
