abstract class ShapeCalculationEvent {}

class ShapeCalculatePressed extends ShapeCalculationEvent {
  final int circleRadius;
  final int triangleWidth;
  final int triangleHeight;
  ShapeCalculatePressed({
    required this.circleRadius,
    required this.triangleWidth,
    required this.triangleHeight,
  });
}
