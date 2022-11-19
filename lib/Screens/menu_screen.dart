
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';
import '../Providers/preferences.dart';
import '../Widgets/Cards/settings_cards/dark_mode_settings_card.dart';
import '../Widgets/Cards/settings_cards/logout_settings_card.dart';
import 'menu_screen_drawer.dart';

class MenuScreen extends StatefulWidget {
  static const String routeName = '/menu_screen';

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Preferences>(context);
    return Scaffold(
      drawer: MenuScreenDrawer(),
      appBar: AppBar(

        title: Text(
          'Menu',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: const [
          SizedBox(height: 5),
          WordleStyleGameCard(name: 'Wordle', desc: "Press to play", nav: "TODO", color:  Color.fromRGBO(200, 210, 200, 1.0)),

          WordleStyleGameCard(name: 'Other_1', desc: "Press to play", nav: "TODO", color:  Color.fromRGBO(210, 210, 200, 1.0)),

          WordleStyleGameCard(name: 'Other_2', desc: "Press to play", nav: "TODO", color:  Color.fromRGBO(200, 210, 210, 1.0))


        ],
      )),
    );
  }
}

class WordleStyleGameCard  extends StatelessWidget  {
  const WordleStyleGameCard({
    required  this.name,
    required  this.desc,
    required  this.nav,
    required this.color,
  }) : super();
  final String name;
  final String desc;
  final String nav;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              // TODO: CHANGE ICON
              CupertinoIcons.xmark_seal,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            flex:4,
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    desc,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            // TODO: ADD NAVIGATION TO WORDLE STYLE GAME
            onPressed: () {Navigator.of(context).pushNamed(nav);},
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).errorColor),
            child: const Text('Play'),
          ),
        ],
      ),
    );
  }
}
