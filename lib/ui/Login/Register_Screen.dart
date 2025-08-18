import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
import 'package:untitled15/ui/Login/model_Login/Register_Navigator.dart';
import 'package:untitled15/ui/Login/model_Login/register_screen_veiw.dart';
import 'package:untitled15/utils/Firebase_Utils.dart';
import 'package:untitled15/utils/Model/my_user.dart';
import 'package:untitled15/utils/dailod_Utils.dart';

import '../../Providers/My_User_Provider.dart';
import '../../Providers/event_list_provider.dart';
import '../../utils/App_Color.dart';
import '../../utils/App_Style.dart';
import '../Widgit/Languge_Change_Widgwt.dart';
import 'Button_Widget.dart';
import 'Form_Fild_Widgit.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController rePasswordController=TextEditingController();

  TextEditingController nameController=TextEditingController();

  var formKay = GlobalKey<FormState>();

  RegisterScreenView viewModel = RegisterScreenView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Register'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: formKay,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height*.04,),
                      Image(image: AssetImage('assets/images/Logo2.png'),height: height*0.19,),
                      SizedBox(height: height*.01,),
                      FormFieldWidgit(
                          controller: nameController,
                        iconPrefix: Icon(Icons.person,color: Colors.grey,),
                        textHint: 'Name',
                        validator: (text) {
                          if(text==null||text.trim().isEmpty){
                            return 'Please enter valid name';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: height*.01,),
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
                        maxLine: 1,
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
                      FormFieldWidgit(
                        maxLine: 1,
                        obscurText: true,
                        textHint: 'Re_Password',
                        iconPrefix: Icon(Icons.lock,color: Colors.grey,),
                        iconSuffix: IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_sharp,color: Colors.grey,)),
                        controller: rePasswordController,
                        validator: (text) {
                          if(text!=passwordController.text){
                            return "re_Password doesn't match Password ";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height*.01,),
                      ButtonWidget(onPressed: createAccount,
                        buttonChild: Text('Create Account',style: AppStyle.midam20White,),),
                      SizedBox(height: height*.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already Have Account ?',style: AppStyle.bold20black.copyWith(fontSize: 16),),
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          },
                              child: Text('Login',style: AppStyle.bold20bPrimary.copyWith(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,decorationColor: AppColors.primaryColor
                              ),)),
                        ],
                      ),
                      SizedBox(height: height*.01,),


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



  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showMyLoading(String message) {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context: context, loadingText: message);
  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(context: context, text: message,
    posActionName: 'ok');
  }


  void createAccount()async{
    if(formKay.currentState?.validate()==true) {
      viewModel.register(emailController.text, passwordController.text);
    }
  }
}
