import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }

}


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  var inputuser = '';
  var Result = '';
  void userinput(String Text){
    setState(() {
      inputuser += Text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(inputuser,
                        style: const TextStyle(fontSize: 28),
                        textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 5,),
                        Text(Result,
                        style: const TextStyle(fontSize: 62),
                        textAlign: TextAlign.end,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(20)
                    )
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _RowNumber('Ac','ce','%','/'),
                    _RowNumber('1','2','3','*'),
                    _RowNumber('4','5','6','-'),
                    _RowNumber('7','8','9','+'),
                    _RowNumber('00','0','.','='),
                  ],
                ),
                ),
              ),
            ],
          )
        ),
      );
  }
  Row _RowNumber(String Text1,String Text2, String Text3, String Text4) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: operatorBack(Text1),
                        shape: const CircleBorder(
                          side: BorderSide(width: 0,color: Colors.transparent)
                        )
                      ),
                      onPressed: (){
                        if(Text1 == 'Ac'){
                          setState(() {
                            Result = '';
                            inputuser = '';
                          });
                        }
                        else{
                          userinput(Text1);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Text1,
                        style: const TextStyle(fontSize: 30,color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: operatorBack(Text2),
                        shape: const CircleBorder(
                          side: BorderSide(width: 0,color: Colors.transparent)
                        )
                      ),
                      onPressed: (){
                        if( Text2 == 'ce'){
                          setState(() {
                            if(inputuser.length > 0){
                              inputuser = inputuser.substring(0,inputuser.length-1);
                            }
                            else{
                              inputuser = '';
                            }
                          });
                        }else{
                          userinput(Text2);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Text2,
                        style: const TextStyle(fontSize: 30,color: Colors.black),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: operatorBack(Text3),
                        shape: const CircleBorder(
                          side: BorderSide(width: 0,color: Colors.transparent)
                        )
                      ),
                      onPressed: (){
                        userinput(Text3);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Text3,
                        style: const TextStyle(fontSize: 30,color: Colors.black),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: operatorBack(Text4),
                        shape: const CircleBorder(
                          side: BorderSide(width: 0,color: Colors.transparent)
                        )
                      ),
                      onPressed: (){
                       if(Text4 == '='){
                        Parser parser = Parser();
                        Expression expression = parser.parse(inputuser);
                        ContextModel contextModel = ContextModel();
                        double result = expression.evaluate(EvaluationType.REAL, contextModel);
                        setState(() {
                          Result = result.toString();
                        });
                       }else{
                        userinput(Text4);
                       }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Text4,
                        style: const TextStyle(fontSize: 30,color: Colors.black),),
                      ),
                    ),
                  ),
                ],
              );
  }
  bool isoperator(String Text){
    var list = ['Ac','ce','%','/','*','-','+','='];
    for (var item in list) {
      if(item == Text){
        return true;
      }
    }
    return false;
  }
  Color operatorBack(String Text){
    if(isoperator(Text)){
      return Colors.white;
    }
    else{
      return Colors.grey;
    }
  }









}