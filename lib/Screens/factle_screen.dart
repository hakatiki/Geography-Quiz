
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
        children: const [
          SizedBox(height: 10),
          Center(child: Text("Factle",
            style: TextStyle(fontSize: 35),
          )),
          SizedBox(height: 10,),
          Center(child: Text("Largest countries by land mass",style: TextStyle(fontSize: 25),)),
          SizedBox( height:10),
          RowBoxes(values:["Hungary", "Russia", "DRC", "Germany", "United States"], correct:["W", "R", "RB", "W", "RB"]),
          RowBoxes(values:["", "", "", "", ""], correct:["E", "E", "E", "E", "E"]),
          RowBoxes(values:["", "", "", "", ""], correct:["E", "E", "E", "E", "E"]),
          RowBoxes(values:["", "", "", "", ""], correct:["E", "E", "E", "E", "E"]),
          SizedBox( height:25),


        ],
      )),
    );
  }
}

class RowBoxes extends StatefulWidget {

  const RowBoxes({super.key,
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
