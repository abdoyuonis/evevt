import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Style.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/Sport.png')),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16)
            ),
            child: Text('22\nNov',style: AppStyle.midam20Primary,),
          )
        ],
      ),
    );
  }
}
