import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/model.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Edit_Event.dart';
import 'package:untitled15/utils/App_Style.dart';

import '../../../../Providers/My_User_Provider.dart';
import '../../../../Providers/event_list_provider.dart';
import '../../../../utils/App_Color.dart';
import '../../../Login/Button_Widget.dart';

class EventDetails extends StatelessWidget {
  static const String routeName='EventDetailsScreen';
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider= Provider.of<MyUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Event Details',style: AppStyle.bold20bPrimary,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditEvent.routeName,
            arguments: event
            );
          },
              icon: Image(image: AssetImage('assets/images/EditImage.png'))),
          IconButton(onPressed: (){
            eventListProvider.removeEvent(event.id,userProvider.myUser!.id);
            Navigator.of(context).pop();
          },
              icon: Image(image: AssetImage('assets/images/deleteImage.png')))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
                child: Image(image: AssetImage(event.imagePath))),
            SizedBox(height: height*0.02,),
            Text('We Are Going To Play Football',style: AppStyle.midam20Primary.copyWith(fontSize: 24),),
            SizedBox(height: height*0.02,),
            ButtonWidget(
              colorBg: Colors.transparent,
              onPressed: (){},
              buttonChild: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.primaryColor
                    ),
                    child: Icon(Icons.calendar_month,color: AppColors.white,size: 25,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(event.dateTime.day.toString(),
                            style: AppStyle.midam20Primary,),
                          SizedBox(width: width*0.02,),
                          Text(DateFormat('MMMM').format(event.dateTime),
                            style: AppStyle.midam20Primary,),
                          SizedBox(width: width*0.02,),
                          Text(event.dateTime.year.toString(),
                            style: AppStyle.midam20Primary,)
                        ],
                      ),
                      Text(event.time,style: AppStyle.midam16Black,)


                    ],
                  )

                ],
              ),

            ),
            SizedBox(height: height*0.02,),
            Text('Description',style: AppStyle.midam16Black,),
            SizedBox(height: height*0.02,),
            Text(event.description,style: AppStyle.midam16Black,)
          ],
        ),
      ),
    );
  }
}
