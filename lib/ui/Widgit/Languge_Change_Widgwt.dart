import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/App_Theme_Provider.dart';
import '../../Providers/Language_Provider.dart';
import '../../utils/App_Color.dart';
import '../../utils/App_Images.dart';

class ContinarChangeLanguge extends StatelessWidget {
  const ContinarChangeLanguge({super.key});


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return   Container(
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
