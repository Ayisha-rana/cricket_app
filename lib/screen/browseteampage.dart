import 'dart:convert'; // For JSON decoding
import 'package:cricket_app/utilspage/rapidApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  List<dynamic> playingXI = [];
  List<dynamic> bench = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTeamData();
  }

  Future<void> fetchTeamData() async {
    const String apiUrl =
        'https://cricbuzz-cricket.p.rapidapi.com/mcenter/v1/35878/team/9';

    final headers = {
      'X-RapidAPI-Key':  ApiConfig.rapidApiKey,
      'X-RapidAPI-Host':  ApiConfig.rapidApiHost,
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          playingXI = data['players']['playing XI'] ?? [];
          bench = data['players']['bench'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load team data');
      }
    } catch (error) {
      // Print error and show error message
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load team data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Players'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 85, 147, 88),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const Text(
                  'Playing XI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green),
                ),
                ...playingXI.map((player) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(player['fullName'] ?? 'Unknown',),
                        subtitle: Text(player['role'] ?? 'Unknown Role'),
                        trailing: Text(player['battingStyle'] ?? 'N/A',style: TextStyle(color: Colors.blue),),
                      ),
                    )),
                const SizedBox(height: 16),
                const Text(
                  'Bench',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green),
                ),
                ...bench.map((player) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(player['fullName'] ?? 'Unknown'),
                        subtitle: Text(player['role'] ?? 'Unknown Role'),
                        trailing: Text(player['battingStyle'] ?? 'N/A'),
                      ),
                    )),
              ],
            ),
    );
  }
}
