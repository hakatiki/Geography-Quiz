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
          'ADN Wallet',
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
                if(_checkDarkMode(context))
                  Image.asset('assets/images/adnovum-logo-dark-mode.png', width : 80, height :80),
                if(!_checkDarkMode(context))
                  Image.asset('assets/images/adnovum-logo.png', width : 80, height :80),
                Flexible(
                  flex: deviceSize.width > 600 ? 3 : 2,
                  child: AuthCard(),
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
