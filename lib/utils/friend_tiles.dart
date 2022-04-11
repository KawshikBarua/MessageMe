import 'package:chat_app/screens/chat_room.dart';
import 'package:flutter/material.dart';

class FriendTiles extends StatelessWidget {
  final dynamic info;
  final String lastText;

  const FriendTiles({Key? key, required this.info, required this.lastText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: ((context) => ChatRoom(frndInfo: info)))),
      child: lastText != ""
          ? ListTile(
              title: Text(
                "${info['fName']} ${info['lName']}",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle: Text(lastText),
              leading: const Icon(
                Icons.people_alt_outlined,
                size: 33,
              ),
            )
          : ListTile(
              title: Text(
                "${info['fName']} ${info['lName']}",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              leading: const Icon(
                Icons.people_alt_outlined,
                size: 33,
              ),
            ),
    );
  }
}
