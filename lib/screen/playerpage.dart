import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Playerpage extends StatefulWidget {
  const Playerpage({super.key});

  @override
  _PlayerpageState createState() => _PlayerpageState();
}

class _PlayerpageState extends State<Playerpage> {
  List<dynamic> players = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  Future<void> fetchPlayers() async {
    final String url = 'https://cricbuzz-cricket.p.rapidapi.com/stats/v1/player/search?plrN=Tucker';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1',  // Replace with your API key
          'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          var data = json.decode(response.body);
          print(data); // Print data to check response structure
          players = data['player'] ?? []; // Ensure this key exists in the response
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load players: ${response.reasonPhrase}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    var player = players[index];
                    var name = player['name'] ?? 'Unknown Player';
                    var teamName = player['teamName'] ?? 'Unknown Team';
                    var faceImageId = player['faceImageId'] ?? '';

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        leading: faceImageId.isNotEmpty
                            ? Image.network(
                                'https://cricbuzz-cricket.p.rapidapi.com/images/$faceImageId',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.person, size: 50),
                        title: Text(name, style: TextStyle(fontSize: 18)),
                        subtitle: Text(teamName, style: TextStyle(fontSize: 16)),
                      ),
                    );
                  },
                ),
    );
  }
}
