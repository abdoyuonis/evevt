import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled15/model.dart';
import 'package:untitled15/utils/Model/my_user.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventCollection(String uid){
    return getUserCollection().doc(uid)
        .collection(Event.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) => Event.fromFirestore(snapshot.data()!),
      toFirestore: (event, options) => event.toFireStore(),
    );
  }



  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (myUser, options) => myUser.toFireStore(),);
  }

  static Future<void> addUserToFireStore(MyUser user){
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String id)async{
    var documentSnapshot= await getUserCollection().doc(id).get();
    return documentSnapshot.data();
  }



  static Future<void> addEventToFireStore(Event event,String uid){
  var eventCollection = getEventCollection(uid);
  var docRev = eventCollection.doc();
  event.id=docRev.id;
  return docRev.set(event);
  }
}