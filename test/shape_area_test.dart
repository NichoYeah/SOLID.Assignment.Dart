import 'dart:math';
import 'package:test/test.dart';
import 'package:solid_assignment/domain/entities/circle.dart';
import 'package:solid_assignment/domain/entities/right_angled_triangle.dart';
import 'package:solid_assignment/domain/entities/square.dart';

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

    test('Square area', () {
      final s = Square(5);
      expect(s.area(), 25);
    });
  });
}
