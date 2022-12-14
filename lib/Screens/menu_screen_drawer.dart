import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Screens/settings_screen.dart';

class MenuScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Menu',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigoAccent,
                ),
                child: const Icon(
                  CupertinoIcons.gear,
                  color: Colors.white,
                  size: 20,
                )),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigoAccent,
                ),
                child: const Icon(
                  CupertinoIcons.at,
                  color: Colors.white,
                  size: 20,
                )),
            title: Text(
              'Statistics',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigoAccent,
                ),
                child: const Icon(
                  CupertinoIcons.book,
                  color: Colors.white,
                  size: 20,
                )),
            title: Text(
              'History',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigoAccent,
                ),
                child: const Icon(
                  CupertinoIcons.capslock,
                  color: Colors.white,
                  size: 20,
                )),
            title: Text(
              'Leaderboard',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
        ],
      ),
    ));
  }
}
