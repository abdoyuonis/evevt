import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/App_Theme_Provider.dart';

import '../../Providers/Language_Provider.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/App_Color.dart';
import '../../utils/App_Style.dart';

class ThemeShet extends StatelessWidget {
  const ThemeShet({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                themeProvider.changeTheme(ThemeMode.dark);
              },
              child: chekThemeDark()?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.dark,style: AppStyle.bold20bPrimary,),
                  SizedBox(width: 7,),
                  Icon(Icons.check,color: AppColors.primaryColor,size: 35,)
                ],
              )
                  :Text(AppLocalizations.of(context)!.dark,style: AppStyle.bold20black,)
          ),
          SizedBox(height: 10,),
          InkWell(
              onTap: () {
                themeProvider.changeTheme(ThemeMode.light);
              },
              child: chekThemeDark()?
              Text(AppLocalizations.of(context)!.light,style: AppStyle.bold20black,)
                  :Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.light,style: AppStyle.bold20bPrimary,),
                  SizedBox(width: 7,),
                  Icon(Icons.check,color: AppColors.primaryColor,size: 35,)
                ],
              )
          ),
        ],
      ),
    );
  }

  bool chekThemeDark(){
    if(AppThemeProvider.appTheme==ThemeMode.dark){
      return true;
    }
    else{
      return false;
    }
  }
}
