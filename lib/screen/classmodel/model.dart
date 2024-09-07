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