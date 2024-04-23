class Recipe {
  String label;
  String image;

  Recipe({required this.label, required this.image});

 factory Recipe.fromJson(Map<String,dynamic> json){
  return switch(json){
    {
      'label': String label,
      'image': String image
    } => Recipe(
      label: label,
      image:image
    ),
    _ => throw const FormatException('Not able to load data')
  };
 }
}
