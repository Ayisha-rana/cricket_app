import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:cricket_app/screen/morepage.dart';
import 'package:cricket_app/utilspage/rapidApi.dart';
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
        'X-RapidAPI-Key': ApiConfig.rapidApiKey,
        'X-RapidAPI-Host': ApiConfig.rapidApiHost,
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
        backgroundColor: const Color.fromARGB(255, 94, 160, 115),
        title: const Text('Match Schedules'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MorePage()));
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                var schedule = schedules[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color.fromARGB(255, 251, 255, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule.seriesName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Space between series name and date
                          Text(
                            'Date: ${schedule.date}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
