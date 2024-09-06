import 'package:flutter/material.dart';
import 'package:cricket_app/screen/schedulepage.dart';

class MorePage extends StatelessWidget {
  MorePage({super.key});

  final List<IconData> _icons = [
    Icons.emoji_events,
    Icons.group,
    Icons.sports_cricket,
    Icons.calendar_today,
    Icons.bar_chart,
    Icons.photo,
    Icons.star,
    Icons.settings,
    Icons.feedback,
    Icons.privacy_tip,
    Icons.info,
  ];

  final List<String> _texts = [
    'Browse Series',
    'Browse Team',
    'Browse Player',
    'Schedule',
    'ICC Ranking',
    'Photos',
    'Records',
    'Settings',
    'Feedback',
    'Privacy Policy',
    'About Us',
  ];

  final List<Widget> _pages = [
    // BrowseSeriesPage(), // Define and uncomment these when available
    // BrowseTeamPage(),
    // BrowsePlayerPage(),
    MatchSchedulesScreen(), // This corresponds to 'Schedule'
    // ICCRankingPage(),
    // PhotosPage(),
    // RecordsPage(),
    // SettingsPage(),
    // FeedbackPage(),
    // PrivacyPolicyPage(),
    // AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 147, 88),
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: Colors.white,
            child: SizedBox(
              height: 60,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                leading: Icon(
                  _icons[index],
                  color: Colors.black,
                  size: 24,
                ),
                title: Text(
                  _texts[index],
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  // Ensure the index is within the range of the _pages list
                  if (index < _pages.length) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _pages[index],
                      ),
                    );
                  } else {
                    // Handle the case where there's no corresponding page
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Page not available')),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
