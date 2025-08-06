import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
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

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController rePasswordController=TextEditingController();

  TextEditingController nameController=TextEditingController();

  var formKay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
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
    );
  }

  void createAccount()async{
    if(formKay.currentState?.validate()==true){
      // todo show loading
      DialogUtils.showLoading(context: context, loadingText: 'Loading....');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo save to firebase
        MyUser myUser=MyUser(
            id: credential.user?.uid??'',
            email: emailController.text,
            name: nameController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider=Provider.of<MyUserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
        eventListProvider.changeSelectedIndex(0, userProvider.myUser!.id);
        eventListProvider.getFilterEventFromFireStore(userProvider.myUser!.id);
        //todo hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
        DialogUtils.showMessage(
            title: 'Register',
            posActionName: 'ok',
            context: context,
            text: 'Register Sucsufly',
          posAction: (){
            Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false,);
          }
        );

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo hide loading
          DialogUtils.hideLoading(context: context);
          //todo show message
          DialogUtils.showMessage(
            posActionName: 'ok',
              context: context,
              text: 'weak-password');
        } else if (e.code == 'email-already-in-use') {
          //todo hide loading
          DialogUtils.hideLoading(context: context);
          //todo show message
          DialogUtils.showMessage(
            posActionName: 'ok',
              context: context,
              text: 'email-already-in-use');
        }
      } catch (e) {
        //todo hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
        DialogUtils.showMessage(
            context: context,
            text: '${e.toString()}');
      }
    }
  }
}
