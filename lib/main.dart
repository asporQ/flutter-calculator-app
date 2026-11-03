import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:flutter_calculate_app/button.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = "";
  var answer = "";

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 18, 
                        color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length, 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4
                ),
                itemBuilder: (BuildContext context, int index) {
                  
                  // C button
                  if (index == 0) {
                    return CalculatorButton(
                      buttontapped: () {
                        setState(() {
                          userInput = "";
                          answer = "0";
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue,
                      textColor: Colors.black,
                    );
                  }

                  // +/- button
                  else if (index == 1) {
                    return CalculatorButton(
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }

                  // % button
                  else if (index == 2) {
                    return CalculatorButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }

                  // del button
                  else if (index == 3) {
                    return CalculatorButton(
                      buttontapped: () {
                        setState(() {
                          userInput = userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }

                  // equal button 
                  else if (index == 18) {
                    return CalculatorButton(
                      buttontapped: () {
                        setState(() {
                          equalpressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }

                  // other button
                  else {
                    return CalculatorButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) 
                        ? Colors.blueAccent
                        : Colors.white,
                      textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.black,
                    );
                  }
                },
              ),
            )
          )
        ],
      )
    );
  }

  equalpressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll("x", '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }

  bool isOperator(String button) {
    if (button == '/' || button == 'x' || button == '+' || button == '-' || button == '=') {
      return true;
    }

    return false;
  }
}
