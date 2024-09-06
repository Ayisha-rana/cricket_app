import 'package:cricket_app/screen/rankings.dart';
import 'package:cricket_app/screen/schedule.dart';
import 'package:cricket_app/screen/stats.dart';
import 'package:flutter/material.dart';
import 'package:cricket_app/screen/news.dart';

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
      home: MainPage(),
    );
  }
}

