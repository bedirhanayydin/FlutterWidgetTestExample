// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_widget_test/calculator.dart';
import 'package:flutter_widget_test/custom_text.dart';
import 'package:flutter_widget_test/operation.dart';

class TwoDigitOperation extends StatefulWidget {
  Operation operation;
  Calculator calculator;
  TwoDigitOperation({
    Key? key,
    required this.operation,
    required this.calculator,
  }) : super(key: key);

  @override
  State<TwoDigitOperation> createState() => _TwoDigitOperationState();
}

class _TwoDigitOperationState extends State<TwoDigitOperation> {
  double a = 0;
  double b = 0;
  double toplam = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('textfield_top_plus'),
          onChanged: (value) {
            setState(() {
              a = double.tryParse(value) ?? 0.0;
            });
          },
        ),
        TextField(
          key: const Key('textfield_bottom_plus'),
          onChanged: (value) async {
            b = double.tryParse(value) ?? 0.0;
            toplam = await _calculate(a, b);
            setState(() {});
          },
        ),
        CustomText(text: toplam.toStringAsFixed(0)),
      ],
    );
  }

  Future<double> _calculate(double a, double b) async {
    double result;
    switch (widget.operation) {
      case Operation.add:
        result = widget.calculator.add(a, b);
        break;
      case Operation.substract:
        result = widget.calculator.substract(a, b);
        break;
      case Operation.divide:
        result = widget.calculator.divide(a, b);
        break;
      case Operation.powerTo:
        result = await widget.calculator.powerTo(a, b);
        break;
      default:
        result = widget.calculator.multiply(a, b);
    }
    return result;
  }
}
