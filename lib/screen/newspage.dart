import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List _news = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/news/v1/topics'),
      headers: {
        'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data'); // Print the response data for debugging

      // Check the structure of the data and adjust accordingly
      if (data is Map) {
        // Assume the list of news items is under a key 'topics' 
        setState(() {
          _news = data['topics'] ?? []; // Update this key based on actual structure
        });
      } else {
        print('Uneaxpected data format');
      }
    } else {
      print('Failed to load data, status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                final newsItem = _news[index];
                print('News item: $newsItem'); 

                // Adjust these keys based on actual structure
                final headline = newsItem['headline'] ?? 'No Title'; 
                final intro = newsItem['description'] ?? 'No Description';

                return ListTile(
                  title: Text(headline),
                  subtitle: Text(intro),
                );
              },
            ),
    );
  }
}
