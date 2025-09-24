import 'dart:async';

import '../application/shapes/shape_bloc.dart';
import '../application/shapes/shape_event.dart';
import '../application/shapes/shape_state.dart';
import '../domain/usecases/format_shape_areas.dart';

class ConsoleView {
  final ShapeBloc bloc;
  final FormatShapeAreasUseCase formatAreas;
  late final StreamSubscription _sub;

  ConsoleView({required this.bloc, required this.formatAreas});

  void run({int shapeCount = 2}) {
    _sub = bloc.stream.listen((state) {
      switch (state) {
        case ShapeInitial():
          break;
        case ShapeLoading():
          print('Generating shapes...');
        case ShapeLoaded(:final shapes, :final largest):
          for (final line in formatAreas(shapes)) {
            print(line);
          }
          if (largest != null) {
            print('${largest.name} is the largest');
          }
          dispose();
        case ShapeError(:final message):
          print('Error: $message');
          dispose();
      }
    });

    bloc.add(GenerateRandomShapes(shapeCount));
  }

  void dispose() {
    _sub.cancel();
  }
}
