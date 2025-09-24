import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shape.dart';
import '../bloc/shape_calculation_bloc.dart';
import '../bloc/shape_calculation_event.dart';
import '../bloc/shape_calculation_state.dart';

class ShapeCalculationPage extends StatefulWidget {
  const ShapeCalculationPage({super.key});

  @override
  State<ShapeCalculationPage> createState() => _ShapeCalculationPageState();
}

class _ShapeCalculationPageState extends State<ShapeCalculationPage> {
  final _circleCtrl = TextEditingController(text: '3');
  final _triangleWidthCtrl = TextEditingController(text: '4');
  final _triangleHeightCtrl = TextEditingController(text: '5');
  final _squareSideCtrl = TextEditingController(text: '6');

  @override
  void dispose() {
    _circleCtrl.dispose();
    _triangleWidthCtrl.dispose();
    _triangleHeightCtrl.dispose();
    _squareSideCtrl.dispose();
    super.dispose();
  }

  int _parse(TextEditingController c) => int.tryParse(c.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shape Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _numberField('Circle radius', _circleCtrl),
            _numberField('Triangle width', _triangleWidthCtrl),
            _numberField('Triangle height', _triangleHeightCtrl),
            _numberField('Square side', _squareSideCtrl),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<ShapeCalculationBloc>().add(
                      ShapeCalculatePressed(
                        circleRadius: _parse(_circleCtrl),
                        triangleWidth: _parse(_triangleWidthCtrl),
                        triangleHeight: _parse(_triangleHeightCtrl),
                        squareSide: _parse(_squareSideCtrl),
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
        ),
      ),
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
  final dynamic summary; // dynamic to avoid circular import with summary type inference
  const _ResultView({required this.summary});

  @override
  Widget build(BuildContext context) {
    final shapes = summary.shapes as List<Shape>;
    final largest = summary.largest as Shape?;
    return ListView(
      children: [
        const Text('Areas:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...shapes.map((s) => Text('${s.name}: ${s.area()}')).toList(),
        const SizedBox(height: 12),
        Text('Largest: ${largest?.name ?? 'N/A'}'),
      ],
    );
  }
}
