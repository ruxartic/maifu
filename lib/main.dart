import 'package:flutter/material.dart';
import 'package:image_app/views/bottom_navigation_bar.dart';
import 'package:image_app/views/bookmark_screen.dart'; // Import the BookmarkScreen widget
import 'package:image_app/views/home_screen.dart'; // Import the HomeScreen widget
import 'package:image_app/views/settings_screen.dart';
import 'package:image_app/utils/settings_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = SettingsUtils.getTheme();
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: _theme == "dark" ? Brightness.dark : Brightness.light,
      seedColor: Colors.indigo,
    );

    return MaterialApp(
      title: 'maifu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: MainScreen(), // MainScreen will contain the bottom navigation bar
      routes: {
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _buildBody(), // Display the appropriate screen based on the current index
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    // Return the appropriate screen based on the current index
    switch (_currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return BookmarkScreen();
      default:
        return Container(); // Return an empty container if index is out of bounds
    }
  }
}
