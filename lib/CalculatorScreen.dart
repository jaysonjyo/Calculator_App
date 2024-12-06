import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  String equation ="0";
  String expression ="";
  String result ="0";

  buttonpressed(buttontext) {
    setState(() {
      if (buttontext == "AC") {
        equation = "0";
        result = "0";
      } else if (buttontext == "⌫") {
        equation = equation.length > 1 ? equation.substring(0, equation.length - 1) : "0";
      } else if (buttontext == "=") {
        expression = equation.replaceAll("x", "*").replaceAll("÷", "/");
        try {
          if (expression.contains("/0")) {
            result = "Error";
          } else {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel ctm = ContextModel();
            double eval = exp.evaluate(EvaluationType.REAL, ctm);

            // Check if the evaluated result is an integer
            result = eval % 1 == 0 ? eval.toInt().toString() : eval.toString();
          }
        } catch (e) {
          result = "Error";
        }
      } else if (buttontext == "%") {
        // Treat % as a percentage of the current number
        if (equation.isNotEmpty && double.tryParse(equation) != null) {
          double value = double.parse(equation);
          result = "${value * 0.01}";
          equation = result;
        }
      } 
      else {
        equation = equation == "0" ? buttontext : equation + buttontext;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20), bottom: Radius.circular(50))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Container(
              width: double.infinity,
              height: 80,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Text(
                    equation,
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 80,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  result,
                  style: TextStyle(color: Colors.white, fontSize: 39),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               _calculatorbutton("AC", Colors.white, Colors.orange,75),
                _calculatorbutton("⌫", Colors.white, Colors.grey,75),
                _calculatorbutton("%", Colors.white, Colors.grey,75),
                _calculatorbutton("÷", Colors.white, Colors.orange,75)
        
              ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                _calculatorbutton("7", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("8", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("9", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("x", Colors.white, Colors.orange,75)
        
              ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                _calculatorbutton("4", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("5", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("6", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("-", Colors.white, Colors.orange,75)
        
              ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                _calculatorbutton("1", Colors.white, Colors.grey.shade800, 75),
                _calculatorbutton("2", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("3", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("+", Colors.white, Colors.orange,75)
        
              ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                _calculatorbutton("00", Colors.white, Colors.grey.shade800, 165),
                _calculatorbutton("0", Colors.white, Colors.grey.shade800,75),
                _calculatorbutton("=", Colors.white, Colors.orange,75)
        
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _calculatorbutton (String buttontext ,Color textcolor,Color buttoncolor, double buttonwidth){
    return   InkWell(
splashColor: Colors.white,
      borderRadius: BorderRadius.circular(28) ,
      onTap: (){
buttonpressed(buttontext);
      },
      child: Container(
        width: buttonwidth,
        height: 75,
        decoration: ShapeDecoration(
            color: buttoncolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
        child:  Center(child: Text(buttontext,style: TextStyle(color:textcolor,fontSize: 25),)),
      ),
    );
  }
}
