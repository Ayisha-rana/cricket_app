import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<dynamic> standings = [];
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
      print(response.body); // Print the response body for debugging
      try {
        var data = json.decode(response.body);
        print('Decoded JSON data: $data'); // Print decoded JSON data
        setState(() {
          standings = data['values'] ?? [];
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
        title: Text('Stats and Records'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : standings.isEmpty
          ? Center(child: Text('No standings available'))
          : ListView.builder(
        itemCount: standings.length,
        itemBuilder: (context, index) {
          var team = standings[index]['value'] ?? [];
          var rank = team[0] ?? 'No Rank';
          var flag = team[1] ?? 'No Flag'; 
          var teamName = team[2] ?? 'No Team Name';
          var points = team[3] ?? 'No Points Available';

          return Card(
            child: ListTile(
              leading: flag != 'No Flag' ? Icon(Icons.flag) : null, // Placeholder for flag icon
              title: Text('$rank. $teamName'),
              subtitle: Text('Points: $points'),
            ),
          );
        },
      ),
    );
  }
}