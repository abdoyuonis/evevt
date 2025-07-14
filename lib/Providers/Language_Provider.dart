import 'package:flutter/material.dart';
import 'package:untitled15/utils/shared_pref.dart';

class AppLanguageProvider extends ChangeNotifier{
  static String appLanguage ='en';

  void changeLanguage(String newLanguage){
    if(newLanguage==appLanguage){
      return;
    }else{
      appLanguage=newLanguage;
    }
    SharedPref.saveLang(newLanguage);
    notifyListeners();
  }
}