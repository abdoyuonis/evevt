import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/App_Theme_Provider.dart';
import 'package:untitled15/Providers/Language_Provider.dart';
import 'package:untitled15/Providers/My_User_Provider.dart';
import 'package:untitled15/l10n/app_localizations.dart';
import 'package:untitled15/ui/Login/Login_Screen.dart';
import 'package:untitled15/ui/Widgit/BOttum_Shets.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';

import '../../../Widgit/Theme_Shet.dart';

class ProfileTap extends StatefulWidget {
  static const String routeName='Profile_Tap';
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<AppLanguageProvider>(context);
    var user = Provider.of<MyUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70)
          )
        )
        ,toolbarHeight: 159,
        backgroundColor: AppColors.primaryColor,
        title: Row(
          children: [
             Image(image: AssetImage(AppImages.route)),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.myUser!.name,style: AppStyle.bold24White,),
                Text(user.myUser!.email,style: AppStyle.midam16white,)
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,style: AppStyle.bold20black,),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2
                ),
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: InkWell(
                onTap: () => showLanguageBottomSheet(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLanguageProvider.appLanguage=='en'?
                    Text(AppLocalizations.of(context)!.english,style: AppStyle.bold20bPrimary,):
                    Text(AppLocalizations.of(context)!.arabic,style: AppStyle.bold20bPrimary,),

                    Icon(Icons.arrow_drop_down,color: AppColors.primaryColor,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text(AppLocalizations.of(context)!.theme,style: AppStyle.bold20black,),


            InkWell(
              onTap: ()=>showThemeBottomSheet(),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppThemeProvider.appTheme==ThemeMode.light?
                    Text(AppLocalizations.of(context)!.light,style: AppStyle.bold20bPrimary,):
                    Text(AppLocalizations.of(context)!.dark,style: AppStyle.bold20bPrimary,),
                    Icon(Icons.arrow_drop_down,color: AppColors.primaryColor,)
                  ],
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false,);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColors.red,

                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout,color: AppColors.white,),
                    SizedBox(width: 10,),
                    Text(AppLocalizations.of(context)!.logout,style: AppStyle.regular20white,),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottumShets();
        },);
  }
  void showThemeBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeShet();
      },);
  }
}
