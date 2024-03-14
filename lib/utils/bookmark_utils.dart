import 'package:shared_preferences/shared_preferences.dart';

class BookmarkUtils {
  static const String _bookmarkKey = 'bookmarks';

  static Future<List<Map<String, dynamic>>> getBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? bookmarkStrings = prefs.getStringList(_bookmarkKey);
    final List<Map<String, dynamic>> bookmarks = [];
    if (bookmarkStrings != null) {
      for (final String bookmarkString in bookmarkStrings) {
        final List<String> parts = bookmarkString.split(';');
        final Map<String, dynamic> bookmark = {
          'id': parts[0],
          'name': parts[1],
          'imageUrl': parts[2],
        };
        bookmarks.add(bookmark);
      }
    }
    return bookmarks;
  }

  static Future<void> addBookmark(Map<String, dynamic> bookmark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookmarkStrings =
        (prefs.getStringList(_bookmarkKey) ?? []).toList();
    final String newBookmarkString =
        '${bookmark['id']};${bookmark['name']};${bookmark['imageUrl']}';
    if (!bookmarkStrings.contains(newBookmarkString)) {
      bookmarkStrings.add(newBookmarkString);
      await prefs.setStringList(_bookmarkKey, bookmarkStrings);
    }
  }

  static Future<void> removeBookmark(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookmarkStrings =
        (prefs.getStringList(_bookmarkKey) ?? []).toList();
    bookmarkStrings.removeWhere((bookmark) => bookmark.startsWith('$id;'));
    await prefs.setStringList(_bookmarkKey, bookmarkStrings);
  }
}
