// lib/services/team_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utilspage/rapidApi.dart';

class TeamService {
  final String apiUrl =
      'https://cricbuzz-cricket.p.rapidapi.com/mcenter/v1/35878/team/9';

  Future<Map<String, dynamic>> fetchTeamData() async {
    final headers = {
      'X-RapidAPI-Key': ApiConfig.rapidApiKey,
      'X-RapidAPI-Host': ApiConfig.rapidApiHost,
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load team data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
