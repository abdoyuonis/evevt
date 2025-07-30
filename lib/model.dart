import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  static const String collectionName= 'Event';
  String id;
  String imagePath;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  Event({
    this.id='',
    required this.dateTime,
    required this.eventName,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.time,
    this.isFavorite=false,
});
  // todo jason to object

   Map<String,dynamic>toFireStore(){
     return {
       'id':id,
       'ImagePath':imagePath,
       'Time':time,
       'Title':title,
       'Description':description,
       'EventName':eventName,
       'DateTime':dateTime,
       'isFavorite':isFavorite,
     };
   }
   // todo object to jason
  Event.fromFirestore(Map<String, dynamic> data)
      : this(
    id: data['id'] ?? '',
    title: data['Title'] ?? '',
    dateTime: data['DateTime'] is Timestamp
        ? (data['DateTime'] as Timestamp).toDate()
        : DateTime.fromMicrosecondsSinceEpoch(data['DateTime']),
    description: data['Description'] ?? '',
    eventName: data['EventName'] ?? '',
    imagePath: data['ImagePath'] ?? '',
    time: data['Time'] ?? '',
    isFavorite: data['isFavorite'] ?? false,
  );

}