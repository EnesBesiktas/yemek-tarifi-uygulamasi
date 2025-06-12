import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/firestore_service.dart';
import '../widgets/favorite_button.dart';

class FavoritesScreen extends StatelessWidget {
  final String userId;
  final FirestoreService _firestoreService = FirestoreService();

  FavoritesScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorilerim'),
      ),
      body: StreamBuilder<List<Recipe>>(
        stream: _firestoreService.getUserFavorites(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Bir hata oluştu: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final recipes = snapshot.data ?? [];

          if (recipes.isEmpty) {
            return const Center(
              child: Text(
                'Henüz favori tarifiniz bulunmuyor.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      recipe.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        recipe.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.timer, size: 16),
                          const SizedBox(width: 4),
                          Text(recipe.preparationTime),
                          const SizedBox(width: 16),
                          const Icon(Icons.category, size: 16),
                          const SizedBox(width: 4),
                          Text(recipe.category),
                        ],
                      ),
                    ],
                  ),
                  trailing: FavoriteButton(
                    userId: userId,
                    recipeId: recipe.id,
                    size: 28,
                  ),
                  onTap: () {
                    // TODO: Navigate to recipe detail screen
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
} 