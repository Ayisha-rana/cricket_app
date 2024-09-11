import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: const Color.fromARGB(255, 148, 221, 151), // Cricbuzz color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We value your feedback!',
            ),
            SizedBox(height: 16.0),
            Text(
              'Please let us know how we can improve our app. Your feedback is important to us.',
            ),
            SizedBox(height: 24.0),
            // Placeholder for the feedback form or any additional content
            Expanded(
              child: Center(
                child: Text(
                  'Feedback Form Placeholder',
                ),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Handle submit action
              },
              child: Text('Submit Feedback'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
