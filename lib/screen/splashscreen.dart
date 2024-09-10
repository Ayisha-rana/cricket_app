import 'package:cricket_app/screen/homePage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    
    // Set a timer for the splash screen duration
    Timer(const Duration(seconds: 3), () {
      // After the timer ends, navigate to the next page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Homepage ()), // Replace 'NextPage' with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJPvcR7Y7JkXaiMdvnV4-mpqDxO1P7Rm94gA&s',
        ),
      ),
    );
  }
}