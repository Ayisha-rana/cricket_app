class News {
  final String headline;
  final String description;
  final String? content; // Make sure content is nullable.

  News({required this.headline, required this.description, this.content});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      headline: json['headline'] as String,
      description: json['description'] as String,
      content: json['content'] as String?, // Ensure content can be null.
    );
  }
}


// Series Model
class Series {
  final int id;
  final String name;
  final String startDt;
  final String endDt;
  final bool isFantasyHandbookEnabled;

  Series({
    required this.id,
    required this.name,
    required this.startDt,
    required this.endDt,
    this.isFantasyHandbookEnabled = false,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'],
      name: json['name'],
      startDt: json['startDt'],
      endDt: json['endDt'],
      isFantasyHandbookEnabled: json['isFantasyHandbookEnabled'] ?? false,
    );
  }

  String get startDate => _formatDate(startDt);
  String get endDate => _formatDate(endDt);

  String _formatDate(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return '${date.day}-${date.month}-${date.year}';
  }
}

class SeriesData {
  final String date;
  final List<Series> series;

  SeriesData({
    required this.date,
    required this.series,
  });
}

class Player {
  final String name;
  final String role;
  final String battingStyle;
  final String? bowlingStyle;
  final bool isHeader;

  Player({
    required this.name,
    required this.role,
    required this.battingStyle,
    this.bowlingStyle,
    required this.isHeader,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] ?? 'No Name',
      role: json['role'] ?? 'No Role',
      battingStyle: json['battingStyle'] ?? 'No Batting Style',
      bowlingStyle: json['bowlingStyle'],
      isHeader: json['isHeader'] ?? false,
    );
  }
}

// NewsItem Model
class NewsItem {
  final String headline;
  final String description;

  NewsItem({required this.headline, required this.description});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      headline: json['headline'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
    );
  }
}

// Model for individual match schedule
class MatchSchedule {
  final String seriesName;
  final String date;

  MatchSchedule({
    required this.seriesName,
    required this.date,
  });

  factory MatchSchedule.fromJson(Map<String, dynamic> json) {
    var matchScheduleList = json['scheduleAdWrapper']?['matchScheduleList'] ?? [];
    String seriesName = matchScheduleList.isNotEmpty
        ? matchScheduleList[0]['seriesName'] ?? 'No Series Name'
        : 'No Series Name';
    String date = json['scheduleAdWrapper']?['date'] ?? 'No Date Available';

    return MatchSchedule(
      seriesName: seriesName,
      date: date,
    );
  }
}


// Model for match info
class MatchInfo {
  final String matchDesc;
  final String seriesName;
  final String team1Name;
  final String team2Name;
  final String venue;
  final String city;
  final String status;

  MatchInfo({
    required this.matchDesc,
    required this.seriesName,
    required this.team1Name,
    required this.team2Name,
    required this.venue,
    required this.city,
    required this.status,
  });

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    return MatchInfo(
      matchDesc: json['matchDesc'] ?? 'No Description',
      seriesName: json['seriesName'] ?? 'No Series Name',
      team1Name: json['team1']['teamSName'] ?? 'No Team 1',
      team2Name: json['team2']['teamSName'] ?? 'No Team 2',
      venue: json['venueInfo']['ground'] ?? 'No Ground',
      city: json['venueInfo']['city'] ?? 'No City',
      status: json['status'] ?? 'No Status',
    );
  }
}

// Model for schedule ad wrapper
class ScheduleAdWrapper {
  final List<MatchSchedule> matchScheduleList;

  ScheduleAdWrapper({required this.matchScheduleList});

  factory ScheduleAdWrapper.fromJson(Map<String, dynamic> json) {
    return ScheduleAdWrapper(
      matchScheduleList: (json['matchScheduleList'] as List)
          .map((item) => MatchSchedule.fromJson(item))
          .toList(),
    );
  }
}

// Model for the schedule response
class MatchSchedulesResponse {
  final Map<String, dynamic> matchScheduleMap;

  MatchSchedulesResponse({required this.matchScheduleMap});

  factory MatchSchedulesResponse.fromJson(Map<String, dynamic> json) {
    return MatchSchedulesResponse(
      matchScheduleMap: json['matchScheduleMap'] ?? {},
    );
  }
}

// Model for statistics category
class StatsCategory {
  final String category;
  final List<StatsType> types;

  StatsCategory({required this.category, required this.types});

  factory StatsCategory.fromJson(Map<String, dynamic> json) {
    return StatsCategory(
      category: json['category'] ?? 'No Category',
      types: (json['types'] as List)
          .map((type) => StatsType.fromJson(type))
          .toList(),
    );
  }
}

// Model for statistics type
class StatsType {
  final String header;
  final String category;

  StatsType({required this.header, required this.category});

  factory StatsType.fromJson(Map<String, dynamic> json) {
    return StatsType(
      header: json['header'] ?? 'No Header',
      category: json['category'] ?? 'No Category',
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
//changes
class TeamStanding {
  final String rank;
  final String team;
  final String pct;

  TeamStanding({required this.rank, required this.team, required this.pct});

  factory TeamStanding.fromJson(List<dynamic> json) {
    return TeamStanding(
      rank: json[0] ?? 'No Rank',
      team: json[2] ?? 'No Team',
      pct: json[3] ?? 'No PCT',
    );
  }
}