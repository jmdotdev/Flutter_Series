class Recipe {
  String? label;
  String? image;
  String? source;
  String? url;

  Recipe({this.label, this.image, this.source, this.url});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'label': String label,
        'image': String image,
        'source': String source,
        'url': String url
      } =>
        Recipe(
          label: label,
          image: image,
          source: source,
          url: url,
        ),
      _ => throw const FormatException('Failed to load recipes')
    };
  }
}
