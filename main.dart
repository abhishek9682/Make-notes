import 'package:flutter/material.dart';
import 'package:notes/speech_to_text.dart';

import 'Ai chatbot/ai.dart';
import 'Authorization/Registration.dart';
import 'Authorization/login_page.dart';
import 'flashscreen.dart';
import 'home_screen.dart';
import 'notebytext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: RegisterPage(),
    );
  }
}
