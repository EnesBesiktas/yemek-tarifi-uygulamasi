class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final String preparationTime;
  final String category;
  final int stars;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.preparationTime,
    required this.category,
    this.stars = 0,
    this.isFavorite = false,
  });

  // Firestore'dan veri okuma için factory constructor
  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      instructions: List<String>.from(data['instructions'] ?? []),
      preparationTime: data['preparationTime'] ?? '',
      category: data['category'] ?? '',
      stars: data['stars'] ?? 0,
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  // Firestore'a veri yazma için Map'e dönüştürme
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
      'preparationTime': preparationTime,
      'category': category,
      'stars': stars,
      'isFavorite': isFavorite,
    };
  }
} 
 