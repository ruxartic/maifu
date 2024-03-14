import 'package:flutter/material.dart';
import 'package:image_app/models/item.dart'; // Import the Item model
import 'package:image_app/utils/api_service.dart'; // Import the ApiService
import 'package:image_app/views/home_view.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    List<Item> items = await ApiService.fetchPopularItems();
    setState(() {
      _items = items;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: SearchBar(
          hintText: 'Search...',
          leading: const Icon(Icons.search),
          onChanged: (value) {
            // Implement search functionality here 
          },
        ),
      ),
      elevation: 0, // Remove app bar elevation
    ),
    body: _buildBody(),
  );
}


  Widget _buildBody() {
    if (_items.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeView(item: _items[index]);
        },
      );
    }
  }
}
