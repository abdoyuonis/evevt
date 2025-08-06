import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';

class DialogUtils{
  static void showLoading({required BuildContext context,required String loadingText}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColors.primaryColor,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(loadingText,style: AppStyle.midam16Black,),
              )
            ],
          ),
        ),
    );
  }

  static void hideLoading({required BuildContext context}){
    Navigator.of(context).pop();
  }


  static void showMessage({
    required BuildContext context,
    required text,
    String? title,
    String? posActionName,
    String? negActionName,
    Function? posAction,
    Function? negAction,
  })
  {
    List<Widget>? actions=[];
    if(posActionName!=null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(posActionName,style: AppStyle.midam16Black,)));
      if(negActionName!=null){
        actions.add(TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              negAction?.call();
            },
            child: Text(negActionName)));
      }
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(text,style: AppStyle.midam16Black,),
          actions: actions,
          title: Text(title??'',style: AppStyle.midam16Black,),
        ),
    );
  }
}