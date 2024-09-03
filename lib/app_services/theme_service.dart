// import 'package:flutter/material.dart';


//
//
// class ThemeService{
//    final box = GetStorage();
//    final key = "isDarkMode";
//
//    _saveThemeToBox(bool isDarkMode)=>box.write(key, isDarkMode);
//    bool _loedThemeFromBox() => box.read(key)??false;
//    ThemeMode get theme => _loedThemeFromBox()?ThemeMode.dark:ThemeMode.light;
//
//    void switchTheme(){
//      Get.changeThemeMode(_loedThemeFromBox()?ThemeMode.light:ThemeMode.dark);
//      _saveThemeToBox(!_loedThemeFromBox());
//
//    }
// }