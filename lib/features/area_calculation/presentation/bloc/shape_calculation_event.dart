abstract class ShapeCalculationEvent {}

class ShapeCalculatePressed extends ShapeCalculationEvent {
  final int circleRadius;
  final int triangleWidth;
  final int triangleHeight;
  final int squareSide;
  ShapeCalculatePressed({
    required this.circleRadius,
    required this.triangleWidth,
    required this.triangleHeight,
    required this.squareSide,
  });
}
