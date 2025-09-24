import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/largest_shape_finder_impl.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/implementations/shapes_computation_use_case_impl.dart';
import 'package:solid_assignment/features/area_calculation/presentation/bloc/shape_calculation_bloc.dart';
import 'package:solid_assignment/core/ui/pages/shape_calculation_page.dart';

void main() {
  testWidgets('ShapeCalculationPage end-to-end compute flow', (tester) async {
    final bloc = ShapeCalculationBloc(
      computeShapeUseCase: ShapesComputationUseCaseImpl(largestFinder: LargestShapeFinderImpl()),
    );

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider.value(value: bloc, child: const ShapeCalculationPage()),
    ));

    expect(find.textContaining('Enter values'), findsOneWidget);

    await tester.tap(find.text('Compute'));
    await tester.pump();

    expect(find.textContaining('Largest:'), findsOneWidget);
  });
}
