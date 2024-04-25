class Recipe {
  String label;
  String image;
  String source;
  String url;

  Recipe(
      {required this.label,
      required this.image,
      required this.source,
      required this.url});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      label: json['label'],
      image: json['image'],
      source: json['source'],
      url: json['url'],
    );
  }
}
