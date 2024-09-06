import 'package:cricket_app/screen/more.dart';
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

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Scores')), // Page 2: Scores
    MatchSchedulesScreen(),
    NewsPage(),
    Rankings(),
    StatsScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed, // Makes the items fixed
            currentIndex: _currentIndex, // Current selected index
            onTap: _onTap, // Change page on tap
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.score),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Rankings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Stats',
              ),
            ],
            selectedItemColor: Colors.blueAccent, // Color for selected item
            unselectedItemColor: Colors.grey, // Color for unselected items
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold), // Bold selected label
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal), // Normal unselected label
            iconSize: 28, // Size of the icons
            elevation: 10, // Elevation effect
          ),
        ),
      ),
    );
  }
}
