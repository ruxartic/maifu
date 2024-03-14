import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadUtils {
  static Future<bool> downloadImage(String imageUrl, String fileName) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final directory = await getDownloadsDirectory();
      final int extensionIndex = imageUrl.lastIndexOf('.');
      final String extension = imageUrl.substring(extensionIndex + 1);
      final File file = File('${directory!.path}/$fileName.$extension');
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      print('Error downloading image: $e');
      return false;
    }
  }
}
