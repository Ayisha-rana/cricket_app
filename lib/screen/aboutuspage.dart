import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 128, 73),
        title: Text(
          'About Us',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to Cricbuzz!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Cricbuzz is your one-stop destination for all things cricket. Whether you are a die-hard cricket fan or just looking to stay updated with the latest scores and news, Cricbuzz has got you covered. We provide live scores, news, match schedules, player stats, and much more, all in real-time.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '• Live match scores and commentary\n'
              '• Detailed player statistics\n'
              '• Match schedules and fixtures\n'
              '• Latest cricket news and updates\n'
              '• Rankings and records\n'
              '• Photo galleries and highlights\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our team is dedicated to bringing you the most accurate and up-to-date information on cricket. Thank you for using Cricbuzz. We hope you enjoy the app and stay connected with the world of cricket!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or feedback, please feel free to reach out to us at support@cricbuzz.com.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
