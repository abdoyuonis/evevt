import 'package:flutter/material.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Event_Tap_Icon.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';

class HomeTap extends StatefulWidget {

  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int slectedIndex=0;

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
                  onTap: (index) {
                    slectedIndex=index;
                    setState(() {

                    });
                  },
                  isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.zero,
                    tabs: eventName.map((e) {
                      return EventTapIcon(
                        borderColor: AppColors.white,
                        colorUnSlectText: AppColors.white,
                          colorSlectText: AppColors.primaryColor,
                          colorSlect: AppColors.white,
                          isSlected: slectedIndex==eventName.indexOf(e),
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
      body: Column(
        children: [
          SizedBox(height: 2,),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Image(image: AssetImage('assets/images/ImageGrobe.png')
                      ,width: double.infinity,
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
    );
  }
}
