import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled15/ui/Widgit/toste_Widgit.dart';
import 'package:untitled15/utils/App_Color.dart';

import '../model.dart';
import '../utils/Firebase_Utils.dart';

class EventListProvider extends ChangeNotifier{
  //todo data
  List<Event> eventList=[];
  List<Event> filterEventList=[];
  List<String> eventName = ['All','Sports','Birthday','Meeting','Gaming','WorkShop','Book Club'
    ,'Exhibiyion','Holiday','eating'
  ];
  List<String> eventNameAr = [
    'الكل',
    'رياضة',
    'عيد ميلاد',
    'اجتماع',
    'ألعاب',
    'ورشة عمل',
    'نادي القراءة',
    'معرض',
    'إجازة',
    'تناول الطعام'
  ];

  int selectedIndex=0;

  //todo methods
  void getAllEvent()async{
    QuerySnapshot<Event>  querySnapshot=await FirebaseUtils.getEventCollection().get();
    eventList= querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    filterEventList=eventList;
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    },);
    notifyListeners();
  }

void getFilterEvent()async{
     var snapShots =await FirebaseUtils.getEventCollection().get();
     List<QueryDocumentSnapshot<Event>> filter=[];
     filter=snapShots.docs.where((event) {
       return event.data().eventName==eventName[selectedIndex]||event.data().eventName==eventNameAr[selectedIndex];
     },).toList();
     filterEventList=filter.map((event) {
       return event.data();
     },).toList();
     notifyListeners();
  }

  void getFilterEventFromFireStore()async{
     var snpShots= await  FirebaseUtils.getEventCollection().where('EventName',
         isEqualTo: eventName[selectedIndex]
     ).get();
     filterEventList=snpShots.docs.map((doc) {
       return doc.data();
     },).toList();
     filterEventList.sort((event1, event2) {
       return event1.dateTime.compareTo(event2.dateTime);
     },);
     notifyListeners();

  }
   void updateEvent({
     required Event event,
    required String imagePath,
    required String time,
    required String title,
    required String description,
    required DateTime? dateTime,
    required String eventName

  }){
    FirebaseUtils.getEventCollection().doc(event.id)
        .update({
      'ImagePath':imagePath,
      'Time':time,
      'Title':title,
      'Description':description,
      'EventName':eventName,
      'DateTime':dateTime,
    }).timeout(Duration(milliseconds: 500),onTimeout: (){
      ToastUtils.toastMsg(msg: 'Event Updated',
      color: AppColors.primaryColor
      );
    });
    selectedIndex==0?getAllEvent():getFilterEventFromFireStore();
    notifyListeners();
  }

  Future<void> removeEvent(String id){
    return FirebaseUtils.getEventCollection().doc(id).delete().timeout(Duration(microseconds: 500,),
    onTimeout: (){
      ToastUtils.toastMsg(msg: 'Event Delete sucs',
      color: AppColors.red);
      selectedIndex==0?getAllEvent():getFilterEventFromFireStore();
      notifyListeners();
    }
    );
  }

  void updateIsFavorite(Event event){
    FirebaseUtils.getEventCollection().doc(event.id)
        .update({'isFavorite':!event.isFavorite}).timeout(Duration(milliseconds: 400),onTimeout: (){
          ToastUtils.toastMsg(msg: 'Event Updated'
          ,color: AppColors.primaryColor
          );
    });
    selectedIndex==0?getAllEvent():getFilterEventFromFireStore();
    notifyListeners();
  }


  void changeSelectedIndex(int newSelectedIndex){
    selectedIndex=newSelectedIndex;
    selectedIndex==0?getAllEvent():getFilterEventFromFireStore();
  }
}