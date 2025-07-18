import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Color.dart';
import '../../utils/App_Style.dart';
typedef OnValidator=String? Function(String?)?;
class FormFieldWidgit extends StatelessWidget {
  Color colorSide;
  String? textHint;
  TextStyle? textStyle;
  Widget? iconPrefix;
  Widget? iconSuffix;
  OnValidator validator;
  TextInputType kayBordTayb;
  TextEditingController controller;
  bool obscurText;
  int? maxLine;




  // constructor
  FormFieldWidgit({super.key,
     this.colorSide= Colors.grey,
     this.iconPrefix,
     this.iconSuffix,
     this.textStyle=AppStyle.midam16wGray,
     this.textHint,
     this.validator,
     this.kayBordTayb=TextInputType.text,
    this.obscurText=false,
     required this.controller,
    this.maxLine
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: maxLine,
        decoration: InputDecoration(
          enabledBorder: buildDecorationSide(colorSide),
          focusedBorder: buildDecorationSide(colorSide),
          errorBorder: buildDecorationSide(AppColors.red),
          focusedErrorBorder: buildDecorationSide(AppColors.red),
          hintText:textHint,
          prefixIcon: iconPrefix,
          suffixIcon: iconSuffix,
          iconColor: colorSide,
          hintStyle: textStyle,
        ),
        validator: validator,
        controller: controller,
        keyboardType: kayBordTayb,
        obscureText: obscurText,
      ),
    );
  }
  OutlineInputBorder buildDecorationSide(Color colorSide){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: colorSide,
            width: 2
        )
    );
  }
}
