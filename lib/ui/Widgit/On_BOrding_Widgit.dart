import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';

class OnBordingWidgit extends StatelessWidget {
  String imagePath;
  String text1;
  String text2;
   OnBordingWidgit({super.key,required this.imagePath,required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image(image: AssetImage(AppImages.logo)),
        SizedBox(height:height*0.05 ,),
        Image(image: AssetImage(imagePath)),
        SizedBox(height:height*0.05 ,),
        Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(text1,style: AppStyle.bold20bPrimary,)),
        SizedBox(height:height*0.05 ,),
        Text(text2,style: AppStyle.midam16Black,)
      ],
    );
  }
}
