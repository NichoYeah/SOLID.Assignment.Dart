import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:solid_assignment/features/area_calculation/presentation/bloc/shape_calculation_bloc.dart';
import 'package:solid_assignment/features/area_calculation/presentation/bloc/shape_calculation_event.dart';
import 'package:solid_assignment/features/area_calculation/presentation/bloc/shape_calculation_state.dart';
import 'package:solid_assignment/features/area_calculation/domain/usecases/contracts/shapes_computation_use_case.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/shapes_summary.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/circle.dart';
import 'package:solid_assignment/features/area_calculation/domain/entities/right_angled_triangle.dart';

class MockShapesComputationUseCase extends Mock implements ShapesComputationUseCase {}

void main() {
  late MockShapesComputationUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockShapesComputationUseCase();
  });

  group('ShapeCalculationBloc', () {
  final shapes = [Circle(3), RightAngledTriangle(4, 5)];
    final summary = ShapesSummary(shapes: shapes, largest: shapes.last);

    blocTest<ShapeCalculationBloc, ShapeCalculationState>(
      'emits [Loading, Success] when compute succeeds',
      build: () {
        when(() => mockUseCase.compute(
              circleRadius: any(named: 'circleRadius'),
              triangleWidth: any(named: 'triangleWidth'),
              triangleHeight: any(named: 'triangleHeight'),
            )).thenReturn(summary);
        return ShapeCalculationBloc(computeShapeUseCase: mockUseCase);
      },
      act: (bloc) => bloc.add(ShapeCalculatePressed(circleRadius: 3, triangleWidth: 4, triangleHeight: 5)),
      expect: () => [
        isA<ShapeCalculationLoading>(),
        isA<ShapeCalculationSuccess>().having((s) => (s.summary.largest), 'largest', summary.largest),
      ],
      verify: (_) {
        verify(() => mockUseCase.compute(
              circleRadius: 3,
              triangleWidth: 4,
              triangleHeight: 5,
            )).called(1);
      },
    );

    blocTest<ShapeCalculationBloc, ShapeCalculationState>(
      'emits [Loading, Failure] when compute throws',
      build: () {
        when(() => mockUseCase.compute(
              circleRadius: any(named: 'circleRadius'),
              triangleWidth: any(named: 'triangleWidth'),
              triangleHeight: any(named: 'triangleHeight'),
            )).thenThrow(ArgumentError('All dimensions must be > 0'));
        return ShapeCalculationBloc(computeShapeUseCase: mockUseCase);
      },
      act: (bloc) => bloc.add(ShapeCalculatePressed(circleRadius: 0, triangleWidth: 4, triangleHeight: 5)),
      expect: () => [
        isA<ShapeCalculationLoading>(),
        isA<ShapeCalculationFailure>().having((f) => f.message, 'message', contains('All dimensions')),
      ],
    );
  });
}
