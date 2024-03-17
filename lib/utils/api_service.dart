import 'package:http/http.dart' as http;
import '../models/neko.dart'; // Import the Item model
import '../models/tag.dart'; // Import the Tag model
import 'dart:convert'; // Import the JSON decoding library

class ApiService {
  static const String _baseUrl = 'https://api.nekosapi.com/v3';

  // Fetch popular items
  static Future<List<NekosapiItem>> fetchPopularItems() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/images?rating=safe'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['items'];
        final List<NekosapiItem> items =
            jsonData.map((json) => NekosapiItem.fromJson(json)).toList();

        return items;
      } else {
        throw Exception('Failed to fetch popular items');
      }
    } catch (e) {
      throw Exception('Failed to fetch popular items: $e');
    }
  }

  // Search tags based on query
  static Future<List<Tag>> searchTags(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/images/tags?search=$query'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['items'];
        final List<Tag> tags =
            jsonData.map((json) => Tag.fromJson(json)).toList();

        return tags;
      } else {
        throw Exception('Failed to fetch tags');
      }
    } catch (e) {
      throw Exception('Failed to fetch tags: $e');
    }
  }

// Fetch images by tag
static Future<List<NekosapiItem>> fetchImagesByTag(int tagId) async {
  try {
    final response = await http.get(Uri.parse('$_baseUrl/images/tags/$tagId/image'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['items'];
      final List<NekosapiItem> items =
          jsonData.map((json) => NekosapiItem.fromJson(json)).toList();

      return items;
    } else {
      throw Exception('Failed to fetch images by tag');
    }
  } catch (e) {
    throw Exception('Failed to fetch images by tag: $e');
  }
}
}
