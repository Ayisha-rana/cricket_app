import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:cricket_app/screen/morepage.dart';
import 'package:cricket_app/screen/newsdetails.dart';
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
        'X-RapidAPI-Key': '9af4284c3cmshd23f13b75b24bd6p1788b2jsnb00341e62d58',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map) {
        setState(() {
          var newsListData = data['topics'] as List;
          _news = newsListData.map((item) => News.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
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
        backgroundColor: Color.fromARGB(255, 94, 160, 115),
        title: Text('Latest News'),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _news.isEmpty
              ? Center(child: Text('No news available'))
              : ListView.builder(
                
                  itemCount: _news.length,
                  itemBuilder: (context, index) {
                    final newsItem = _news[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailsPage(newsItem: newsItem),
                          ),
                        );
                      },
                      child: Card(
                        color: Color.fromARGB(255, 251, 255, 252),
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                newsItem.headline,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                newsItem.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 15),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Read More",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 94, 160, 115),
                                    fontWeight: FontWeight.bold,
                                  ),
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
