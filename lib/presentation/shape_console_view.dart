import 'dart:async';

import '../application/shapes/shape_bloc.dart';
import '../application/shapes/shape_event.dart';
import '../application/shapes/shape_state.dart';
import '../domain/usecases/shape_area_formatter.dart';

class ShapeConsoleView {
  final ShapeBloc shapeBloc;
  final ShapeAreaFormatter areaFormatter;
  late final StreamSubscription _subscription;

  ShapeConsoleView({required this.shapeBloc, required this.areaFormatter});

  void run({int shapeCount = 2}) {
    _subscription = shapeBloc.stream.listen((state) {
      switch (state) {
        case ShapeInitial():
          break;
        case ShapeLoading():
          print('Generating shapes...');
        case ShapeLoaded(:final shapes, :final largest):
          for (final line in areaFormatter.format(shapes)) {
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

    shapeBloc.add(GenerateRandomShapes(shapeCount));
  }

  void dispose() {
    _subscription.cancel();
  }
}
