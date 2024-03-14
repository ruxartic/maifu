import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharingUtils {
  static Future<bool> shareImage(String imagePath, BuildContext context) async {
    try {
      await Share.share(imagePath);
      return true;
    } catch (e) {
      return false;
    }
  }
}
