import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled15/model.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventCollection(){
    return FirebaseFirestore.instance.collection(Event.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) => Event.fromFirestore(snapshot.data()!),
      toFirestore: (event, options) => event.toFireStore(),
    );
  }
  static Future<void> addEventToFireStore(Event event){
  var eventCollection = getEventCollection();
  var docRev = eventCollection.doc();
  event.id=docRev.id;
  return docRev.set(event);
  }
}