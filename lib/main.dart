import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/usecases/contracts/shapes_computation_use_case.dart';
import 'domain/usecases/implementations/largest_shape_finder_impl.dart';
import 'domain/usecases/implementations/shapes_computation_use_case_impl.dart';
import 'presentation/bloc/shape_calculation_bloc.dart';
import 'presentation/pages/shape_calculation_page.dart';

void main() {
  final largestFinder = LargestShapeFinderImpl();
  final shapesUseCase = ShapesComputationUseCaseImpl(largestFinder: largestFinder);
  runApp(ShapeApp(useCase: shapesUseCase));
}

class ShapeApp extends StatelessWidget {
  final ShapesComputationUseCase useCase;
  const ShapeApp({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shape Calculator',
      home: BlocProvider(
        create: (_) => ShapeCalculationBloc(useCase: useCase),
        child: const ShapeCalculationPage(),
      ),
    );
  }
}
