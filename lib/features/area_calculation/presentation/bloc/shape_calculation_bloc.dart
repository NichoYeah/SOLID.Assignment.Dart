import 'package:bloc/bloc.dart';
import '../../domain/usecases/contracts/shapes_computation_use_case.dart';
import 'shape_calculation_event.dart';
import 'shape_calculation_state.dart';

class ShapeCalculationBloc extends Bloc<ShapeCalculationEvent, ShapeCalculationState> {
  final ShapesComputationUseCase computeShapeUseCase;

  ShapeCalculationBloc({required this.computeShapeUseCase}) : super(ShapeCalculationInitial()) {
    on<ShapeCalculatePressed>(_onCalculate);
  }

  void _onCalculate(ShapeCalculatePressed event, Emitter<ShapeCalculationState> emit) {
    try {
      emit(ShapeCalculationLoading());
      final summary = computeShapeUseCase.compute(
        circleRadius: event.circleRadius,
        triangleWidth: event.triangleWidth,
        triangleHeight: event.triangleHeight,
      );
      emit(ShapeCalculationSuccess(summary));
    } catch (e) {
      emit(ShapeCalculationFailure(e.toString()));
    }
  }
}
