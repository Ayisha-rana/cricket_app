import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> _news = [];
  bool _isLoading = true;

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
          var newsListData = data['topics'] as List;
          _news = newsListData.map((item) => News.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        print('Unexpected data format');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Failed to load data, status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _news.isEmpty
              ? Center(child: Text('No news available'))
              : ListView.builder(
                  itemCount: _news.length,
                  itemBuilder: (context, index) {
                    final newsItem = _news[index];

                    return ListTile(
                      title: Text(newsItem.headline),
                      subtitle: Text(newsItem.description),
                    );
                  },
                ),
    );
  }
}
