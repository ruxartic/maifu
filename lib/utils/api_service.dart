import 'package:http/http.dart' as http;
import '../models/neko.dart'; // Import the Item model
import 'dart:convert'; // Import the JSON decoding library

class ApiService {
  static const String _baseUrl = 'https://api.nekosapi.com/v3/images';

  static Future<List<NekosapiItem>> fetchPopularItems() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['items'];
        final List<NekosapiItem> items =
            jsonData.map((json) => NekosapiItem.fromJson(json)).toList();

        return items;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
