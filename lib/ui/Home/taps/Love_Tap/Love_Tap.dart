import 'package:flutter/material.dart';
import 'package:untitled15/ui/Login/Form_Fild_Widgit.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';

class LoveTap extends StatelessWidget {
   LoveTap({super.key});
   TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
      children: [
        FormFieldWidgit(
          controller: controller,
          colorSide: AppColors.primaryColor,
        textHint: 'Search for Event',
          iconPrefix: Icon(Icons.search,color: AppColors.primaryColor,),
          textStyle: AppStyle.midam20Primary.copyWith(fontSize: 16),
        ),
      SizedBox(height: 2,),
      Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return Image(image: AssetImage('assets/images/ImageLove.png'),
              width: double.infinity,
            fit: BoxFit.fill,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10,);
          },
          itemCount: 10),
      )
      ],
      ),
      ),
    );
  }
}
