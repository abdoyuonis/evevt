import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/Language_Provider.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/App_Color.dart';
import '../../utils/App_Style.dart';

class BottumShets extends StatelessWidget {
  const BottumShets({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
            },
            child: chekLanguageEn()?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.english,style: AppStyle.bold20bPrimary,),
                SizedBox(width: 7,),
                Icon(Icons.check,color: AppColors.primaryColor,size: 35,)
              ],
            )
                :Text(AppLocalizations.of(context)!.english,style: AppStyle.bold20black,)
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
            child: chekLanguageEn()?
            Text(AppLocalizations.of(context)!.arabic,style: AppStyle.bold20black,)
            :Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.arabic,style: AppStyle.bold20bPrimary,),
                SizedBox(width: 7,),
                Icon(Icons.check,color: AppColors.primaryColor,size: 35,)
              ],
            )
          ),
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

}
