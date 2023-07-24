import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleCalculator());
}

class SimpleCalculator extends StatelessWidget {
  const SimpleCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _buffer = "";
  String _operator = "";
  double _result = 0.0;

  void _onDigitPress(String digit) {
    setState(() {
      if (_output == "0") {
        _output = digit;
      } else {
        _output += digit;
      }
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      _buffer = _output;
      _output = "0";
      _operator = operator;
    });
  }

  void _onClearPress() {
    setState(() {
      _output = "0";
      _buffer = "";
      _operator = "";
      _result = 0.0;
    });
  }

  void _onEqualsPress() {
    double num1 = double.parse(_buffer);
    double num2 = double.parse(_output);

    switch (_operator) {
      case "+":
        _result = num1 + num2;
        break;
      case "-":
        _result = num1 - num2;
        break;
      case "x":
        _result = num1 * num2;
        break;
      case "/":
        _result = num1 / num2;
        break;
      default:
        _result = 0.0;
    }

    setState(() {
      _output = _result.toString();
      _buffer = "";
      _operator = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48.0),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("x"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: () {
            if (text == "C") {
              _onClearPress();
            } else if (text == "=") {
              _onEqualsPress();
            } else if (text == "+" ||
                text == "-" ||
                text == "x" ||
                text == "/") {
              _onOperatorPress(text);
            } else {
              _onDigitPress(text);
            }
          },
          fillColor: Colors.redAccent,
          padding: EdgeInsets.all(24.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
