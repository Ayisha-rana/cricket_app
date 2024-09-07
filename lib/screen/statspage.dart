import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsCategory {
  final String category;
  final List<StatsType> types;

  StatsCategory({required this.category, required this.types});

  factory StatsCategory.fromJson(Map<String, dynamic> json) {
    return StatsCategory(
      category: json['category'] ?? 'No Category',
      types: (json['types'] as List)
          .map((type) => StatsType.fromJson(type))
          .toList(),
    );
  }
}

// Model class for StatsType
class StatsType {
  final String header;
  final String category;

  StatsType({required this.header, required this.category});

  factory StatsType.fromJson(Map<String, dynamic> json) {
    return StatsType(
      header: json['header'] ?? 'No Header',
      category: json['category'] ?? 'No Category',
    );
  }
}

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<StatsCategory> standings = [];
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
              .map((item) => StatsCategory.fromJson(item))
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
        title: Text('Stats and Records'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : standings.isEmpty
              ? Center(child: Text('No standings available'))
              : ListView.builder(
                  itemCount: standings.length,
                  itemBuilder: (context, index) {
                    final category = standings[index];

                    return ExpansionTile(
                      title: Text(category.category),
                      children: category.types.map((type) {
                        return ListTile(
                          title: Text(type.header),
                          subtitle: Text(type.category),
                        );
                      }).toList(),
                    );
                  },
                ),
    );
  }
}
