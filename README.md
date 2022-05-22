**MessageMe**

![1](https://user-images.githubusercontent.com/87719519/169698976-f6d56e21-0e4c-4659-9e3e-da42fa7c7b4c.PNG)



•Description:
A basic chat app that can be used to chat with friends and random people once they have signed up. This chat system does not require to send friend request in order to send texts.  The design was kept simple and in this document reader will find a complete guide on how this was constructed.


•Packages Used:
  	firebase_auth: ^3.3.7
	firebase_database: ^9.0.8
	firebase_core: ^1.12.0
 	provider: ^6.0.2
 	contacts_service: ^0.6.3
  	cloud_firestore: ^3.1.10
	flutter_native_splash: ^2.1.3+1
	
	
•Screens:
There are total 7 screens and all the screen does what name of the files says. I hope most of them are very straight forward so I am not going to explain all the screens. However, check_screen.dart is used to check whether a user is logged in or not. So what is basically happening in this screen is that a Streambuilder is constantly listening to a stream of authChange{ will be described more elaborately in another section}and if the stream returns a null this means that user is currently logged out hence we will be guided to LoginScreen() else user will be taken to LandingScreen().
The landing_screen.dart is the first screen we see after logging and this contains 2 more screens which are the friend_screen.dart and chat_screen.dart.


•Database:
For the database I have used Firebase in my app. The purpose of Firebase here is to store all the user information and their data. Furthermore, with the help of realtime database, messages are sent and received. If the reader looks in the service folder there will be 3 dart files, these files are used for communicating with firebase. Lets start with firebase_auth.

We have a function which gives the user’s user id and all user has their own unique user id. 
String getUserId() {
    return _firebaseAuth.currentUser!.uid.toString();
  }

authChange function is a stream which means that any kind of change in this function will be notified instantly. 
  Stream<User?> get authChange {
    return _firebaseAuth.authStateChanges();
  }

The 3 functions below are responsible for logging in, registering and logging out the current user. Firstly _firebaseAuth is a variable contains a instance of FirebaseAuth. Later this variable is used to sign in using the given method, registering does the job almost similar. Sign out is pretty simple just call _firebaseAuth which will have signout() method. Remember to enclose the code in try catch since it can raise error in this purpose I have returned null.
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

In the firebase_firestore.dart we store the user information in firebase database and InfoUser is a class which holds all the necessary data of the user and the uid here is used to separate the data from one another and making it easier to fetch later when needed. We add the data by calling the set() method. 
 void addUserData(String uid, InfoUser infoUser) {
    _firestore.doc(uid).set(infoUser.toJson());
  }

All the datas are fetched using the fetchDataFireStore() function this is an async function since it has to await to get all the data. After all the data are fetched, it is a QueryDocumentSnapshot which is then converted to a Map. 
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

I have used Firebase realtime database to send and receive messages and the messages are organized combining the user’s id and the friend’s user id to store the message in that location. However, when a message is sent firebase creates 2 different location to store data one with (user id, friend id) and (friend id, user id). 

