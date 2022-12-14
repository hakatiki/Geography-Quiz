import 'package:flutter/material.dart';
import 'package:my_app/Screens/auth_screen.dart';
import 'package:my_app/Screens/factle_screen.dart';
import 'package:my_app/Screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'Providers/auth.dart';
import 'Providers/preferences.dart';
import 'Screens/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => Preferences(),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => Auth(),
              )
            ],
            child: Consumer<Preferences>(
                builder: (context, preferences, child) => FutureBuilder(
                    future: preferences.getDarkMode(),
                    builder: (context, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MaterialApp(
                            title: 'GeoQuiz',
                            theme: ThemeData.light().copyWith(
                              brightness: Brightness.light,
                              appBarTheme: const AppBarTheme(
                                backgroundColor: Colors.white,
                                iconTheme: IconThemeData(color: Colors.black),
                              ),
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              cardColor: Colors.white,
                              backgroundColor: Colors.white,
                              scaffoldBackgroundColor:
                                  const Color.fromRGBO(240, 240, 240, 1),
                              textTheme: const TextTheme(
                                headline3: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                subtitle1:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                subtitle2: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                headline5: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                bodyText2: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                button: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            darkTheme: ThemeData.dark().copyWith(
                              primaryColor: Colors.blue,
                              brightness: Brightness.dark,
                              floatingActionButtonTheme:
                                  const FloatingActionButtonThemeData(
                                      backgroundColor: Colors.blue),
                              textTheme: const TextTheme(
                                // For appbars
                                headline3: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                // For forms
                                headline5: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                bodyText2: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                subtitle1:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                subtitle2: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                button: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            themeMode: preferences.isDark
                                ? ThemeMode.dark
                                : ThemeMode.light,
                            home: AuthScreen(),
                            routes: {
                                AuthScreen.routeName: (ctx) => AuthScreen(),
                                SettingsScreen.routeName: (ctx) =>
                                    SettingsScreen(),
                                MenuScreen.routeName: (ctx) => MenuScreen(),
                                FactleScreen.routeName: (ctx) => FactleScreen(),
                              })))));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'BOooty:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
