int evaluator(String expression, Map variables) {
  if (expression.isEmpty) {
    throw ArgumentError('Empty expression');
  }

  String processed = expression;

  for (final entry in variables.entries) {
    String key = entry.key.toString();
    if (key.length != 1 || !RegExp(r'^[A-Za-z]$').hasMatch(key)) {
      throw ArgumentError('Invalid variable name: $key');
    }
    if (entry.value is num) {
      num val = entry.value;
      if (val != val.toInt()) {
        throw ArgumentError('Non-integer value for variable $key');
      }
      int intVal = val.toInt();
      String replacement = intVal < 0 ? '(0$intVal)' : intVal.toString();
      processed = processed.replaceAllMapped(
        RegExp('(?<![A-Za-z0-9])${RegExp.escape(key)}(?![A-Za-z0-9])'),
        (_) => replacement,
      );
    } else {
      throw ArgumentError('Invalid value type for variable $key');
    }
  }

  if (RegExp(r'[A-Za-z]').hasMatch(processed)) {
    throw ArgumentError('Undefined variable in expression');
  }

  processed = _handleUnaryMinus(processed);

  if (!_isValidBrackets(processed)) {
    throw ArgumentError('Mismatched brackets');
  }

  processed = processed.replaceAll(' ', '');

  return _evaluate(processed);
}

String _handleUnaryMinus(String s) {
  s = s.replaceAll(' ', '');
  s = s.replaceAll(RegExp(r'(?<=^|[+\-*/^(])\+'), '');

  bool changed;
  do {
    changed = false;
    s = s.replaceAllMapped(RegExp(r'(^|[+\-*/^(])-([0-9]+|\()'), (match) {
      changed = true;
      String prefix = match.group(1)!;
      String operand = match.group(2)!;
      if (operand == '(') {
        int depth = 1;
        int start = match.end - 1 + 1;
        int pos = start;
        while (pos < s.length && depth > 0) {
          if (s[pos] == '(')
            depth++;
          else if (s[pos] == ')')
            depth--;
          pos++;
        }
        if (depth != 0) {
          throw ArgumentError('Mismatched brackets');
        }
        String inner = s.substring(start, pos - 1);
        return '${prefix}(0-($inner))';
      } else {
        return '${prefix}(0-${operand})';
      }
    });
  } while (changed);

  return s;
}

bool _isValidBrackets(String s) {
  int balance = 0;
  for (int i = 0; i < s.length; i++) {
    if (s[i] == '(')
      balance++;
    else if (s[i] == ')') {
      balance--;
      if (balance < 0) return false;
    }
  }
  return balance == 0;
}

int _evaluate(String expr) {
  List<int> values = [];
  List<String> ops = [];

  for (int i = 0; i < expr.length; i++) {
    String c = expr[i];
    if (c == ' ') continue;

    if (c == '(') {
      ops.add(c);
    } else if (c == ')') {
      while (ops.isNotEmpty && ops.last != '(') {
        _applyOp(ops, values);
      }
      if (ops.isEmpty) throw ArgumentError('Mismatched brackets');
      ops.removeLast();
    } else if (expr.codeUnitAt(i) >= '0'.codeUnitAt(0) &&
        expr.codeUnitAt(i) <= '9'.codeUnitAt(0)) {
      int num = 0;
      while (i < expr.length) {
        int code = expr.codeUnitAt(i);
        if (code >= '0'.codeUnitAt(0) && code <= '9'.codeUnitAt(0)) {
          num = num * 10 + (code - '0'.codeUnitAt(0));
          i++;
        } else {
          break;
        }
      }
      values.add(num);
      i--;
    } else if ('+-*/^'.contains(c)) {
      while (ops.isNotEmpty &&
          ops.last != '(' &&
          _precedence(ops.last) >= _precedence(c)) {
        _applyOp(ops, values);
      }
      ops.add(c);
    } else {
      throw ArgumentError('Invalid character: $c');
    }
  }

  while (ops.isNotEmpty) {
    _applyOp(ops, values);
  }

  if (values.length != 1) throw ArgumentError('Invalid expression');
  return values[0];
}

int _precedence(String op) {
  switch (op) {
    case '^':
      return 3;
    case '*':
    case '/':
      return 2;
    case '+':
    case '-':
      return 1;
    default:
      return 0;
  }
}

void _applyOp(List<String> ops, List<int> values) {
  if (ops.isEmpty || values.length < 2) {
    throw ArgumentError('Invalid expression');
  }
  String op = ops.removeLast();
  int b = values.removeLast();
  int a = values.removeLast();
  int res;
  switch (op) {
    case '+':
      res = a + b;
      break;
    case '-':
      res = a - b;
      break;
    case '*':
      res = a * b;
      break;
    case '/':
      if (b == 0) throw ArgumentError('Division by zero');
      res = a ~/ b;
      break;
    case '^':
      if (b < 0) throw ArgumentError('Negative exponent not allowed');
      if (a == 0 && b == 0) throw ArgumentError('0^0 is undefined');
      res = 1;
      for (int i = 0; i < b; i++) res *= a;
      break;
    default:
      throw ArgumentError('Unknown operator: $op');
  }
  values.add(res);
}

void testEvaluator(String expr, Map values, num expected) {
  try {
    num result = evaluator(expr, values);
    String expectedStr = expected is int
        ? expected.toString()
        : expected.toStringAsFixed(1);
    print(
      'Expression: "$expr" -> Result: $result (Expected: $expectedStr) ${result == expected ? '✅' : '❌'}',
    );
  } catch (e) {
    print('Expression: "$expr" -> Exception thrown: $e ❌');
  }
}

void testException(String expr, Map values) {
  try {
    evaluator(expr, values);
    print('Expression: "$expr" -> No exception ❌');
  } catch (e) {
    print('Expression: "$expr" -> Exception caught as expected ✅');
  }
}

main() {
  testEvaluator('-1+10-3*2', {}, 3);
  testEvaluator('10+20*30+2^3+26-2+4', {}, 646);
  testEvaluator('10+20*30+2^3+(2*3+5*(6-2))', {}, 644);
  testEvaluator('-5+10*x-2*x+6', {'x': 10.0}, 81);
  testEvaluator('-2*x+5*y+100', {'x': 2.0, 'y': -5.0}, 71);
  testEvaluator('5/2', {}, 2);
  testException('(10+5', {});
  testException('', {});
  testException('y+10', {});
  testException('2*x+sin(x)', {});
  testException('12/0', {});
}
