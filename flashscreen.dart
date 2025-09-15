import 'package:flutter/material.dart';
import 'package:notes/home_screen.dart';

class Flashscreen extends StatefulWidget {
  @override
  State<Flashscreen> createState() => _FlashscreenState();
}

class _FlashscreenState extends State<Flashscreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("images/flashscreen.png", width: 200, height: 200),
      ),
    );
  }
}
