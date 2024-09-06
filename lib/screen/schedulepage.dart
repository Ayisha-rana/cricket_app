import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatchSchedulesScreen extends StatefulWidget {
  @override
  _MatchSchedulesScreenState createState() => _MatchSchedulesScreenState();
}

class _MatchSchedulesScreenState extends State<MatchSchedulesScreen> {
  List<dynamic> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMatchSchedules();
  }

  Future<void> fetchMatchSchedules() async {
    final String url = 'https://cricbuzz-cricket.p.rapidapi.com/schedule/v1/international';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      print(response.body); // Print the response body for debugging
      setState(() {
        var data = json.decode(response.body);
        schedules = data['matchScheduleMap'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Faialed to load schedules');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Schedules'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          var schedule = schedules[index]['scheduleAdWrapper'] ?? {};
          var matchScheduleList = schedule['matchScheduleList'] ?? [];

          // Check if matchScheduleList is not empty
          var seriesName = 'No Series Name'; // Default value
          if (matchScheduleList.isNotEmpty) {
            var firstMatch = matchScheduleList[0];
            seriesName = firstMatch['seriesName'] ?? 'No Series Name';
          }

          var date = schedule['date'] ?? 'No Date Available';

          return Card(
            child: ListTile(
              title: Text(seriesName),
              subtitle: Text('Date: $date'),
            ),
          );
        },
      ),
    );
  }
}