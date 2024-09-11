import 'dart:convert';
import 'package:cricket_app/screen/morepage.dart';
import 'package:cricket_app/screen/rapidApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamStanding {
  final String rank;
  final String team;
  final String pct;

  TeamStanding({required this.rank, required this.team, required this.pct});

  factory TeamStanding.fromJson(List<dynamic> json) {
    return TeamStanding(
      rank: json[0] ?? 'No Rank',
      team: json[2] ?? 'No Team',
      pct: json[3] ?? 'No PCT',
    );
  }
}

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<TeamStanding> standings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStandings();
  }

  Future<void> fetchStandings() async {
    final String url =
        'https://cricbuzz-cricket.p.rapidapi.com/stats/v1/iccstanding/team/matchtype/1';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key':  ApiConfig.rapidApiKey,
        'X-RapidAPI-Host':  ApiConfig.rapidApiHost,
      },
    );

    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print('Decoded JSON data: $data'); // Print decoded JSON data

        setState(() {
          standings = (data['values'] as List)
              .map((item) => TeamStanding.fromJson(item['value']))
              .toList();
          isLoading = false;
        });
      } catch (e) {
        print('Error parsing JSON: $e');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print('Failed to load standings');
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load standings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MorePage()));
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 94, 160, 115),
        title: Text('Team Standings'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : standings.isEmpty
              ? Center(child: Text('No standings available'))
              : ListView.builder(
                  itemCount: standings.length,
                  itemBuilder: (context, index) {
                    final standing = standings[index];

                    return Card(
                      color: Color.fromARGB(255, 251, 255, 252),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Color.fromARGB(255, 94, 160, 115),
                          child: Text(
                            standing.rank,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          standing.team,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        trailing: Text(
                          standing.pct,
                          style: TextStyle(color: Colors.blue[600]),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
