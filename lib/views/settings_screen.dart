import 'package:flutter/material.dart';
import 'package:image_app/utils/settings_utils.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        children: [
          _buildHeader('Theme'),
          SizedBox(height: 10.0),
          _buildThemeSettings(),
          SizedBox(height: 20.0),
          _buildHeader('Rating'),
          SizedBox(height: 10.0),
          _buildRatingSettings(),
          SizedBox(height: 20.0),
          _buildHeader('About'),
          SizedBox(height: 10.0),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    );
  }

  Widget _buildThemeSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Light'),
            onTap: () {
              SettingsUtils.setTheme('light');
            },
          ),
          ListTile(
            title: Text('Dark'),
            onTap: () {
              SettingsUtils.setTheme('dark');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSettings() {
    return Card(
      child: Column(
        children: [
          _buildRatingOption('Safe', 'safe'),
          _buildRatingOption('Suggestive', 'suggestive'),
          _buildRatingOption('Borderline', 'borderline'),
          _buildRatingOption('Explicit', 'explicit'),
        ],
      ),
    );
  }

  Widget _buildRatingOption(String title, String key) {
    return ListTile(
      title: Text(title),
      trailing: FutureBuilder<bool>(
        future: SettingsUtils.getRatingOption(key),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Switch(
              value: snapshot.data ?? false,
              onChanged: (value) {
                SettingsUtils.setRatingOption(key, value);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildAboutSection() {
    return Card(
      child: Column(
        children: [
          _buildAboutItem('App Version', '1.0.1'), // Replace with actual app version
          _buildAboutItem('GitHub Repo URL', 'https://github.com/ruxartic/maifu'), // Replace with your GitHub repo URL
          _buildAboutItem('Developer URL', 'https://github.com/ruxartic'), // Replace with your GitHub developer URL
        ],
      ),
    );
  }

  Widget _buildAboutItem(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
