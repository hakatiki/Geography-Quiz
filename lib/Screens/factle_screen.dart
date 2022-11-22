
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';
import '../Providers/preferences.dart';
import '../Widgets/Cards/settings_cards/dark_mode_settings_card.dart';
import '../Widgets/Cards/settings_cards/logout_settings_card.dart';
import 'menu_screen_drawer.dart';

class FactleScreen extends StatefulWidget {
  static const String routeName = '/factle_screen';

  @override
  State<FactleScreen> createState() => _FactleScreenState();
}

class _FactleScreenState extends State<FactleScreen> {
  List<List<String>> listOfRows = [["Hungary", "Russia", "DRC", "Germany", "United States"],["", "", "", "", ""],["", "", "", "", ""],["", "", "", "", ""]];
  List<List<String>> listOfCorrects = [["RB", "R", "E", "R", "E"],["E", "E", "E", "E", "E"],["E", "E", "E", "E", "E"],["E", "E", "E", "E", "E"]];
  int currentRow = 0;
  int currentPos = 0;
  void btnPress(String button){

    if (button == 'ENTER' && currentPos == 5){
      // TODO: API CALL

      setState(() {
        currentRow += 1;
        currentPos = 0;
      });
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
          const SizedBox(height: 10),
          const Center(child: Text("Factle",
            style: TextStyle(fontSize: 35),
          )),
          const SizedBox(height: 20,),
          const Center(child: Text("Largest countries by land mass",style: TextStyle(fontSize: 25),)),
          for (var i = 0; i < 4; i++)...[
            RowBoxes(values:listOfRows[i], correct:listOfCorrects[i]),
          ],
          const SizedBox( height:25),

          RowButtons(values:["Hungary", "Russia", "DRC", "Germany", "United States"], callback:btnPress),
          RowButtons(values:["1", "3", "5", "7", "9"], callback:btnPress),
          RowButtons(values:["2", "4", "6", "8", "10"], callback:btnPress),
          RowButtons(values:["ENTER", "Russia", "DRC", "Germany", "DELETE"], callback:btnPress),


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
