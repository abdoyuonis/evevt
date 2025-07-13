import 'package:flutter/material.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Event_Tap_Icon.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> eventName = ['All','Sports','Birthday','Meeting','Gaming','WorkShop','Book Club'
    ,'Exhibiyion','Holiday','eating'
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 159,
        backgroundColor: AppColors.primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back ✨',style: AppStyle.regular14white,),
            Text('John Safwat',style: AppStyle.bold24White,),
            Row(
              children: [
                ImageIcon(AssetImage(AppImages.mapIcon),color: AppColors.white,),
                Text('Cairo , Egypt',style: AppStyle.regular14white,)
              ],
            ),
            SizedBox(height: 10,),
            DefaultTabController(
                length: eventName.length,
                child: TabBar(
                  isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.zero,
                    tabs: eventName.map((e) {
                      return EventTapIcon(isSlected: false,
                          eventName: e);
                    },).toList()
                )
            )
          ],
        ),
        actions: [
          IconButton(onPressed: null,
              icon: ImageIcon(AssetImage(AppImages.sunImage),color: AppColors.white,))
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),

        ),

      ),
    );
  }
}
