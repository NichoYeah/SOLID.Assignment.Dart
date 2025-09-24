import 'dart:math';

import 'shape.dart';

class Circle implements Shape {
  final int radius;
  Circle(this.radius);

  @override
  double area() => pi * pow(radius, 2).toDouble();

  @override
  String get name => 'Circle';
}
