abstract class ShapeEvent {}

class GenerateRandomShapes extends ShapeEvent {
  final int count;
  GenerateRandomShapes(this.count);
}
