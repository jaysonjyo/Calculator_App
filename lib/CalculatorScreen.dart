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
  buttonpressed(buttontext){
    setState(() {
      if(buttontext=="AC"){
equation="0";
result="0";
      }else if(buttontext== "⌫"){
equation=equation.substring(0,equation.length-1);
if(equation==""){
  equation="0";
}
      }else if(buttontext=="="){
        expression=equation;
        expression=expression.replaceAll("x", "*");
        expression=expression.replaceAll("÷", "/");
        try{

          Parser p = Parser();
          Expression exp= p.parse(expression);
          ContextModel ctm = ContextModel();
          result ="${exp.evaluate(EvaluationType.REAL, ctm)}";
        }
            catch(e){
          "Error";

            }

      }else{
        if(equation == "0"){
equation=buttontext;
        }else
equation= equation+buttontext;
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
      body: Column(
        children: [
          SizedBox(
            height: 80,
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
          SizedBox(
            height: 10,
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
    );
  }
  Widget _calculatorbutton (String buttontext ,Color textcolor,Color buttoncolor, double buttonwidth){
    return   InkWell(

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
