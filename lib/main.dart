import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('calculator'),
        ),
        body: MainClass(),
      ),
    );
  }
}

class MainClass extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainClass> {
  String output = '0';

  String _output = '';
  double num1 = 0.0;
  double num2 = 0.0;
  String oprand = '0';
  String _num1 = '';
  String _num2 = '';

  buttonPressed(String buttonText) {
    if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '×' ||
        buttonText == '÷') {
      num1 = double.parse(_output);
      oprand = buttonText;
      _num1 = _output + oprand;
      _num2 = _num1;
      _output = '';
    } else if (buttonText == 'del') {
      _num1 = _num1.substring(0, _num1.length - 1);
      if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '×' ||
          buttonText == '÷') {
        _output = _num1;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (oprand == '+') {
        _num1 =
            (num1 + num2).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
        _output = _num1;
      }
      if (oprand == '-') {
        _num1 =
            (num1 - num2).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
        _output = _num1;
      }
      if (oprand == '×') {
        _num1 =
            (num1 * num2).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
        _output = _num1;
      }
      if (oprand == '÷') {
        _num1 =
            (num1 / num2).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
        _output = _num1;
      }
      num1 = 0;
      num2 = 0;
      oprand = '';
    } else if (buttonText == '.') {
      if (_num1.contains('.') && _output.contains('.')) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text('Decimal is already present'),
              );
            });
        //return;
      } else {
        _output = _output + buttonText;

        if (oprand == '+' || oprand == '-' || oprand == '×' || oprand == '÷') {
          _num1 = _num2 + _output;
        } else {
          _num1 = _output;
          _num2 = _num1;
        }
      }
    } else if (buttonText == 'clear') {
      _output = '';
      num1 = 0.0;
      num2 = 0.0;
      oprand = '';
      _num1 = '0';
      _num2 = '';
    } else {
      _output = _output + buttonText;

      if (oprand == '+' || oprand == '-' || oprand == '×' || oprand == '÷') {
        _num1 = _num2 + _output;
      } else {
        _num1 = _output;
        _num2 = _num1;
      }
    }

    setState(() {
      output = _num1;
    });
  }

  Widget buildButton(String buttonText, flex) {
    return Expanded(
        flex: flex,
        child: OutlineButton(
            padding: EdgeInsets.all(30.0),
            child: Text(
              '$buttonText',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              buttonPressed(buttonText);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 50.0, right: 20.0),
          alignment: Alignment.bottomRight,
          child: Text(
            '$output',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: Padding(padding: EdgeInsets.all(0))),
        Row(children: [
          buildButton('1', 1),
          buildButton('2', 1),
          buildButton('3', 1),
          buildButton('+', 1)
        ]),
        Row(children: [
          buildButton('4', 1),
          buildButton('5', 1),
          buildButton('6', 1),
          buildButton('-', 1)
        ]),
        Row(children: [
          buildButton('7', 1),
          buildButton('8', 1),
          buildButton('9', 1),
          buildButton('×', 1)
        ]),
        Row(children: [
          buildButton('00', 1),
          buildButton('0', 1),
          buildButton('.', 1),
          buildButton('÷', 1)
        ]),
        Row(children: [
          buildButton('clear', 2),
          buildButton('del', 1),
          buildButton('=', 1),
        ]),
      ],
    );
  }
}
