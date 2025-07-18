import 'package:flutter/material.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
import 'package:untitled15/ui/Login/Button_Widget.dart';
import 'package:untitled15/ui/Login/Forget_Password_Screen.dart';
import 'package:untitled15/ui/Login/Form_Fild_Widgit.dart';
import 'package:untitled15/ui/Login/Register_Screen.dart';
import 'package:untitled15/ui/Widgit/Languge_Change_Widgwt.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login_Screen';

   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  var formKay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Column(
              children: [
                Form(
                    key: formKay,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: height*.04,),
                    Image(image: AssetImage('assets/images/Logo2.png'),height: height*0.19,),
                    FormFieldWidgit(
                      textHint: 'Email',
                      iconPrefix: Icon(Icons.email,color: Colors.grey,),
                      controller: emailController ,
                      validator: (text) {
                        if(text==null||text.trim().isEmpty){
                          return 'Please enter email';
                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text.trim());
                        if(!emailValid){
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                      kayBordTayb: TextInputType.emailAddress,
                    ),
                    SizedBox(height: height*.01,),
                    FormFieldWidgit(
                      obscurText: true,
                      textHint: 'Password',
                      iconPrefix: Icon(Icons.lock,color: Colors.grey,),
                      iconSuffix: IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_sharp,color: Colors.grey,)),
                      controller: passwordController,
                      validator: (text) {
                        if(text==null||text.trim().isEmpty){
                          return 'Please enter Password';
                        }
                        if(text.length<6){
                          return 'Password must be at 6 chars';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height*.01,),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(ForgetPasswordScreen.routeName);
                      },
                          child: Text('Forget Password?',style: AppStyle.bold20bPrimary.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.underline,decorationColor: AppColors.primaryColor
                          ),)),
                    ),
                    SizedBox(height: height*.01,),
                    ButtonWidget(onPressed: login,
                      buttonChild: Text('Login',style: AppStyle.midam16white,),),
                    SizedBox(height: height*.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t Have Account ?',style: AppStyle.bold20black.copyWith(fontSize: 16),),
                        TextButton(onPressed: (){
                          Navigator.of(context).pushNamed(RegisterScreen.routeName);
                        },
                            child: Text('Create Account',style: AppStyle.bold20bPrimary.copyWith(
                                fontSize: 16,
                                decoration: TextDecoration.underline,decorationColor: AppColors.primaryColor
                            ),)),
                      ],
                    ),
                    SizedBox(height: height*.01,),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 15,
                            endIndent: 15,
                            height: 2,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text('Or',style: AppStyle.midam16Black.copyWith(color: AppColors.primaryColor),),
                        Expanded(
                          child: Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 2,
                            color: AppColors.primaryColor,
                          ),
                        ),

                      ],
                    ),
                    ButtonWidget(onPressed: (){},
                      colorBg: Colors.transparent,
                      buttonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/images/googleImage.png')),
                          SizedBox(width: width*.03,),
                          Text('Login With Google',style: AppStyle.midam20Primary,)
                        ],
                      ),
                    ),
                    SizedBox(height: height*.02,),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContinarChangeLanguge(),
                  ],
                )
              ],
            ),
        ),
        ),

    );
  }

  void login(){
    if(formKay.currentState?.validate()==true){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
