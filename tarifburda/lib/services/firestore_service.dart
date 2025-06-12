import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'recipes';
  final String _favoritesCollection = 'favorites';

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
    try {
      // Önce tarifin var olup olmadığını kontrol et
      final recipeDoc = await _firestore.collection(_collection).doc(recipeId).get();
      if (!recipeDoc.exists) {
        throw Exception('Tarif bulunamadı');
      }

      // Favori zaten ekli mi kontrol et
      final favoriteDoc = await _firestore
          .collection(_favoritesCollection)
          .doc('$userId$recipeId')
          .get();

      if (favoriteDoc.exists) {
        throw Exception('Bu tarif zaten favorilerinizde');
      }

      // Favori ekle
      await _firestore.collection(_favoritesCollection).doc('$userId$recipeId').set({
        'userId': userId,
        'recipeId': recipeId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Favori eklenirken bir hata oluştu: $e');
    }
  }

  // Favori sil
  Future<void> removeFavorite(String userId, String recipeId) async {
    try {
      final favoriteDoc = await _firestore
          .collection(_favoritesCollection)
          .doc('$userId$recipeId')
          .get();

      if (!favoriteDoc.exists) {
        throw Exception('Bu tarif favorilerinizde bulunmuyor');
      }

      await _firestore.collection(_favoritesCollection).doc('$userId$recipeId').delete();
    } catch (e) {
      throw Exception('Favori silinirken bir hata oluştu: $e');
    }
  }

  // Tarifin favori olup olmadığını kontrol et
  Future<bool> isRecipeFavorite(String userId, String recipeId) async {
    try {
      final favoriteDoc = await _firestore
          .collection(_favoritesCollection)
          .doc('$userId$recipeId')
          .get();
      return favoriteDoc.exists;
    } catch (e) {
      throw Exception('Favori durumu kontrol edilirken bir hata oluştu: $e');
    }
  }

  // Kullanıcının favori tariflerini getir
  Stream<List<Recipe>> getUserFavorites(String userId) {
    return _firestore
        .collection(_favoritesCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
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

  // Kullanıcının favori tarif ID'lerini getir
  Stream<List<String>> getUserFavoriteIds(String userId) {
    return _firestore
        .collection(_favoritesCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc['recipeId'] as String).toList();
        });
  }

  // Kullanıcının favori sayısını getir
  Future<int> getUserFavoriteCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_favoritesCollection)
          .where('userId', isEqualTo: userId)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw Exception('Favori sayısı alınırken bir hata oluştu: $e');
    }
  }
} 