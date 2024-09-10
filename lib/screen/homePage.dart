import 'dart:convert';
import 'package:cricket_app/screen/morepage.dart';
import 'package:cricket_app/screen/newspage.dart';
import 'package:cricket_app/screen/rankingspage.dart';
import 'package:cricket_app/screen/schedulepage.dart';
import 'package:cricket_app/screen/statspage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    RecentMatchesPage(), // Updated to include both recent matches and news
    MatchSchedulesScreen(),
    NewsPage(),
    RankingsPage(),
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onTap,
            items: const [
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
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            iconSize: 28,
            elevation: 10,
          ),
        ),
      ),
    );
  }
}

class RecentMatchesPage extends StatefulWidget {
  @override
  _RecentMatchesPageState createState() => _RecentMatchesPageState();
}

class _RecentMatchesPageState extends State<RecentMatchesPage> {
  List recentMatches = [];
  List newsHeadlines = [];

  @override
  void initState() {
    super.initState();
    fetchRecentMatches();
    fetchNews();
  }

  Future<void> fetchRecentMatches() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/matches/v1/recent'),
      headers: {
        'X-RapidAPI-Key': '366acfd63bmsh27e7e751a2f375ap1c5833jsn023e46aa6ce9',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List allMatches = [];

      // Iterating over each series in the seriesMatches map
      for (var series in data['typeMatches'][0]['seriesMatches']) {
        if (series.containsKey('seriesAdWrapper')) {
          var matches = series['seriesAdWrapper']['matches'];
          allMatches.addAll(matches); // Add matches to allMatches list
        }
      }

      setState(() {
        recentMatches = allMatches;
      });
    } else {
      throw Exception('Failed to load recent matches');
    }
  }

  Future<void> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/news/v1/topics'),
      headers: {
        'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map) {
        setState(() {
          // Limit to top 10 news items
          newsHeadlines = (data['topics'] ?? []).take(10).toList();
        });
      } else {
        print('Unexpected data format');
      }
    } else {
      print('Failed to load news, status code: ${response.statusCode}');
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 160, 115),
        title: Text('Cricket App',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MorePage()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              // Recent Matches
              Container(
                height: 250,
                child: recentMatches.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentMatches.length,
                        itemBuilder: (context, index) {
                          final match = recentMatches[index]['matchInfo'];
                          final matchScore = recentMatches[index]['matchScore'];

                          return Container(
                            width: 300, // Adjust the width for better spacing
                            child: Card(
                              color:Color.fromARGB(255, 251, 255, 252) ,
                              elevation: 5, // Adds shadow for depth
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Rounded corners
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      match['matchDesc'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Series: ${match['seriesName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${match['team1']['teamSName']} vs ${match['team2']['teamSName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.redAccent,
                                          size: 16,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            '${match['venueInfo']['ground']}, ${match['venueInfo']['city']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Status: ${match['status']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // News Headlines
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Top News',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    TextButton(
                        onPressed: () {
                          NewsPage();
                        },
                        child: Text('See All'))
                  ],
                ),
              ),
              Container(
                child: newsHeadlines.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true, // Adjust size to fit content
                        physics:
                            NeverScrollableScrollPhysics(), // Prevent scrolling
                        itemCount: newsHeadlines.length,
                        itemBuilder: (context, index) {
                          final newsItem = newsHeadlines[index];
                          final headline = newsItem['headline'] ?? 'No Title';
                          final intro =
                              newsItem['description'] ?? 'No Description';

                          return ListTile(
                            title: Text(headline),
                            subtitle: Text(intro),
                          );
                        },
                      ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
