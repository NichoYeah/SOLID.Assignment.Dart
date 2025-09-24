import 'shape.dart';

class RightAngledTriangle implements Shape {
  final int width;
  final int height;
  RightAngledTriangle(this.width, this.height);

  @override
  double area() => width * height / 2.0;

  @override
  String get name => 'RightAngledTriangle';
}
