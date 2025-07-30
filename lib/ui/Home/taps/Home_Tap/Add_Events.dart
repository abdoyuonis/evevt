import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/event_list_provider.dart';
import 'package:untitled15/model.dart';
import 'package:untitled15/ui/Login/Button_Widget.dart';
import 'package:untitled15/ui/Widgit/toste_Widgit.dart';
import 'package:untitled15/utils/Firebase_Utils.dart';

import '../../../../utils/App_Color.dart';
import '../../../../utils/App_Style.dart';
import '../../../Login/Form_Fild_Widgit.dart';
import 'Event_Tap_Icon.dart';

class AddEvents extends StatefulWidget {
  static const String routeName= 'Add_Event_Screen';
   const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
   int slectedIndex=0;
    DateTime? slectedDate;
    TimeOfDay? slectedTime;
    String? formatTime;
   var formKay = GlobalKey<FormState>();
   TextEditingController controllerTitle=TextEditingController();
   TextEditingController controllerDescription=TextEditingController();
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
   late EventListProvider eventListPorvider;

   @override
  Widget build(BuildContext context) {
     eventListPorvider=Provider.of<EventListProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Create Event',style: AppStyle.bold20bPrimary,),
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Image(image: AssetImage(listImage[slectedIndex])),
              ),
              SizedBox(height: 6,),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          slectedIndex=index;
                          setState(() {

                          });
                        },
                        child: EventTapIcon(
                          borderColor: AppColors.primaryColor,
                            isSlected: slectedIndex==index,
                            eventName: eventName[index],
                          colorSlect: AppColors.primaryColor,
                          colorSlectText: AppColors.white,
                          colorUnSlectText: AppColors.primaryColor,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 1,);
                    },
                    itemCount: eventName.length),
              ),
              SizedBox(height: height*0.02,),

             Form(
               key: formKay,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     Text('Title',style: AppStyle.midam16Black,),
                     SizedBox(height: height*0.002,),
                     FormFieldWidgit(
                       validator: (text) {
                         if(text==null||text.isEmpty){
                           return 'Please Enter Title';
                         }
                         return null;
                       },
                       controller: controllerTitle,
                       textHint: 'Event Title',
                       iconPrefix: Icon(Icons.note_alt_outlined,color: Colors.grey,),
                     ),
                     SizedBox(height: height*0.02,),
                     Text('Description',style: AppStyle.midam16Black,),
                     SizedBox(height: height*0.002,),

                     FormFieldWidgit(
                       validator: (text) {
                         if(text==null||text.isEmpty){
                           return 'Please Enter Title';
                         }
                         return null;
                       },
                       controller: controllerDescription,
                       textHint: 'Event Description',
                       maxLine: 4,
                     ),
                     SizedBox(height: height*0.01,),

                     Row(
                       children: [
                         Icon(Icons.date_range),
                         SizedBox(width: width*0.04,),
                         Text('Event Date',style: AppStyle.midam16Black,),
                         Spacer(),
                         TextButton(
                             onPressed: chooseDate,

                             child:slectedDate==null?
                             Text("Choose Date"):
                             Text('${slectedDate!.day}/${slectedDate!.month}/${slectedDate!.year}')
                         )
                       ],
                     ),
                     SizedBox(height: height*0.001,),
                     Row(
                       children: [
                         Icon(Icons.access_time),
                         SizedBox(width: width*0.04,),
                         Text('Event Time',style: AppStyle.midam16Black,),
                         Spacer(),
                         TextButton(
                             onPressed: chooseTime,
                             child: slectedTime==null?
                             Text("Choose Time"):
                             Text('$formatTime')
                         )
                       ],
                     ),
                     SizedBox(height: height*0.001,),
                     Text('Location',style: AppStyle.midam16Black,),
                     SizedBox(height: height*0.001,),
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
                             child: Icon(Icons.my_location_outlined,color: AppColors.white,),
                           ),
                           Text('Choose Event Location',style: AppStyle.midam20Primary,),
                           Spacer(),
                           Icon(Icons.arrow_forward_ios_rounded,color: AppColors.primaryColor,),
                           SizedBox(width: width*.03,)
                         ],
                       ),

                     ),
                     SizedBox(height: height*0.001,),
                     ButtonWidget(
                       onPressed: addEvent,
                       buttonChild: Text('Add Event',style: AppStyle.midam20White,),
                     )
                   ],
                 )
             )
            ],
          ),
        ),
      ),
    );
  }
  void chooseDate()async{
    var chooseDade = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),

    );
    slectedDate=chooseDade;
    setState(() {

    });
  }
  void chooseTime()async{
   var time= await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
   slectedTime=time;
   formatTime=slectedTime!.format(context);
   setState(() {

   });
  }
  void addEvent(){
   if(formKay.currentState?.validate()==true){
     Event event =Event(
         dateTime: slectedDate!,
         eventName: eventName[slectedIndex],
         title: controllerTitle.text,
         imagePath: listImage[slectedIndex],
         description: controllerDescription.text,
         time: formatTime!
     );
     FirebaseUtils.addEventToFireStore(event).timeout(Duration(milliseconds: 500),
       onTimeout: () {
       ToastUtils.toastMsg(msg: 'add event sacs');
       eventListPorvider.getAllEvent();
         Navigator.of(context).pop();
       },
     );
   }
  }

}
