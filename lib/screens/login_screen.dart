import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/service/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool onPressed = false;

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Message",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: "Me",
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.amber.shade200))
                  ]),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    cursorColor: Colors.amber,
                    style: const TextStyle(color: Colors.white),
                    controller: mailController,
                    decoration: const InputDecoration(
                        hintText: "Enter your mail",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    cursorColor: Colors.amber,
                    style: const TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: onPressed ? false : true,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                onPressed = !onPressed;
                              });
                            },
                            icon: Icon(
                              onPressed
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            )),
                        hintText: "Enter your Password",
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 50,
                    width: size.width * 0.67,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber.shade200),
                        onPressed: () {
                          if (mailController.text != '' &&
                              passwordController.text != '') {
                            provider.loginWithCred(
                                mailController.text.toString().trim(),
                                passwordController.text.toString().trim());
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.login,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register using your email address.",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen()));
                        },
                        child: Text(
                          "Click here",
                          style: TextStyle(color: Colors.amber.shade200),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
