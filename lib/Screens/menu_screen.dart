import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Screens/factle_screen.dart';
import 'package:provider/provider.dart';

import '../Providers/preferences.dart';
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
        children: [
          SizedBox(height: 5),
          WordleStyleGameCard(
              name: 'Factle',
              desc: "Guess the right order!",
              nav: FactleScreen.routeName,
              color: (Provider.of<Preferences>(context, listen: false).isDark
                  ? Color.fromRGBO(30, 40, 50, 1.0)
                  : Color.fromRGBO(200, 210, 200, 1.0))),
          WordleStyleGameCard(
              name: 'Wordle',
              desc: "Guess the country by its shape!",
              nav: FactleScreen.routeName,
              color: (Provider.of<Preferences>(context, listen: false).isDark
                  ? Color.fromRGBO(35, 45, 30, 1.0)
                  : Color.fromRGBO(210, 210, 200, 1.0))),
          WordleStyleGameCard(
              name: 'Tradle',
              desc: "Which country exports these products?",
              nav: FactleScreen.routeName,
              color: (Provider.of<Preferences>(context, listen: false).isDark
                  ? Color.fromRGBO(20, 60, 54, 1.0)
                  : Color.fromRGBO(205, 215, 215, 1.0))),
          WordleStyleGameCard(
              name: 'Flagle',
              desc: "Guess the country based on the flag!",
              nav: FactleScreen.routeName,
              color: (Provider.of<Preferences>(context, listen: false).isDark
                  ? Color.fromRGBO(35, 45, 55, 1.0)
                  : Color.fromRGBO(200, 190, 180, 1.0))),
        ],
      )),
    );
  }
}

class WordleStyleGameCard extends StatelessWidget {
  const WordleStyleGameCard({
    required this.name,
    required this.desc,
    required this.nav,
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
            flex: 4,
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
            onPressed: () {
              Navigator.of(context).pushNamed(nav);
            },
            style:
                ElevatedButton.styleFrom(primary: Theme.of(context).errorColor),
            child: const Text('Play'),
          ),
        ],
      ),
    );
  }
}
