import 'package:flutter/material.dart';

import '../Widgets/Cards/auth_card.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Geography Quiz',
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor:Theme.of(context).bottomAppBarColor,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(16.0)),
               Flexible(
                  flex: deviceSize.width > 600 ? 3 : 2,
                  child: const AuthCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _checkDarkMode(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
