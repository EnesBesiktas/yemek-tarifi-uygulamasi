import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/category.dart';
import '../widgets/recipe_card.dart';
import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipePage extends StatelessWidget {
  final Category category;
  final SubCategory? subCategory;
  final FirestoreService _firestoreService = FirestoreService();

  RecipePage({
    super.key,
    required this.category,
    this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text('Giriş yapmalısınız.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(subCategory?.name ?? category.name),
        backgroundColor: const Color(0xFF2A6CB0),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori açıklaması
            Text(
              subCategory?.description ?? category.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            // Tarifler listesi
            Expanded(
              child: StreamBuilder<List<Recipe>>(
                stream: _firestoreService.getRecipesByCategory(subCategory?.name ?? category.name),
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
                      child: Text('Bu kategoride henüz tarif bulunmuyor.'),
                    );
                  }

                  return StreamBuilder<List<String>>(
                    stream: _firestoreService.getUserFavoriteIds(userId),
                    builder: (context, favoriteSnapshot) {
                      final favoriteIds = favoriteSnapshot.data ?? [];
                      
                      return ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: RecipeCard(
                              recipe: recipes[index],
                              userFavoriteIds: favoriteIds,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 