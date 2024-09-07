import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Recordspage extends StatelessWidget {
  const Recordspage({super.key});

  Future<Map<String, dynamic>> fetchStats() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/stats/v1/topstats'),
      headers: {
        'X-RapidAPI-Key': '9af4284c3cmshd23f13b75b24bd6p1788b2jsnb00341e62d58',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load stats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Records'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          }

          final statsList = snapshot.data!['statsTypesList'];
          return ListView.builder(
            itemCount: statsList.length,
            itemBuilder: (context, index) {
              final category = statsList[index];
              return ExpansionTile(
                title: Text(category['category']),
                children: (category['types'] as List).map((stat) {
                  return ListTile(
                    title: Text(stat['header']),
                    subtitle: Text(stat['category']),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
