import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:cricket_app/screen/rapidApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Playerpage extends StatefulWidget {
  const Playerpage({super.key});

  @override
  _PlayerpageState createState() => _PlayerpageState();
}

class _PlayerpageState extends State<Playerpage> {
  List<Player> _players = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlayerData();
  }

  Future<void> _fetchPlayerData() async {
    final url =
        'https://cricbuzz-cricket.p.rapidapi.com/series/v1/3718/squads/15826';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Host':  ApiConfig.rapidApiKey,
        'X-RapidAPI-Key': ApiConfig.rapidApiHost,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Player> players = (data['player'] as List)
          .map((playerJson) => Player.fromJson(playerJson))
          .toList();

      setState(() {
        _players = players;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load player data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 147, 88),
        title: const Text(
          'Players',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final player = _players[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      player.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player.role,style: TextStyle(color: Colors.green),),
                        const SizedBox(height: 4),
                        Text('Batting Style: ${player.battingStyle}'),
                        const SizedBox(height: 4),
                        Text('Bowling Style: ${player.bowlingStyle ?? 'N/A'}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
