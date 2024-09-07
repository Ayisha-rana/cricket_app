import 'dart:convert';

// News Model
class News {
  final String headline;
  final String description;

  News({
    required this.headline,
    required this.description,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      headline: json['headline'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
    );
  }
}

// Series Model
class Series {
  final String date;
  final List<SeriesDetail> series;

  Series({
    required this.date,
    required this.series,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    var seriesList = json['series'] as List;
    List<SeriesDetail> seriesDetails = seriesList.map((i) => SeriesDetail.fromJson(i)).toList();

    return Series(
      date: json['date'] ?? 'Unknown Date',
      series: seriesDetails,
    );
  }
}

// SeriesDetail Model
class SeriesDetail {
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  SeriesDetail({
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory SeriesDetail.fromJson(Map<String, dynamic> json) {
    return SeriesDetail(
      name: json['name'] ?? 'No Name',
      startDate: DateTime.parse(json['startDt'] ?? '1970-01-01T00:00:00Z'), // Use ISO 8601 format
      endDate: DateTime.parse(json['endDt'] ?? '1970-01-01T00:00:00Z'),
    );
  }
}

// Player Model
class Player {
  final String fullName;
  final String role;
  final String battingStyle;

  Player({
    required this.fullName,
    required this.role,
    required this.battingStyle,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      fullName: json['fullName'] ?? 'Unknown',
      role: json['role'] ?? 'Unknown Role',
      battingStyle: json['battingStyle'] ?? 'N/A',
    );
  }
}

// Batsman Model
class Batsman {
  final String name;
  final String rating;
  final String country;

  Batsman({
    required this.name,
    required this.rating,
    required this.country,
  });

  factory Batsman.fromJson(Map<String, dynamic> json) {
    return Batsman(
      name: json['name'] ?? 'No Name',
      rating: json['rating'] ?? 'No Rating',
      country: json['country'] ?? 'No Country',
    );
  }
}

// Team Model (for Standings)
class Team {
  final String rank;
  final String flag;
  final String name;
  final String points;

  Team({
    required this.rank,
    required this.flag,
    required this.name,
    required this.points,
  });

  factory Team.fromJson(List<dynamic> json) {
    return Team(
      rank: json[0] ?? 'No Rank',
      flag: json[1] ?? 'No Flag',
      name: json[2] ?? 'No Team Name',
      points: json[3] ?? 'No Points Available',
    );
  }
}
