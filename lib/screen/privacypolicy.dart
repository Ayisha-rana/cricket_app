import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 128, 73),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Privacy Policy for Cricbuzz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Effective Date: [Insert Effective Date]',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '1. Introduction\n\n'
              'Welcome to Cricbuzz. We are committed to protecting your privacy and ensuring you have a positive experience with our application. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our app. Please read this policy carefully.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '2. Information We Collect\n\n'
              'We may collect the following types of information:\n\n'
              '• Personal Information: Name, email address, and other contact details.\n'
              '• Usage Data: Information about how you use the app, including features accessed and time spent on the app.\n'
              '• Device Information: Details about your device, such as model, operating system, and unique device identifiers.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '3. How We Use Your Information\n\n'
              'We use the collected information to:\n\n'
              '• Provide and maintain our services.\n'
              '• Improve and personalize your experience.\n'
              '• Communicate with you, including sending updates and promotional materials.\n'
              '• Analyze app usage and trends.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '4. Data Sharing and Disclosure\n\n'
              'We do not share your personal information with third parties, except in the following cases:\n\n'
              '• With your consent.\n'
              '• To comply with legal obligations or enforce our terms and conditions.\n'
              '• To protect the rights, property, or safety of Cricbuzz, our users, or others.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '5. Data Security\n\n'
              'We implement appropriate technical and organizational measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee its absolute security.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '6. Your Rights\n\n'
              'You have the right to:\n\n'
              '• Access and update your personal information.\n'
              '• Request deletion of your personal information.\n'
              '• Opt-out of receiving promotional communications.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '7. Changes to This Privacy Policy\n\n'
              'We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date. We encourage you to review this policy periodically.\n\n',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '8. Contact Us\n\n'
              'If you have any questions or concerns about this Privacy Policy, please contact us at support@cricbuzz.com.\n\n',
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
