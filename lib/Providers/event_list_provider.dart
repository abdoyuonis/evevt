import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled15/l10n/app_localizations.dart';
import 'package:untitled15/ui/Widgit/toste_Widgit.dart';
import 'package:untitled15/utils/App_Color.dart';

import '../model.dart';
import '../utils/Firebase_Utils.dart';

class EventListProvider extends ChangeNotifier{
  //todo data
  List<Event> eventList=[];
  List<Event> filterEventList=[];
  List<Event> favoriteList=[];
   List<String> eventName = [
     // 'All',           // الكل
     // 'Sports',        // رياضة
     // 'Birthday',      // عيد ميلاد
     // 'Meeting',       // اجتماع
     // 'Games',         // ألعاب
     // 'Workshop',      // ورشة عمل
     // 'Book Club',     // نادي القراءة
     // 'Exhibition',    // معرض
     // 'holiday',      // إجازة
     // 'Eating'

   ];
  List<String> fullList(BuildContext context){
      return eventName=[
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.book,
      AppLocalizations.of(context)!.exhibiyion,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }
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

  int selectedIndex=0;

  //todo methods
  void getAllEvent(String uid)async{
    QuerySnapshot<Event>  querySnapshot=await FirebaseUtils.getEventCollection(uid).get();
    eventList= querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    filterEventList=eventList;
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    },);
    notifyListeners();
  }

void getFilterEvent(String uid)async{
     var snapShots =await FirebaseUtils.getEventCollection(uid).get();
     List<QueryDocumentSnapshot<Event>> filter=[];
     filter=snapShots.docs.where((event) {
       return event.data().imagePath==listImage[selectedIndex];
     },).toList();
     filterEventList=filter.map((event) {
       return event.data();
     },).toList();
     notifyListeners();
  }



  void getFavorite(String uid)async{
    var snapShots =await FirebaseUtils.getEventCollection(uid).get();
    List<QueryDocumentSnapshot<Event>> filterFavorite=[];
    filterFavorite=snapShots.docs.where((event) {
      return event.data().isFavorite==true;}).toList();
    favoriteList=filterFavorite.map((doc) {
      return doc.data();
    },).toList();
    notifyListeners();
  }

  void getFilterEventFromFireStore(String uid)async{
     var snpShots= await  FirebaseUtils.getEventCollection(uid).where('EventName',
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
    required String eventName,
     required String uid

  }){
    FirebaseUtils.getEventCollection(uid).doc(event.id)
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
    selectedIndex==0?getAllEvent(uid):getFilterEventFromFireStore(uid);
    notifyListeners();
  }

  Future<void> removeEvent(String id,String uid){
    return FirebaseUtils.getEventCollection(uid).doc(id).delete().timeout(Duration(microseconds: 500,),
    onTimeout: (){
      ToastUtils.toastMsg(msg: 'Event Delete sucs',
      color: AppColors.red);
      selectedIndex==0?getAllEvent(uid):getFilterEventFromFireStore(uid);
      notifyListeners();
    }
    );
  }

  void updateIsFavorite(Event event,String uid){
    FirebaseUtils.getEventCollection(uid).doc(event.id)
        .update({'isFavorite':!event.isFavorite}).then((value) {
      ToastUtils.toastMsg(msg: 'Event Updated'
          ,color: AppColors.primaryColor
      );
      selectedIndex==0?getAllEvent(uid):getFilterEventFromFireStore(uid);
      getFavorite(uid);
        },);
    //     .timeout(Duration(milliseconds: 400),onTimeout: (){
    //       ToastUtils.toastMsg(msg: 'Event Updated'
    //       ,color: AppColors.primaryColor
    //       );
    //       selectedIndex==0?getAllEvent(uid):getFilterEventFromFireStore(uid);
    //       getFavorite();
    // })
    // ;

    notifyListeners();
  }


  void changeSelectedIndex(int newSelectedIndex,String uid){
    selectedIndex=newSelectedIndex;
    selectedIndex==0?getAllEvent(uid):getFilterEventFromFireStore(uid);
  }
}