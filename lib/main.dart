import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/App_Theme_Provider.dart';
import 'package:untitled15/Providers/Language_Provider.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
import 'package:untitled15/ui/Home/taps/profile/profile_Tap.dart';
import 'package:untitled15/ui/onBordingScreen/On_Bording_Screen2.dart';
import 'package:untitled15/ui/onBordingScreen/onBordingScreen1.dart';
import 'package:untitled15/utils/App_Theme.dart';
import 'package:untitled15/utils/shared_pref.dart';
import 'l10n/app_localizations.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.readLang();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
        ChangeNotifierProvider(create: (context) => AppThemeProvider(),)
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        ProfileTap.routeName:(context)=>ProfileTap(),
        Onbordingscreen.routeName:(context)=>Onbordingscreen(),
        OnBoardingPage.routeName:(context)=>OnBoardingPage(),
        HomeScreen.routeName:(context)=>HomeScreen()
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