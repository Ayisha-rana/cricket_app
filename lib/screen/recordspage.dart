import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:cricket_app/screen/rapidApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Recordspage extends StatelessWidget {
  const Recordspage({super.key});

  Future<List<StatsCategory>> fetchStats() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/stats/v1/topstats'),
      headers: {
        'X-RapidAPI-Key':  ApiConfig.rapidApiKey,
        'X-RapidAPI-Host':  ApiConfig.rapidApiHost,
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
        backgroundColor: const Color.fromARGB(255, 94, 160, 115),
        title: Text('Cricket Records'),
        centerTitle: true,
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: ExpansionTile(
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: const Color.fromARGB(255, 94, 160, 115).withOpacity(0.1),
                      
                      iconColor: const Color.fromARGB(255, 94, 160, 115),
                     
                      title: Text(
                        category.category,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 94, 160, 115),
                        ),
                      ),
                      children: category.types.map((stat) {
                        return ListTile(
                          title: Text(
                            stat.header,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            stat.category,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          leading: Icon(Icons.analytics, color:const Color.fromARGB(255, 94, 160, 115)),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                         
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
