import 'package:chat_app/model/msg_model.dart';
import 'package:chat_app/service/firebase_auth.dart';
import 'package:chat_app/service/firebase_database.dart';
import 'package:chat_app/utils/text_container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  final dynamic frndInfo;
  const ChatRoom({Key? key, required this.frndInfo}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    Size size = MediaQuery.of(context).size;
    Database database =
        Database(myId: provider.getUserId(), frndId: widget.frndInfo['uid']);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(Icons.people),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "${widget.frndInfo['fName']} ${widget.frndInfo['lName']}",
                )
              ]),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 2,
              ),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: database.getChatFromDatabase(),
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        List _list = [];
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data!.snapshot.value != null) {
                          Map<dynamic, dynamic> value = snapshot
                              .data!.snapshot.value as Map<dynamic, dynamic>;
                          value.forEach((key, value) {
                            _list.add(value);
                          });
                          _list.sort((a, b) {
                            var timeA = a['time'].toString();
                            var timeB = b['time'].toString();
                            return timeA.compareTo(timeB);
                          });
                          _list = _list.reversed.toList();
                          return Expanded(
                              child: ListView.separated(
                                  reverse: true,
                                  controller: _scrollController,
                                  separatorBuilder: (context, item) =>
                                      const SizedBox(
                                        height: 25,
                                      ),
                                  itemCount: _list.length,
                                  itemBuilder: (context, item) {
                                    return TextContainer(
                                        text: _list[item]['text'],
                                        sender: _list[item]['uid'] ==
                                                provider.getUserId()
                                            ? 0
                                            : 1);
                                  }));
                        } else {
                          return const Expanded(child: Text('Say Hello!'));
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * 0.1,
                    width: size.width,
                    color: Colors.grey.shade300,
                    child: Row(children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade200),
                        child: TextField(
                          onTap: () => _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent),
                          controller: _msgController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Enter your message",
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          //data is updated in realtime database
                          if (_msgController.text.toString() != '') {
                            DateTime time = DateTime.now();
                            database.addChatToDataBase(Message(
                                text: _msgController.text.toString(),
                                time: time,
                                uid: provider.getUserId()));
                            _msgController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
