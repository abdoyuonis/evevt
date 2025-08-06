import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/My_User_Provider.dart';
import 'package:untitled15/Providers/event_list_provider.dart';
import 'package:untitled15/l10n/app_localizations.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
import 'package:untitled15/ui/Login/Button_Widget.dart';
import 'package:untitled15/ui/Login/Forget_Password_Screen.dart';
import 'package:untitled15/ui/Login/Form_Fild_Widgit.dart';
import 'package:untitled15/ui/Login/Register_Screen.dart';
import 'package:untitled15/ui/Widgit/Languge_Change_Widgwt.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';
import 'package:untitled15/utils/Firebase_Utils.dart';
import 'package:untitled15/utils/dailod_Utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login_Screen';

   const LoginScreen({super.key});

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
                      textHint: AppLocalizations.of(context)!.email,
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
                      textHint: AppLocalizations.of(context)!.password,
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
                          child: Text('${AppLocalizations.of(context)!.forget_Password}?',style: AppStyle.bold20bPrimary.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.underline,decorationColor: AppColors.primaryColor
                          ),)),
                    ),
                    SizedBox(height: height*.01,),
                    ButtonWidget(onPressed: login,
                      buttonChild: Text(AppLocalizations.of(context)!.login,style: AppStyle.midam16white,),),
                    SizedBox(height: height*.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${AppLocalizations.of(context)!.dont_have} ?',style: AppStyle.bold20black.copyWith(fontSize: 16),),
                        TextButton(onPressed: (){
                          Navigator.of(context).pushNamed(RegisterScreen.routeName);
                        },
                            child: Text(AppLocalizations.of(context)!.create_Aco,style: AppStyle.bold20bPrimary.copyWith(
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
                        Text(AppLocalizations.of(context)!.or,style: AppStyle.midam16Black.copyWith(color: AppColors.primaryColor),),
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
                    ButtonWidget(onPressed: signInWithGoogle,
                      colorBg: Colors.transparent,
                      buttonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/images/googleImage.png')),
                          SizedBox(width: width*.03,),
                          Text(AppLocalizations.of(context)!.login_with_google,style: AppStyle.midam20Primary,)
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

  void login()async{
    if(formKay.currentState?.validate()==true){
      //todo show loading
      DialogUtils.showLoading(context: context, loadingText: 'loading');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        //todo read user from fireStore
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user==null){
          return;
        }
        var userProvider=Provider.of<MyUserProvider>(context, listen: false);
        var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
        if(userProvider.myUser!=null){
          eventListProvider.changeSelectedIndex(0, userProvider.myUser!.id);
          eventListProvider.getFilterEventFromFireStore(userProvider.myUser!.id);
        }


        userProvider.updateUser(user);
        eventListProvider.getAllEvent(userProvider.myUser!.id);
        eventListProvider.changeSelectedIndex(0, userProvider.myUser!.id);
        //todo hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
        DialogUtils.showMessage(
            context: context,
            text: 'Login Sucssflay',
        posActionName: 'ok',
        posAction: (){
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
        );

      }


      on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo hide loading
          DialogUtils.hideLoading(context: context);
          //todo show message
          DialogUtils.showMessage(
            posActionName: 'ok',
              context: context,
              text: 'No user found for that email or wrong password.');
          print('No user found for that email or wrong password.');
        } else if (e.code == 'network-request-failed') {
          //todo hide loading
          DialogUtils.hideLoading(context: context);
          //todo show message
          DialogUtils.showMessage(
            posActionName: 'ok',
              context: context,
              text: 'no network');
          print('no network');
        }
      }
      catch(e){
        //todo hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
        DialogUtils.showMessage(
            context: context,
            text: '${e.toString()}');
        print(e.toString());
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
