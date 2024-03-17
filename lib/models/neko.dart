class NekosapiItem {
  final int id;
  final String imageUrl;
  final String previewUrl;
  final String name;
  final String rating;

  NekosapiItem({
    required this.id,
    required this.imageUrl,
    required this.previewUrl,
    required this.name,
    required this.rating,
  });

  factory NekosapiItem.fromJson(Map<String, dynamic> json) {
    final characterName = json['characters'].isNotEmpty
        ? json['characters'][0]['name']
        : 'Unknown Character';

    return NekosapiItem(
      id: json['id'],
      imageUrl: json['image_url'],
      previewUrl: json['sample_url'],
      name: characterName,
      rating: json['rating'],
    );
  }
}
