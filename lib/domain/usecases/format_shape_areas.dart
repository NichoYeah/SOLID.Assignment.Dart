import '../entities/shape.dart';

class FormatShapeAreasUseCase {
  List<String> call(List<Shape> shapes) {
    return shapes
        .map((s) => 'The area of the ${s.name.toLowerCase()} is ${s.area()}')
        .toList();
  }
}
