import 'package:bloc/bloc.dart';

import '../../domain/services/random_shape_factory.dart';
import '../../domain/usecases/largest_shape_finder.dart';
import 'shape_event.dart';
import 'shape_state.dart';

class ShapeBloc extends Bloc<ShapeEvent, ShapeState> {
  final ShapeFactory factory;
  final LargestShapeFinder largestShapeFinder;

  ShapeBloc({required this.factory, required this.largestShapeFinder}) : super(ShapeInitial()) {
    on<GenerateRandomShapes>(_onGenerateRandomShapes);
  }

  void _onGenerateRandomShapes(GenerateRandomShapes event, Emitter<ShapeState> emit) {
    try {
      emit(ShapeLoading());
      final shapes = factory.randomShapes(event.count);
      final largest = largestShapeFinder.findLargest(shapes);
      emit(ShapeLoaded(shapes: shapes, largest: largest));
    } catch (e) {
      emit(ShapeError('Failed to generate shapes: $e'));
    }
  }
}
