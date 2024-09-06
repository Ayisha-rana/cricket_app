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
    Center(child: Text('Scores')),
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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(82, 135, 82, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MorePage()));
            },
          ),
        ],
      ),
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
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock),
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
            selectedItemColor: const Color.fromARGB(255, 116, 185, 118),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            iconSize: 28,
            elevation: 10,
          ),
        ),
      ),
    );
  }
}
