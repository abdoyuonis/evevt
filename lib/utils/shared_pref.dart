import 'package:shared_preferences/shared_preferences.dart';
class SharedPref{
static String? lang;



  // todo write data
  static  saveLang(String newLang)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('local', newLang);

  }

  // todo read data
static Future<String?> readLang()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  lang = prefs.getString('local');
  return lang;
}

}

