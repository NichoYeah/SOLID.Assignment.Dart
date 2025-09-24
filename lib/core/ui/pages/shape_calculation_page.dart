import 'package:flutter/material.dart';
import '../../../features/area_calculation/presentation/widgets/area_calculation_section.dart';

class ShapeCalculationPage extends StatefulWidget {
  const ShapeCalculationPage({super.key});

  @override
  State<ShapeCalculationPage> createState() => _ShapeCalculationPageState();
}

class _ShapeCalculationPageState extends State<ShapeCalculationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shape Calculator')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: AreaCalculationSection(),
      ),
    );
  }
}
