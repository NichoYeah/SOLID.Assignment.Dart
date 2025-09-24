import 'dart:math';
import 'package:test/test.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/circle.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/right_angled_triangle.dart';

void main() {
  group('Shape area', () {
    test('Circle area', () {
      final c = Circle(3);
      expect(c.area(), closeTo(pi * 9, 0.0001));
    });

    test('RightAngledTriangle area', () {
      final t = RightAngledTriangle(4, 6);
      expect(t.area(), 12);
    });

  });
}
