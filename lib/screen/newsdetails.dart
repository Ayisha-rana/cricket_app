import 'package:flutter/material.dart';
import 'package:cricket_app/screen/classmodel/model.dart';

class NewsDetailsPage extends StatelessWidget {
  final News newsItem;

  NewsDetailsPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 160, 115),
        title: const Text('News Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsItem.headline,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              newsItem.description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 15),
            // Add more details if available, like published date, content, etc.
            if (newsItem.content != null && newsItem.content!.isNotEmpty)
              Text(
                newsItem.content!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
