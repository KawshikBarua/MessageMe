import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_info.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance.collection("UserInfo");
  void addUserData(String uid, InfoUser infoUser) {
    _firestore.doc(uid).set(infoUser.toJson());
  }

  Map<String, dynamic> listOfUser(QueryDocumentSnapshot data) {
    InfoUser user = InfoUser(
        fName: data['fName'],
        lName: data['lName'],
        registeredDate: data['registered'],
        uid: data['uid']);
    return user.toJson();
  }

  Future<List> fetchDataFireStore() async {
    List allData = [];
    try {
      await _firestore.get().then((value) {
        for (var element in value.docs) {
          allData.add(listOfUser(element));
        }
      });
      return allData;
    } catch (e) {
      return [];
    }
  }
}
