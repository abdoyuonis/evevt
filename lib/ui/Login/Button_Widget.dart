import 'package:flutter/material.dart';

import '../../utils/App_Color.dart';

class ButtonWidget extends StatelessWidget {
  VoidCallback onPressed;
  Widget? buttonChild;
  Color colorBg;
  Color borderColor;
   ButtonWidget({super.key,
     required this.onPressed,
     this.buttonChild,
     this.colorBg=AppColors.primaryColor,
     this.borderColor=AppColors.primaryColor
   });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: onPressed,
        style: ElevatedButton.styleFrom(shadowColor: Colors.transparent,
          backgroundColor: colorBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color:borderColor
            )
          ),
          padding: EdgeInsets.symmetric(vertical:height*.02 )
        ),
          child: buttonChild

      ),
    );
  }
}
