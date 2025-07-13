import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
static ThemeMode appTheme = ThemeMode.light;




void changeTheme(ThemeMode newTheme){
  if(appTheme==newTheme){
    return;
  }else{
    appTheme=newTheme;
  }
  notifyListeners();
}
}