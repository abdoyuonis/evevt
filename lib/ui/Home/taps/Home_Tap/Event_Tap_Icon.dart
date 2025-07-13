import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';

class EventTapIcon extends StatelessWidget {
  bool isSlected;
  String eventName;
   EventTapIcon({super.key,required this.isSlected,required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        color: isSlected?Theme.of(context).focusColor:Colors.transparent,
        border:Border.all(
          color: AppColors.white,
          width: 2
        )
      ),
      child: Text(eventName,style: isSlected?AppStyle.midam20Primary.copyWith(fontSize: 16)
        :AppStyle.midam16white
        ,),
    );
  }
}
