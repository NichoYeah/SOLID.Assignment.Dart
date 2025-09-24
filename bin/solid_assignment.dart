import 'package:solid_assignment/domain/services/random_shape_factory.dart';
import 'package:solid_assignment/domain/usecases/largest_shape_finder.dart';
import 'package:solid_assignment/domain/usecases/shape_area_formatter.dart';
import 'package:solid_assignment/application/shapes/shape_bloc.dart';
import 'package:solid_assignment/presentation/shape_console_view.dart';

void main(List<String> args) {
  final shapeFactory = RandomShapeFactory();
  final largestFinder = LargestShapeFinderImpl();
  final areaFormatter = ShapeAreaFormatterImpl();
  final bloc = ShapeBloc(factory: shapeFactory, largestShapeFinder: largestFinder);
  final view = ShapeConsoleView(shapeBloc: bloc, areaFormatter: areaFormatter);
  view.run(shapeCount: 3);
}
