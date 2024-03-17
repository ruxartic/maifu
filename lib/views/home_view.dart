import 'package:flutter/material.dart';
import 'package:image_app/models/neko.dart';
import 'package:image_app/utils/bookmark_utils.dart';
import 'package:image_app/utils/download_utils.dart';
import 'package:image_app/utils/share_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatelessWidget {
  final NekosapiItem item;

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
          fadeInDuration:
              const Duration(milliseconds: 500), // Fade-in animation duration
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
            color: Colors.black
                .withOpacity(0.3), // Semi-transparent black background
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
        // Dropdown button
        Positioned(
          top: 0,
          right: 0,
          child: PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text('Bookmark'),
                  onTap: () async {
                    // Handle bookmark option
                    await BookmarkUtils.addBookmark({
                      'id': item.id,
                      'name': item.name,
                      'imageUrl': item.previewUrl,
                    });
                    // Show snackbar with an action to undo bookmarking
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Item bookmarked'),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () async {
                            // Handle undoing bookmarking
                            await BookmarkUtils.removeBookmark(item.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bookmark undone'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Download'),
                  onTap: () async {
                    // Handle download option
                    final success = await DownloadUtils.downloadImage(
                        item.previewUrl, item.name);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image downloaded'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to download image'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                  onTap: () async {
                    // Handle share option
                    final success =
                        await SharingUtils.shareImage(item.previewUrl, context);
                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to share image'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
