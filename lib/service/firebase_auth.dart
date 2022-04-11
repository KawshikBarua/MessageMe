import 'package:chat_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel _toUserClass(User? user) {
    return UserModel(user!.uid, user.email);
  }

  String getUserId() {
    return _firebaseAuth.currentUser!.uid.toString();
  }

  //function if the user is logged in or has logged out
  Stream<User?> get authChange {
    return _firebaseAuth.authStateChanges();
  }

  //function for using mail and password to login
  Future<UserModel?> loginWithCred(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      UserModel userData = _toUserClass(user.user);
      return userData;
    } catch (e) {
      return null;
    }
  }

  //function for registering user
  Future<UserModel?> registerWithCred(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      UserModel? userData = _toUserClass(user.user);
      return userData;
    } catch (e) {
      return null;
    }
  }

  //function for logout
  Future userLogout() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
