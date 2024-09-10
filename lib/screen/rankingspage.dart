import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
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
        Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/stats/v1/rankings/batsmen?formatType=test'),
        headers: {
          'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1', // Replace with your actual API key
          'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
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
        title: Text('Batsmen Rankings'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _batsmen.length,
              itemBuilder: (context, index) {
                final batsman = _batsmen[index];
                print('Batsman item: $batsman'); // Debugging

                return ListTile(
                  title: Text(batsman.name),
                  subtitle: Text('Rating: ${batsman.rating}\nCountry: ${batsman.country}'),
                );
              },
            ),
    );
  }
}
