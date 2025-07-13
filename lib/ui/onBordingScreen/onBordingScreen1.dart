import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/App_Theme_Provider.dart';
import 'package:untitled15/l10n/app_localizations.dart';
import 'package:untitled15/ui/onBordingScreen/On_Bording_Screen2.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';

import '../../Providers/Language_Provider.dart';

class Onbordingscreen extends StatelessWidget {
  static const String routeName= 'on_Bording_Screen';
  const Onbordingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(height*.03),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  Image(image: AssetImage(AppImages.onBordingImage),width: double.infinity,),
                  SizedBox(height: height*0.01,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.personalize,style: AppStyle.bold20bPrimary,),
                      SizedBox(height: height*0.04,),
                      Text(AppLocalizations.of(context)!.choose_your_preferred,style: AppStyle.midam16Black,),
                      SizedBox(height: height*0.03,),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.language,style: AppStyle.midam20Primary,),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 3,
                                color: AppColors.primaryColor
                              )
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  languageProvider.changeLanguage('en');
                                },
                                    icon: chekLanguageEn()?
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                            width: 5,
                                            color: AppColors.primaryColor
                                          )
                                        ),
                                        child: Image(image: AssetImage(AppImages.usa))):
                                    Image(image: AssetImage(AppImages.usa)
                                    )),
                                SizedBox(width: width*.001,),
                                IconButton(onPressed: (){
                                  languageProvider.changeLanguage('ar');
                                },
                                    icon: chekLanguageAr()?
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 5,
                                                color: AppColors.primaryColor
                                            )
                                        ),
                                        child: Image(image: AssetImage(AppImages.eg))):
                                    Image(image: AssetImage(AppImages.eg)
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: height*.02,),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.theme,style: AppStyle.midam20Primary,),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    width: 3,
                                    color: AppColors.primaryColor
                                )
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  themeProvider.changeTheme(ThemeMode.light);
                                },
                                    icon: chekThemeLigth()?
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                        ),
                                        child: Image(image: AssetImage(AppImages.sunImage))):
                                    Image(image: AssetImage(AppImages.sunImage)
                                    )),
                                SizedBox(width: width*.001,),
                                IconButton(onPressed: (){
                                  themeProvider.changeTheme(ThemeMode.dark);

                                },
                                    icon: chekThemeDark()?
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.white
                                        ),
                                        child: Image(image: AssetImage(AppImages.moonImage))):
                                    Image(image: AssetImage(AppImages.moonImage)
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed(OnBoardingPage.routeName);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,

                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      child: Text(AppLocalizations.of(context)!.start,style: AppStyle.midam16white.copyWith(fontSize: 20),textAlign: TextAlign.center,)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool chekLanguageEn(){
    if(AppLanguageProvider.appLanguage=='en'){
      return true;
    }
    else{
      return false;
    }
  }
  bool chekLanguageAr(){
    if(AppLanguageProvider.appLanguage=='ar'){
      return true;
    }
    else{
      return false;
    }
  }
  bool chekThemeDark(){
    if(AppThemeProvider.appTheme==ThemeMode.dark){
      return true;
    }
    else{
      return false;
    }
  }

  bool chekThemeLigth(){
    if(AppThemeProvider.appTheme==ThemeMode.light){
      return true;
    }
    else{
      return false;
    }
  }
}
