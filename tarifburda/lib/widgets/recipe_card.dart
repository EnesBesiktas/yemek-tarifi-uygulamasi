import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../screens/recipe_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final List<String> userFavoriteIds; // Kullanıcının favori recipeId listesi

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.userFavoriteIds,
  }) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  final FirestoreService _firestoreService = FirestoreService();
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.userFavoriteIds.contains(widget.recipe.id);
  }

  void _toggleFavorite() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await _firestoreService.addFavorite(userId, widget.recipe.id);
    } else {
      await _firestoreService.removeFavorite(userId, widget.recipe.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 2, right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Tarif detay sayfasına gidecek
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${widget.recipe.name} tarifi seçildi')),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resim
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'recipe_${widget.recipe.id}',
                        child: Image.network(
                          widget.recipe.imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 60, color: Colors.white),
                            );
                          },
                        ),
                      ),
                      // Kategori etiketi
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getCategoryIcon(widget.recipe.category),
                                color: _getCategoryColor(widget.recipe.category),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.recipe.category,
                                style: TextStyle(
                                  color: _getCategoryColor(widget.recipe.category),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Yıldız ikonu ve sayısı
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                widget.recipe.stars.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Hazırlama süresi
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Color(0xFF2A6CB0),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.recipe.preparationTime,
                                style: const TextStyle(
                                  color: Color(0xFF2A6CB0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bilgiler
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tarif adı
                      Text(
                        widget.recipe.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A6CB0),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Tarif açıklaması
                      Text(
                        widget.recipe.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      // Malzemeler
                      Row(
                        children: [
                          const Text(
                            'Malzemeler: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.recipe.ingredients.take(3).join(', ') + (widget.recipe.ingredients.length > 3 ? ' ...' : ''),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Butonlar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tarifi Gör butonu
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(recipe: widget.recipe),
                                ),
                              );
                            },
                            icon: const Icon(Icons.visibility, size: 18),
                            label: const Text('Tarifi Gör'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A6CB0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          // Favori butonu
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 28,
                            ),
                            onPressed: _toggleFavorite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'çorba':
      case 'çorbalar':
        return Icons.soup_kitchen;
      case 'ana yemek':
        return Icons.dinner_dining;
      case 'et yemekleri':
      case 'et yemeği':
        return Icons.restaurant;
      case 'tatlı':
      case 'tatlılar':
        return Icons.cake;
      case 'kahvaltı':
        return Icons.breakfast_dining;
      case 'salata':
        return Icons.eco;
      default:
        return Icons.fastfood;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'çorba':
      case 'çorbalar':
        return Colors.orange;
      case 'ana yemek':
        return const Color(0xFF2A6CB0);
      case 'et yemekleri':
      case 'et yemeği':
        return Colors.redAccent;
      case 'tatlı':
      case 'tatlılar':
        return Colors.pinkAccent;
      case 'kahvaltı':
        return Colors.amber;
      case 'salata':
        return Colors.green;
      default:
        return Colors.deepPurple;
    }
  }
} 