import 'package:http/http.dart' as http;
import '../models/neko.dart'; // Import the Item model
import '../models/tag.dart'; // Import the Tag model
import 'dart:convert'; // Import the JSON decoding library
import 'package:image_app/utils/settings_utils.dart';

class ApiService {
  static const String _baseUrl = 'https://api.nekosapi.com/v3';

   static Future<String> _buildPopularItemsUrl() async {
    // Get rating options from settings
    final ratingOptions = await SettingsUtils.getRatingOptions();

    // Filter rating options that are true and map them to 'rating=option' format
    final List<String> parameters = ratingOptions.entries
        .where((entry) => entry.value)
        .map((entry) => 'rating=${entry.key}')
        .toList();

    // Join parameters with '&' and append to base URL
    final String url = '$_baseUrl/images?' + parameters.join('&');

    return url;
  }

  static Future<List<NekosapiItem>> fetchPopularItems() async {
    try {
      final String url = await _buildPopularItemsUrl();
      final response = await http.get(Uri.parse(url));

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
    final response = await http.get(Uri.parse('$_baseUrl/images/tags/$tagId/images'));

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
