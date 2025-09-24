import '../../entities/shape.dart';
import '../contracts/largest_shape_finder.dart';

class LargestShapeFinderImpl implements LargestShapeFinder {
  @override
  Shape? findLargest(List<Shape> shapes) {
    if (shapes.isEmpty) return null;
    shapes.sort((a, b) => b.area().compareTo(a.area()));
    return shapes.first;
  }
}
