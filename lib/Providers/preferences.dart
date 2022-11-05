
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier{
  final String themeModeId = 'themeModeId';
  final String defaultCurrencyId = 'applicationDefaultCurrency';

  bool _darkMode = false;
  Preferences(){
    getDarkMode();
  }
  Future<bool> getDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool(themeModeId)?? false;
    return _darkMode;
  }
  bool get isDark{
    return _darkMode;
  }
  Future<void> setDarkMode(bool value) async{
    _darkMode = value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeModeId, value);
    notifyListeners();
  }


}