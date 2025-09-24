import '../../domain/entities/shape.dart';

sealed class ShapeState {}

class ShapeInitial extends ShapeState {}

class ShapeLoading extends ShapeState {}

class ShapeLoaded extends ShapeState {
  final List<Shape> shapes;
  final Shape? largest;
  ShapeLoaded({required this.shapes, required this.largest});
}

class ShapeError extends ShapeState {
  final String message;
  ShapeError(this.message);
}
