import 'package:chat_app/service/firebase_auth.dart';
import 'package:chat_app/service/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_info.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

Widget inputs(TextEditingController controller, String text, Size size) {
  return SizedBox(
    height: 80,
    width: size.width * 0.85,
    child: TextField(
        cursorColor: Colors.amber.shade200,
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
            labelText: text, labelStyle: const TextStyle(color: Colors.white))),
  );
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fNameControl = TextEditingController();

  final TextEditingController _lNameControl = TextEditingController();

  final TextEditingController _mailControl = TextEditingController();

  final TextEditingController _passwordControl = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _fNameControl.dispose();
    _lNameControl.dispose();
    _mailControl.dispose();
    _passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 50),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w300,
                          color: Colors.amber.shade200),
                    ),
                  ),
                ),
                inputs(_fNameControl, "Enter your First Name..", size),
                inputs(_lNameControl, "Enter your Last Name..", size),
                inputs(_mailControl, "Enter your Email address..", size),
                inputs(_passwordControl, "Enter your Password..", size),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 55,
                    width: size.width * 0.67,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber.shade200),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        String fName = _fNameControl.text.toString();
                        String lName = _lNameControl.text.toString();
                        String mail = _mailControl.text.toString();
                        String password = _passwordControl.text.toString();
                        Timestamp now = Timestamp.now();
                        provider.registerWithCred(mail, password).then((value) {
                          if (value != null) {
                            Firestore().addUserData(
                                value.uid,
                                InfoUser(
                                    fName: fName,
                                    lName: lName,
                                    registeredDate: now,
                                    uid: value.uid));
                          }
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                  width: size.width * 0.67,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        width: 2.6,
                                        color: Colors.amber.shade200)))),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Back",
                      style:
                          TextStyle(fontSize: 16, color: Colors.amber.shade200),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
