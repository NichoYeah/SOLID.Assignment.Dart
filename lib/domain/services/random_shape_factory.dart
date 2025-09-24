import 'dart:math';

import '../entities/circle.dart';
import '../entities/right_angled_triangle.dart';
import '../entities/square.dart';
import '../entities/shape.dart';

abstract class ShapeFactory {
  Shape randomShape();
  List<Shape> randomShapes(int count);
}

class RandomShapeFactory implements ShapeFactory {
  final Random _rnd;
  final List<Shape Function()> _generators;

  RandomShapeFactory({Random? random})
      : _rnd = random ?? Random(),
        _generators = [] {
    // Register available shape generators (Open for extension)
    _generators.add(() => Circle(_rnd.nextInt(10) + 1));
    _generators.add(() => RightAngledTriangle(_rnd.nextInt(10) + 1, _rnd.nextInt(10) + 1));
    _generators.add(() => Square(_rnd.nextInt(10) + 1));
  }

  @override
  Shape randomShape() {
    final idx = _rnd.nextInt(_generators.length);
    return _generators[idx]();
  }

  @override
  List<Shape> randomShapes(int count) =>
      List.generate(count, (_) => randomShape());
}
