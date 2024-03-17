import 'package:flutter/material.dart';
import 'package:image_app/models/neko.dart'; // Import the Item model
import 'package:image_app/models/tag.dart'; // Import the Tag model
import 'package:image_app/utils/api_service.dart'; // Import the ApiService
import 'package:image_app/views/home_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NekosapiItem> _items = [];
  List<Tag> _tags = [];
  bool _showItems = true; // Variable to control whether to show items or tags

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    List<NekosapiItem> items = await ApiService.fetchPopularItems();
    setState(() {
      _items = items;
    });
  }

  Future<void> _searchTags(String query) async {
    List<Tag> tags = await ApiService.searchTags(query);
    setState(() {
      _tags = tags;
      _showItems = false; // Switch to showing tags
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
              // Trigger search functionality
              _searchTags(value);
            },
          ),
        ),
        elevation: 0, // Remove app bar elevation
      ),
      body: _showItems ? _buildItemsBody() : _buildTagsBody(),
    );
  }

  Widget _buildItemsBody() {
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

  Widget _buildTagsBody() {
  if (_tags.isEmpty) {
    return Center(child: Text('No tags found'));
  } else {
    return ListView.builder(
      itemCount: _tags.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_tags[index].name),
          subtitle: Text(_tags[index].description),
          onTap: () async {
            // Handle tag selection
            int tagId = _tags[index].id;
            List<NekosapiItem> items = await ApiService.fetchImagesByTag(tagId);
            setState(() {
              _items = items;
              _showItems = true; // Switch back to showing items
            });
          },
        );
      },
    );
  }
}

}
