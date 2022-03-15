class RecipeCat {
  final String displayName;
  final String displayImage;

  RecipeCat({ required this.displayName, required this.displayImage });

  factory RecipeCat.fromJson(dynamic json){
    return RecipeCat(
      displayName: json['displayName'] as String,
      displayImage: json['categoryImage'] as String
    );
  }

  static List<RecipeCat> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return RecipeCat.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'RecipeCat {name: $displayName, image: $displayImage}';
  }
}