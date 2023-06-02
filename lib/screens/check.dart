import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';
import 'package:pomodoro/screens/login.dart';

class ChecarPage extends StatefulWidget {
  const ChecarPage({super.key});

  @override
  State<ChecarPage> createState() => _ChecarPageState();
}

class _ChecarPageState extends State<ChecarPage> {
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LogInScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
