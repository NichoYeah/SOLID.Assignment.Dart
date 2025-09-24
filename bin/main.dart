import 'package:solid_assignment/application/shapes/shape_bloc.dart';
import 'package:solid_assignment/domain/services/random_shape_factory.dart';
import 'package:solid_assignment/domain/usecases/find_largest_shape.dart';
import 'package:solid_assignment/domain/usecases/format_shape_areas.dart';
import 'package:solid_assignment/presentation/console_view.dart';

void main(List<String> args) {
  final factory = RandomShapeFactory();
  final findLargest = FindLargestShapeUseCase();
  final formatAreas = FormatShapeAreasUseCase();
  final bloc = ShapeBloc(factory: factory, findLargest: findLargest);
  final view = ConsoleView(bloc: bloc, formatAreas: formatAreas);

  // Optionally parse count from args
  final count = (args.isNotEmpty) ? int.tryParse(args.first) ?? 2 : 2;
  view.run(shapeCount: count);
}
