class Tag {
  final int id;
  final String name;
  final String description;
  final String sub;
  final bool isNsfw;

  Tag({
    required this.id,
    required this.name,
    required this.description,
    required this.sub,
    required this.isNsfw,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sub: json['sub'],
      isNsfw: json['is_nsfw'],
    );
  }
}
