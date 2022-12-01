@GenerateNiceMocks([MockSpec<Calculator>()])
// Annotation which generates the cat.mocks.dart library and the MockCat class.
import 'dart:math';
// Annotation which generates the cat.mocks.dart library and the MockCat class.

// ignore: unused_import
import 'calculator.mocks.dart';
import 'package:mockito/annotations.dart';

class Calculator {
  double add(double a, double b) => a + b;

  double substract(double a, double b) => a - b;

  double multiply(double a, double b) => a * b;

  double divide(double a, double b) {
    if (b == 0.0) {
      throw ArgumentError('you can not divice by zero');
    }
    return a / b;
  }

  Future<double> powerTo(double a, double b) async {
    return Future.delayed(const Duration(seconds: 2), (() => pow(a, b).toDouble()));
  }

  Stream<double> pi() => Stream.fromIterable({3, 3.1, 3.14, 3.141, 3.1415});
}
