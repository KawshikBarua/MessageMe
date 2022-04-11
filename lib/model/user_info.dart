import 'package:cloud_firestore/cloud_firestore.dart';

class InfoUser {
  late String fName;
  late String lName;
  late Timestamp registeredDate;
  late String uid;
  InfoUser(
      {required this.fName,
      required this.lName,
      required this.registeredDate,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      "fName": fName,
      "lName": lName,
      "registered": registeredDate,
      "uid": uid
    };
  }
}
