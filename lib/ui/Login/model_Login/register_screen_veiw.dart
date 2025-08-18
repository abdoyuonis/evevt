import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled15/ui/Login/model_Login/Register_Navigator.dart';

class RegisterScreenView extends ChangeNotifier{
  // todo hold data   handel logic
late RegisterNavigator navigator;

  void register(String email,String password)async{
    // todo show loading
    navigator.showMyLoading('Loading...');
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //todo save to firebase
      // MyUser myUser=MyUser(
      //     id: credential.user?.uid??'',
      //     email: emailController.text,
      //     name: nameController.text);
      // await FirebaseUtils.addUserToFireStore(myUser);
      // var userProvider=Provider.of<MyUserProvider>(context, listen: false);
      // userProvider.updateUser(myUser);
      // var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
      // eventListProvider.changeSelectedIndex(0, userProvider.myUser!.id);
      // eventListProvider.getFilterEventFromFireStore(userProvider.myUser!.id);
      //todo hide loading
      navigator.hideMyLoading();
      //todo show message
      navigator.showMyMessage('Register successfully');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //todo hide loading
        navigator.hideMyLoading();
        //todo show message
        navigator.showMyMessage('weak-password');

      } else if (e.code == 'email-already-in-use') {
        //todo hide loading
        navigator.hideMyLoading();
        //todo show message
        navigator.showMyMessage('email-already-in-use');

      }
    } catch (e) {
      //todo hide loading
      navigator.hideMyLoading();
      //todo show message
      navigator.showMyMessage(e.toString());

    }

  }
}