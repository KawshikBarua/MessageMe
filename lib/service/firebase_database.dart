import 'dart:async';

import 'package:chat_app/model/msg_model.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final String myId;
  final String frndId;

  Database({required this.myId, required this.frndId});

  void addChatToDataBase(Message msg) {
    DatabaseReference ref = _firebaseDatabase.ref('chat');
    String childStr = '$myId$frndId';
    String childStr2 = '$frndId$myId';
    DatabaseReference child = ref.child(childStr);
    DatabaseReference child2 = ref.child(childStr2);
    child.push().set(msg.toJson());
    child2.push().set(msg.toJson());
  }

  Stream<DatabaseEvent> getChatFromDatabase() {
    DatabaseReference ref = _firebaseDatabase.ref('chat');
    String childStr = '$myId$frndId';
    DatabaseReference child = ref.child(childStr);
    return child.onValue;
  }

  Stream<DatabaseEvent> getLastText() {
    DatabaseReference ref = _firebaseDatabase.ref('chat');
    String childStr = '$myId$frndId';
    DatabaseReference child = ref.child(childStr);
    return child.limitToLast(1).onValue;
  }
}
