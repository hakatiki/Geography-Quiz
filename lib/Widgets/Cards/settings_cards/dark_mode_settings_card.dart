import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/preferences.dart';

class DarkModeSettingsCard extends StatefulWidget {
  @override
  _DarkModeSettingsCardState createState() => _DarkModeSettingsCardState();
}

class _DarkModeSettingsCardState extends State<DarkModeSettingsCard> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    _switchValue = Provider.of<Preferences>(context).isDark;
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
              CupertinoIcons.moon_stars,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 4,
            child: Container(
              //width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dark mode',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    'Toggle to change theme of the application',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) => _onChanged(value),
                )
              : Switch(
                  value: _switchValue,
                  onChanged: (value) => _onChanged(value),
                ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  void _onChanged(value) {
    Provider.of<Preferences>(context, listen: false).setDarkMode(value);
    setState(() {
      _switchValue = value;
    });
  }
}
