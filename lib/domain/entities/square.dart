import 'shape.dart';

class Square implements Shape {
  final int side;
  Square(this.side);

  @override
  double area() => side * side.toDouble();

  @override
  String get name => 'Square';
}
