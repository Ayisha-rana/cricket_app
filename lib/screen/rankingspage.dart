import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:cricket_app/screen/morepage.dart';
import 'package:cricket_app/screen/rapidApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RankingsPage extends StatefulWidget {
  @override
  _RankingsPageState createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage> {
  List<Batsman> _batsmen = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBatsmenRankings();
  }

  Future<void> fetchBatsmenRankings() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://cricbuzz-cricket.p.rapidapi.com/stats/v1/rankings/batsmen?formatType=test'),
        headers: {
          'X-RapidAPI-Key':
               ApiConfig.rapidApiKey,
          'X-RapidAPI-Host':  ApiConfig.rapidApiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response data: $data'); // Print the response data for debugging

        setState(() {
          if (data is Map && data.containsKey('rank')) {
            _batsmen = (data['rank'] as List)
                .map((json) => Batsman.fromJson(json))
                .toList();
          } else {
            print('Unexpected data format');
            _batsmen = [];
          }
          _isLoading = false;
        });
      } else {
        print('Failed to load data, status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Exception occurred: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MorePage()));
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 94, 160, 115),
        title: Text('Batsmen Rankings'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _batsmen.length,
              itemBuilder: (context, index) {
                final batsman = _batsmen[index];
                print('Batsman item: $batsman'); // Debugging

                return Card(
                  color: Color.fromARGB(255, 251, 255, 252),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      batsman.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      'Rating: ${batsman.rating}\nCountry: ${batsman.country}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
