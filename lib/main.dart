import 'package:chat_app/screens/check_screen.dart';
import 'package:chat_app/service/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthController>(
      create: (_) => AuthController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckSigned(),
      ),
    );
  }
}
