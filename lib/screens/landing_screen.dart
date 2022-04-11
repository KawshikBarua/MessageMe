import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/friend_screen.dart';
import 'package:chat_app/service/firebase_auth.dart';
import 'package:chat_app/service/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List _userList = [];
  @override
  void initState() {
    getAllUserData();
    super.initState();
  }

  getAllUserData() async {
    dynamic list = await Firestore().fetchDataFireStore();
    if (list != null) {
      setState(() {
        _userList = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 10,
          backgroundColor: Colors.blueGrey,
          title: const Text("MessageMe"),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Chat",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Friend",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  provider.userLogout();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 22,
                  color: Colors.white,
                ))
          ],
        ),
        body: TabBarView(children: [
          ChatScreen(user: _userList),
          FriendScreen(
            user: _userList,
          ),
        ]),
      ),
    );
  }
}
