import 'package:cricket_app/screen/homePage.dart';
import 'package:cricket_app/screen/playerpage.dart';
import 'package:cricket_app/screen/privacypolicy.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Homepage(),
    );
  }
}


