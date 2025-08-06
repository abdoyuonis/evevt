import 'package:flutter/widgets.dart';
import 'package:untitled15/utils/Model/my_user.dart';

class MyUserProvider extends ChangeNotifier{
  MyUser? myUser;


  void updateUser(MyUser newUser){
    myUser = newUser;
    notifyListeners();
  }
}