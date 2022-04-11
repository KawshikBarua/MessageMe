import 'package:chat_app/service/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/friend_tiles.dart';

class FriendScreen extends StatefulWidget {
  final List user;
  const FriendScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<AuthController>(context);
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
                  return FriendTiles(
                    info: widget.user[item],
                    lastText: "",
                  );
                }
                return const SizedBox(
                  height: 0,
                  width: 0,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
