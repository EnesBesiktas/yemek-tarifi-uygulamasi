import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'recipes';

  // Tüm tarifleri getir
  Stream<List<Recipe>> getRecipes() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Recipe.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Kategoriye göre tarifleri getir
  Stream<List<Recipe>> getRecipesByCategory(String category) {
    return _firestore
        .collection(_collection)
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Recipe.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Tarif ekle
  Future<void> addRecipe(Recipe recipe) {
    return _firestore.collection(_collection).add(recipe.toFirestore());
  }

  // Tarif güncelle
  Future<void> updateRecipe(String id, Recipe recipe) {
    return _firestore.collection(_collection).doc(id).update(recipe.toFirestore());
  }

  // Tarif sil
  Future<void> deleteRecipe(String id) {
    return _firestore.collection(_collection).doc(id).delete();
  }

  // Favori tarifleri getir
  Stream<List<Recipe>> getFavoriteRecipes() {
    return _firestore
        .collection(_collection)
        .where('isFavorite', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Recipe.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Yıldızlı tarifleri getir
  Stream<List<Recipe>> getStarredRecipes() {
    return _firestore
        .collection(_collection)
        .where('stars', isGreaterThan: 0)
        .orderBy('stars', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Recipe.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Favori ekle
  Future<void> addFavorite(String userId, String recipeId) async {
    await _firestore.collection('favorites').doc('$userId$recipeId').set({
      'userId': userId,
      'recipeId': recipeId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Favori sil
  Future<void> removeFavorite(String userId, String recipeId) async {
    await _firestore.collection('favorites').doc('$userId$recipeId').delete();
  }

  // Kullanıcının favori tariflerini getir
  Stream<List<Recipe>> getUserFavorites(String userId) {
    return _firestore
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) async {
          final recipeIds = snapshot.docs.map((doc) => doc['recipeId'] as String).toList();
          if (recipeIds.isEmpty) return <Recipe>[];
          final recipesSnapshot = await _firestore
              .collection(_collection)
              .where(FieldPath.documentId, whereIn: recipeIds)
              .get();
          return recipesSnapshot.docs.map((doc) => Recipe.fromFirestore(doc.data(), doc.id)).toList();
        });
  }
} 