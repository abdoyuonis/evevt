import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/App_Theme_Provider.dart';
import 'package:untitled15/Providers/Language_Provider.dart';
import 'package:untitled15/Providers/My_User_Provider.dart';
import 'package:untitled15/Providers/event_list_provider.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Add_Events.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Edit_Event.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Event_Details.dart';
import 'package:untitled15/ui/Home/taps/profile/profile_Tap.dart';
import 'package:untitled15/ui/Login/Forget_Password_Screen.dart';
import 'package:untitled15/ui/Login/Login_Screen.dart';
import 'package:untitled15/ui/Login/Register_Screen.dart';
import 'package:untitled15/ui/onBordingScreen/On_Bording_Screen2.dart';
import 'package:untitled15/ui/onBordingScreen/onBordingScreen1.dart';
import 'package:untitled15/utils/App_Theme.dart';
import 'package:untitled15/utils/shared_pref.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? langCode = await SharedPref.readLang();
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(

      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
        ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
        ChangeNotifierProvider(create: (context) => EventListProvider(),),
        ChangeNotifierProvider(create: (context) => MyUserProvider(),)
      ],
      child: MyApp( langcode: langCode ?? 'en',)));
}

class MyApp extends StatelessWidget{
  String langcode;
  MyApp({super.key, required this.langcode});
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        ProfileTap.routeName:(context)=>ProfileTap(),
        Onbordingscreen.routeName:(context)=>Onbordingscreen(),
        OnBoardingPage.routeName:(context)=>OnBoardingPage(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        ForgetPasswordScreen.routeName:(context)=>ForgetPasswordScreen(),
        AddEvents.routeName:(context)=>AddEvents(),
        EventDetails.routeName:(context)=>EventDetails(),
         EditEvent.routeName:(context)=>EditEvent(),
      },
      locale: Locale(AppLanguageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppThemeProvider.appTheme,
    );
  }
}