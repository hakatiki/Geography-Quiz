import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/preferences.dart';
import '../Widgets/Cards/settings_cards/dark_mode_settings_card.dart';
import '../Widgets/Cards/settings_cards/logout_settings_card.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings_screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Preferences>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 5),
          DarkModeSettingsCard(),
          const LogoutSettingsCard(key: Key('f'))
        ],
      )),
    );
  }
}
