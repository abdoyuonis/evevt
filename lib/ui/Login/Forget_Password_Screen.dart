import 'package:flutter/material.dart';
import 'package:untitled15/ui/Login/Button_Widget.dart';
import 'package:untitled15/utils/App_Style.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName='Forget_Password';
   ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Forget Password'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: AssetImage('assets/images/PasswordLogo.png')),
          ButtonWidget(onPressed: (){},
          buttonChild: Text('Reset Password',style: AppStyle.midam20White,),
          )
        ],
      ),
    );
  }
}
