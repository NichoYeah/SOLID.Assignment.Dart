import '../entities/shape.dart';

abstract class ShapeAreaFormatter {
  List<String> format(List<Shape> shapes);
}

class ShapeAreaFormatterImpl implements ShapeAreaFormatter {
  @override
  List<String> format(List<Shape> shapes) {
    return shapes
        .map((s) => 'The area of the ${s.name.toLowerCase()} is ${s.area()}')
        .toList();
  }
}
