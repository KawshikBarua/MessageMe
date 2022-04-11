import 'package:chat_app/screens/landing_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/firebase_auth.dart';

class CheckSigned extends StatelessWidget {
  const CheckSigned({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context, listen: false);

    return StreamBuilder<User?>(
      stream: provider.authChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final userData = snapshot.data;
          return userData != null ? const LandingPage() : const LoginScreen();
        } else {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
