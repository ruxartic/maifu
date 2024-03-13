import 'package:http/http.dart' as http;
import '../models/item.dart'; // Import the Item model
import 'dart:convert'; // Import the JSON decoding library

class ApiService {
  static const String _baseUrl =
      'https://gist.githubusercontent.com/bethropolis/5d5b67dc9be76a65b573bcbc26a29912/raw/6b94e032ab76f2c695be00b9043031ffde6581df/test.json';

  static Future<List<Item>> fetchPopularItems() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        // Decode the JSON response into a list of Item objects
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Item> items = jsonData
            .map((json) => Item(
                  id: json['id'],
                  name: json['name'],
                  previewUrl: json['previewUrl'],
                ))
            .toList();

        // Return the list of items
        return items;
      } else {
        // If the request fails, throw an error
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      // Catch any errors and throw an error message
      throw Exception('Failed to fetch data: $e');
    }
  }
}
 