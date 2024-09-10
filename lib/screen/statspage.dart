import 'dart:convert';
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
    final String url = 'https://cricbuzz-cricket.p.rapidapi.com/stats/v1/iccstanding/team/matchtype/1';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
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
        title: Text('Team Standings'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : standings.isEmpty
              ? Center(child: Text('No standings available'))
              : ListView.builder(
                  itemCount: standings.length,
                  itemBuilder: (context, index) {
                    final standing = standings[index];

                    return ListTile(
                      leading: Text(standing.rank),
                      title: Text(standing.team),
                      trailing: Text(standing.pct),
                    );
                  },
                ),
    );
  }
}
