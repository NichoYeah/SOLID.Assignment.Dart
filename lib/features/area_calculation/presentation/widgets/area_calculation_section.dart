import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shape.dart';
import '../bloc/shape_calculation_bloc.dart';
import '../bloc/shape_calculation_event.dart';
import '../bloc/shape_calculation_state.dart';

class AreaCalculationSection extends StatefulWidget {
  const AreaCalculationSection({super.key});

  @override
  State<AreaCalculationSection> createState() => _AreaCalculationSectionState();
}

class _AreaCalculationSectionState extends State<AreaCalculationSection> {
  final _circleCtrl = TextEditingController(text: '3');
  final _triangleWidthCtrl = TextEditingController(text: '4');
  final _triangleHeightCtrl = TextEditingController(text: '5');

  @override
  void dispose() {
    _circleCtrl.dispose();
    _triangleWidthCtrl.dispose();
    _triangleHeightCtrl.dispose();
    super.dispose();
  }

  int _parse(TextEditingController c) => int.tryParse(c.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _numberField('Circle radius', _circleCtrl),
        _numberField('Triangle width', _triangleWidthCtrl),
        _numberField('Triangle height', _triangleHeightCtrl),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            context.read<ShapeCalculationBloc>().add(
                  ShapeCalculatePressed(
                    circleRadius: _parse(_circleCtrl),
                    triangleWidth: _parse(_triangleWidthCtrl),
                    triangleHeight: _parse(_triangleHeightCtrl),
                  ),
                );
          },
          child: const Text('Compute'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<ShapeCalculationBloc, ShapeCalculationState>(
            builder: (context, state) {
              switch (state) {
                case ShapeCalculationInitial():
                  return const Text('Enter values and press Compute.');
                case ShapeCalculationLoading():
                  return const Center(child: CircularProgressIndicator());
                case ShapeCalculationSuccess(:final summary):
                  return _ResultView(summary: summary);
                case ShapeCalculationFailure(:final message):
                  return Text('Error: $message', style: const TextStyle(color: Colors.red));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _numberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  final dynamic summary;
  const _ResultView({required this.summary});

  @override
  Widget build(BuildContext context) {
    final shapes = summary.shapes as List<Shape>;
    final largest = summary.largest as Shape?;
    return ListView(
      children: [
        const Text('Areas:', style: TextStyle(fontWeight: FontWeight.bold)),
  ...shapes.map((s) => Text('${s.name}: ${s.area()}')),
        const SizedBox(height: 12),
        Text('Largest: ${largest?.name ?? 'N/A'}'),
      ],
    );
  }
}
