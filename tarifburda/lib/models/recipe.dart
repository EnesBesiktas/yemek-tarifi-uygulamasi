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
} 