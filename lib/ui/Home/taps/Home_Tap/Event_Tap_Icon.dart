import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Style.dart';

class EventTapIcon extends StatelessWidget {
  bool isSlected;
  String eventName;
  Color colorSlect;
  Color colorSlectText;
  Color colorUnSlectText;
  Color borderColor;
   EventTapIcon({
     super.key,
     required this.isSlected,
     required this.eventName,
     required this.colorSlect,
     required this.colorSlectText,
     required this.colorUnSlectText,
     required this.borderColor

   });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        color: isSlected?colorSlect:Colors.transparent,
        border:Border.all(
          color: borderColor,
          width: 2
        )
      ),
      child: Text(eventName,style: isSlected?AppStyle.midam20Primary.copyWith(fontSize: 16,color: colorSlectText)
        :AppStyle.midam16white.copyWith(color: colorUnSlectText)
        ,),
    );
  }
}
