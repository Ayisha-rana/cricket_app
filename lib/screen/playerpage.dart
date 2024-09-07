import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
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
    final url = 'https://cricbuzz-cricket.p.rapidapi.com/series/v1/3718/squads/15826';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
        'X-RapidAPI-Key': '9af4284c3cmshd23f13b75b24bd6p1788b2jsnb00341e62d58',
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
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final player = _players[index];
                if (player.isHeader) {
                  return ListTile(
                    title: Text(
                      player.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    tileColor: Colors.grey[200],
                  );
                } else {
                  return ListTile(
                    title: Text(
                      player.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      '${player.role}\nBatting Style: ${player.battingStyle}\nBowling Style: ${player.bowlingStyle ?? 'N/A'}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  );
                }
              },
            ),
    );
  }
}
