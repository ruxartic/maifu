import 'package:flutter/material.dart';
import 'package:image_app/utils/bookmark_utils.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late List<Map<String, dynamic>> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final List<Map<String, dynamic>> loadedBookmarks =
        await BookmarkUtils.getBookmarks();
    setState(() {
      bookmarks = loadedBookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: bookmarks.isEmpty
          ? const Center(child: Text("No Bookmarked images."))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 4.0, // Spacing between rows
                crossAxisSpacing: 4.0, // Spacing between columns
              ),
              itemCount: bookmarks.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> bookmark = bookmarks[index];
                return GridTile(
                  child: Image.network(
                    bookmark['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}
