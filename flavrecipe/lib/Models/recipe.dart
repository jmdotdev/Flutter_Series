import 'dart:ffi';

class Recipe {
  String label;
  String image;
  String source;
  String url;
  double totalTime;
  double yield;
  List<String> ingredientLines;

  Recipe(
      {required this.label,
      required this.image,
      required this.source,
      required this.url,
      required this.totalTime,
      required this.yield,
      required this.ingredientLines});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        label: json['label'],
        image: json['image'],
        source: json['source'],
        url: json['url'],
        totalTime: json['totalTime'],
        yield: json['yield'],
        ingredientLines: List<String>.from(json['ingredientLines']));
  }
}
