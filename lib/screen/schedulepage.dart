import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:cricket_app/screen/morepage.dart';
import 'package:cricket_app/screen/rapidApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatchSchedulesScreen extends StatefulWidget {
  @override
  _MatchSchedulesScreenState createState() => _MatchSchedulesScreenState();
}

class _MatchSchedulesScreenState extends State<MatchSchedulesScreen> {
  List<MatchSchedule> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMatchSchedules();
  }

  Future<void> fetchMatchSchedules() async {
    final String url =
        'https://cricbuzz-cricket.p.rapidapi.com/schedule/v1/international';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key':  ApiConfig.rapidApiKey,
        'X-RapidAPI-Host':  ApiConfig.rapidApiHost,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body)['matchScheduleMap'] ?? [];
        schedules = data
            .map<MatchSchedule>((json) => MatchSchedule.fromJson(json))
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 94, 160, 115),
        title: Text('Match Schedules'),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                var schedule = schedules[index];

                return Card(
                  color: Color.fromARGB(255, 251, 255, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schedule.seriesName,
                              style: TextStyle(
                                  fontSize:
                                      20), // Optionally increase text size
                            ),
                            SizedBox(
                                height:
                                    10), // Add space between series name and date
                            Text(
                              'Date: ${schedule.date}',
                              style: TextStyle(
                                  fontSize:
                                      16), // Optionally increase subtitle size
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
