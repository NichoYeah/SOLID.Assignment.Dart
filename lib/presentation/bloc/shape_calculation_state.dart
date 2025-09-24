import '../../domain/entities/shapes_summary.dart';

sealed class ShapeCalculationState {}

class ShapeCalculationInitial extends ShapeCalculationState {}

class ShapeCalculationLoading extends ShapeCalculationState {}

class ShapeCalculationSuccess extends ShapeCalculationState {
  final ShapesSummary summary;
  ShapeCalculationSuccess(this.summary);
}

class ShapeCalculationFailure extends ShapeCalculationState {
  final String message;
  ShapeCalculationFailure(this.message);
}
