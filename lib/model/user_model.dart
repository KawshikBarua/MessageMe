class UserModel {
  late String uid;
  late String? email;
  UserModel(String u, String? e) {
    uid = u;
    email = e;
  }

  Map<String, dynamic> toJson() {
    return {"uid": uid, "email": email};
  }
}
