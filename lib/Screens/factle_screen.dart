
import 'package:flutter/material.dart';
import 'package:my_app/Screens/yes_no_dialog.dart';
import 'package:provider/provider.dart';
import '../Providers/preferences.dart';
import 'menu_screen_drawer.dart';

class FactleScreen extends StatefulWidget {
  static const String routeName = '/factle_screen';

  @override
  State<FactleScreen> createState() => _FactleScreenState();
}

class _FactleScreenState extends State<FactleScreen> {
  List<String> correctOrder = ["1","2","3","4","5"];
  List<String> options = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"];
  List<List<String>> listOfRows = [["", "", "", "", ""],["", "", "", "", ""],["", "", "", "", ""],["", "", "", "", ""]];
  List<List<String>> listOfCorrects = [["E", "E", "E", "E", "E"],["E", "E", "E", "E", "E"],["E", "E", "E", "E", "E"],["E", "E", "E", "E", "E"]];
  int currentRow = 0;
  int currentPos = 0;
  Future<void> btnPress(String button) async {

    if (button == 'ENTER' && currentPos == 5){
      // TODO: API CALL
      int goodCounter = 0;
      setState(() {

        for (int i = 0; i < 5; i++){
          if (listOfRows[currentRow][i] == correctOrder[i]){
            listOfCorrects[currentRow][i] = "R";
            goodCounter+=1;
          }
          else if (correctOrder.contains(listOfRows[currentRow][i])){
            listOfCorrects[currentRow][i] = "RB";
          }
          else{
            listOfCorrects[currentRow][i] = "E";
          }
        }
        currentRow += 1;
        currentPos = 0;
      });
      if (goodCounter == 5){
          // TODO WIN
        await yesNoDialog(
              context: context,
              title: "You won the game!",
              content: "Congratulations!",
              onYes: (){});
      }
      else if (currentRow == 4 && goodCounter != 5){
        // TODO LOSE
         await yesNoDialog(
          context: context,
          title: "You lost the game!",
          content: "You are lame go learn some geography!",
          onYes: (){});
      }
    }
    else if (button == 'DELETE'){
      if (currentPos != 0){
        setState(() {
          listOfRows[currentRow][currentPos-1] = "";
          currentPos -= 1;
        });
      }
    }
    else if (button != 'ENTER' && button != 'DELETE'){
      if (currentPos <= 4 && !listOfRows[currentRow].contains(button) ){
        setState(() {
          listOfRows[currentRow][currentPos] = button;
          currentPos += 1;
        });
      }
    }
    return;
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<Preferences>(context);
    List<String> lastRowOfOptions = options.sublist(15,18);
    lastRowOfOptions.insert(0, "ENTER");
    lastRowOfOptions.insert(4, "DELETE");
    return Scaffold(
      drawer: MenuScreenDrawer(),
      appBar: AppBar(

        title: Text(
          'Factle',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children:  [
          const SizedBox(height: 20,),
          const Center(child: Text("Largest countries by land mass",style: TextStyle(fontSize: 25),)),
          const SizedBox(height: 20,),
          for (var i = 0; i < 4; i++)...[
            RowBoxes(values:listOfRows[i], correct:listOfCorrects[i]),
          ],
          const SizedBox( height:25),
          for (var i = 0; i <= 3; i++)...[
            i==3?RowButtons(values:lastRowOfOptions, callback:btnPress):
                RowButtons(values:options.sublist(i*5,i*5+5), callback:btnPress),
          ],



        ],
      )),
    );
  }
}

class RowButtons extends StatefulWidget {
  RowButtons({
    Key? key,
    required this.values,
    required this.callback,
  }) : super(key: key);

  final List<String> values;
  Function(String)? callback;
  @override
  State<RowButtons> createState() => _RowButtonsState();
}

class _RowButtonsState extends State<RowButtons> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double boxWidth = width * 0.85 / 5.0;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Row(
          children: [
            for (var i = 0; i < 5; i++)...[
              GestureDetector(
                onTap: (){
                  widget.callback!(widget.values[i]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(color: Colors.black, width: 2,),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  width: boxWidth,
                  height: boxWidth,
                  child: Center(

                      child: Text(widget.values[i],
                        style: const TextStyle(fontSize: 15),
                      )),
                ),
              ),
              if (i != 4)
                const Spacer(),
            ]
          ],
        ),
      ),
    );
  }
}


class RowBoxes extends StatefulWidget {

  RowBoxes({super.key,
  required this.values,
  required this.correct});

  final List<String> values;
  final List<String> correct;


  @override
  State<RowBoxes> createState() => _RowBoxesState();
}

class _RowBoxesState extends State<RowBoxes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double boxWidth = width * 0.85 / 5.0;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Row(
          children: [
            for (var i = 0; i < 5; i++)...[
              Container(
                decoration: BoxDecoration(
                  color: widget.correct[i] == "R"? Colors.green: widget.correct[i] == "RB"?Colors.amberAccent:Colors.white,
                  border: Border.all(color: Colors.black, width: 2,),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                width: boxWidth,
                height: boxWidth,
                child: Center(

                    child: Text(widget.values[i],
                style: const TextStyle(fontSize: 15),
                )),
              ),
              if (i != 4)
                const Spacer(),
              ]
          ],
        ),
      ),
    );
  }
}
