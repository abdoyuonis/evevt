import 'package:flutter/material.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Event_Tap_Icon.dart';
import 'package:untitled15/ui/Login/Form_Fild_Widgit.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';

class AddEvent extends StatefulWidget {
  static const String routeName='Add_Event';

  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int slectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<String> listImage=[
      'assets/images/Sport.png',
      'assets/images/Birthday.png',
      'assets/images/Meeting.png',
      'assets/images/Gaming.png',
      'assets/images/WorkShop.png',
      'assets/images/BookClub.png',
      'assets/images/Exhibition.png',
      'assets/images/Holiday.png',
      'assets/images/Eating.png'
    ];
    List<String> eventName = ['Sports','Birthday','Meeting','Gaming','WorkShop','Book Club'
      ,'Exhibiyion','Holiday','eating'
    ];
    TextEditingController title=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Create Event',style: AppStyle.bold20bPrimary,),
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image(image: AssetImage(listImage[0])),
            SizedBox(height: 1,),
            ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 1,);
                },
                itemCount: eventName.length),
            FormFieldWidgit(
                controller: title),
          ],
        ),
      ),
    );
  }
}
