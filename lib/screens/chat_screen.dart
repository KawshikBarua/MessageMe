import 'package:chat_app/service/firebase_auth.dart';
import 'package:chat_app/service/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/friend_tiles.dart';

class ChatScreen extends StatefulWidget {
  final List user;
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String msg = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.user.length,
                itemBuilder: (context, item) {
                  if (widget.user[item]['uid'] != provider.getUserId()) {
                    Database db = Database(
                        myId: provider.getUserId(),
                        frndId: widget.user[item]['uid']);
                    return StreamBuilder(
                        stream: db.getLastText(),
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (snapshot.hasData &&
                              !snapshot.hasError &&
                              snapshot.data!.snapshot.value != null) {
                            String lastText = "";
                            Map<dynamic, dynamic> map = snapshot
                                .data!.snapshot.value as Map<dynamic, dynamic>;
                            map.forEach(((key, value) {
                              lastText = value['text'];
                            }));
                            return FriendTiles(
                                info: widget.user[item], lastText: lastText);
                          }
                          return const SizedBox(
                            width: 0,
                            height: 0,
                          );
                        });
                  }
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }),
          )
        ],
      ),
    );
  }
}
