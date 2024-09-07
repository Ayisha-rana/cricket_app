import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 148, 221, 151), // Cricbuzz color
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to profile page
            },
          ),
          Divider(),

          // Notifications Section
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Manage notifications'),
            onTap: () {
              // Navigate to notifications settings
            },
          ),
          Divider(),

          // Theme Section
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Theme'),
            subtitle: Text('Change app theme'),
            onTap: () {
              // Navigate to theme settings
            },
          ),
          Divider(),

          // Language Section
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('Change app language'),
            onTap: () {
              // Navigate to language settings
            },
          ),
          Divider(),

          // Privacy Section
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy'),
            subtitle: Text('Manage privacy settings'),
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          Divider(),

          // About Section
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('App information and version'),
            onTap: () {
              // Navigate to about page
            },
          ),
          Divider(),

          // Logout Button
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle logout action
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}
