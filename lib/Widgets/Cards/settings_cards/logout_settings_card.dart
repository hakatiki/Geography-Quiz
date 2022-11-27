import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Screens/auth_screen.dart';
import 'package:provider/provider.dart';

import '../../../Providers/auth.dart';

class LogoutSettingsCard extends StatelessWidget {
  const LogoutSettingsCard({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.xmark_seal,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 4,
            child: Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    'Press the button to log out',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AuthScreen.routeName, (Route<dynamic> route) => false);
            },
            style:
                ElevatedButton.styleFrom(primary: Theme.of(context).errorColor),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
