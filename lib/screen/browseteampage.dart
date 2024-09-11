// lib/team_page.dart
import 'package:cricket_app/servicePage/apifunctions.dart';
import 'package:flutter/material.dart';

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
    TeamService teamService = TeamService();

    try {
      final data = await teamService.fetchTeamData();

      setState(() {
        playingXI = data['players']['playing XI'] ?? [];
        bench = data['players']['bench'] ?? [];
        isLoading = false;
      });
    } catch (error) {
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                ...playingXI.map((player) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(player['fullName'] ?? 'Unknown'),
                        subtitle: Text(player['role'] ?? 'Unknown Role'),
                        trailing: Text(
                          player['battingStyle'] ?? 'N/A',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    )),
                const SizedBox(height: 16),
                const Text(
                  'Bench',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
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
