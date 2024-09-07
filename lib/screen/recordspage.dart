import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Recordspage extends StatelessWidget {
  const Recordspage({super.key});

  Future<List<StatsCategory>> fetchStats() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/stats/v1/topstats'),
      headers: {
        'X-RapidAPI-Key': '9af4284c3cmshd23f13b75b24bd6p1788b2jsnb00341e62d58',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<StatsCategory> categories = (data['statsTypesList'] as List)
          .map((category) => StatsCategory.fromJson(category))
          .toList();
      return categories;
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
      body: FutureBuilder<List<StatsCategory>>(
        future: fetchStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          }

          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ExpansionTile(
                title: Text(category.category),
                children: category.types.map((stat) {
                  return ListTile(
                    title: Text(stat.header),
                    subtitle: Text(stat.category),
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
