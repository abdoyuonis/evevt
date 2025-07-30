import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/event_list_provider.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Event_Details.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Event_Tap_Icon.dart';
import 'package:untitled15/ui/Widgit/Event_Item.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';
import 'package:untitled15/utils/App_Style.dart';
import 'package:untitled15/utils/Firebase_Utils.dart';

import '../../../../model.dart';

class HomeTap extends StatefulWidget {

   const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {



  @override
  Widget build(BuildContext context) {
    var eventListPorvider = Provider.of<EventListProvider>(context);
    if(eventListPorvider.eventList.isEmpty){
      eventListPorvider.getAllEvent();
    }

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
                length: eventListPorvider.eventName.length,
                child: TabBar(
                  onTap: (index) {
                    eventListPorvider.changeSelectedIndex(index);
                  },
                  isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.zero,
                    tabs: eventListPorvider.eventName.map((e) {
                      return EventTapIcon(
                        borderColor: AppColors.white,
                        colorUnSlectText: AppColors.white,
                          colorSlectText: AppColors.primaryColor,
                          colorSlect: AppColors.white,
                          isSlected: eventListPorvider.selectedIndex==eventListPorvider.eventName.indexOf(e),
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
            child:eventListPorvider.filterEventList.isEmpty?
            Center(
              child: Text('Not found Event', style: AppStyle.bold20black,),
            )
                :
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(EventDetails.routeName,
                      arguments:eventListPorvider.filterEventList[index]
                      );
                    },
                      child: EventItem(event: eventListPorvider.filterEventList[index],));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10,);
                },
                itemCount: eventListPorvider.filterEventList.length),
          )
        ],
      ),
    );
  }

}
