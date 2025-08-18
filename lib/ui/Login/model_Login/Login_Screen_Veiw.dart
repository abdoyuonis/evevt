import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled15/ui/Login/model_Login/Login_Navigator.dart';

class LoginScreenView extends ChangeNotifier{
  //todo hold data   handel logic
  var emailController= TextEditingController(text: 'abdo10@gmail.com');
  var passwordController= TextEditingController(text: '123456');
  late LoginNavigator navigator ;
  var formKay = GlobalKey<FormState>();


  void login()async{
    if(formKay.currentState?.validate()==true){
    //todo show loading
    navigator.showMyLoading('loading');
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      //todo read user from fireStore
      // var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
      // if(user==null){
      //   return;
      // }
      // var userProvider=Provider.of<MyUserProvider>(context, listen: false);
      // var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
      // if(userProvider.myUser!=null){
      //   eventListProvider.changeSelectedIndex(0, userProvider.myUser!.id);
      //   eventListProvider.getFilterEventFromFireStore(userProvider.myUser!.id);
      // }


      // userProvider.updateUser(user);
      // eventListProvider.getAllEvent(userProvider.myUser!.id);
      // eventListProvider.changeSelectedIndex(0, userProvider.myUser!.id);
      //todo hide loading
      navigator.hideMyMessage();
      //todo show message
      navigator.showMyMessage('Login Sucssflay');


    }


    on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        //todo hide loading
        navigator.hideMyMessage();
        //todo show message
        navigator.showMyMessage('No user found for that email or wrong password.');

      } else if (e.code == 'network-request-failed') {
        //todo hide loading
        navigator.hideMyMessage();
        //todo show message
        navigator.showMyMessage('no network');
      }
    }
    catch(e){
      //todo hide loading
      navigator.hideMyMessage();
      //todo show message
      navigator.showMyMessage(e.toString());

    }
  }
  }
}