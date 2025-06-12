import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StarredRecipesScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  StarredRecipesScreen({super.key});

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
        title: const Text('Yıldızlı Tarifler'),
        backgroundColor: const Color(0xFF2A6CB0),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Recipe>>(
        stream: _firestoreService.getStarredRecipes(),
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
              child: Text('Henüz yıldızlı tarifiniz bulunmuyor.'),
            );
          }

          return StreamBuilder<List<String>>(
            stream: _firestoreService.getUserFavoriteIds(userId),
            builder: (context, favoriteSnapshot) {
              final favoriteIds = favoriteSnapshot.data ?? [];
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
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
    );
  }
} 