import 'package:flutter/material.dart';
import 'package:image_app/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatelessWidget {
  final Item item;

  const HomeView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cached Image
        CachedNetworkImage(
          imageUrl: item.previewUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 100,
            color: Colors.red,
          ),
          fadeInDuration: const Duration(milliseconds: 500), // Fade-in animation duration
          imageBuilder: (context, imageProvider) => Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Text Overlay
        Positioned(
          left: 0.0,
          bottom: 0.0,
          child: Container(
            padding: EdgeInsets.all(5.0),
            color: Colors.black.withOpacity(0.3), // Semi-transparent black background
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
