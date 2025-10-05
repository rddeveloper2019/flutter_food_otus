import 'package:flutter_food_otus/main.dart';
import 'package:test/test.dart';

void main() {
  group('Expression evaluator tests', () {
    test('10*5+4/2-1 should return 51', () {
      expect(evaluator('10*5+4/2-1', {}), equals(51));
    });

    test('(x*3-5)/5 with x=10 should return 5', () {
      expect(evaluator('(x*3-5)/5', {'x': 10}), equals(5));
    });

    test('3*x+15/(3+2) with x=10 should return 33', () {
      expect(evaluator('3*x+15/(3+2)', {'x': 10}), equals(33));
    });

    test('Unary minus before numbers: -5 + -5 should return -10', () {
      expect(evaluator('-5 + -5', {}), equals(-10));
    });

    test('-2*x + 5*y + 100 with x=2, y=-5 should return 71', () {
      expect(evaluator('-2*x+5*y+100', {'x': 2, 'y': -5}), equals(71));
    });

    test('Division by zero should throw ArgumentError', () {
      expect(
        () => evaluator('10/0', {}),
        throwsA(TypeMatcher<ArgumentError>()),
      );
    });

    test('Undefined variable should throw ArgumentError', () {
      expect(
        () => evaluator('x + 5', {}),
        throwsA(TypeMatcher<ArgumentError>()),
      );
    });
  });
}
