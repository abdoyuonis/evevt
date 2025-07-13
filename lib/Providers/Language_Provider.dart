import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier{
  static String appLanguage ='en';

  void changeLanguage(String newLanguage){
    if(newLanguage==appLanguage){
      return;
    }else{
      appLanguage=newLanguage;
    }
    notifyListeners();
  }
}