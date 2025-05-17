import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class StarredRecipesScreen extends StatelessWidget {
  const StarredRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kullanıcının yıldızladığı tarifler (örnek)
    final List<Recipe> starredRecipes = [
      Recipe(
        id: '6',
        name: 'Köfte',
        description: 'Klasik Türk mutfağından ızgara köfte',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/01/kofte-yemekcom.jpg',
        ingredients: ['Kıyma', 'Soğan', 'Ekmek içi', 'Tuz', 'Karabiber', 'Kırmızı pul biber', 'Kimyon'],
        instructions: ['Tüm malzemeleri karıştırın', 'Köfte şekli verin', 'Izgara veya tavada pişirin'],
        preparationTime: '30 dakika',
        category: 'Ana Yemek',
        stars: 4,
        isFavorite: true,
      ),
      Recipe(
        id: '7',
        name: 'Katmer',
        description: 'Kahvaltıda veya tatlı olarak tüketilebilen lezzet',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/08/gaziantep-katmeri-tarifi.jpg',
        ingredients: ['Un', 'Su', 'Tuz', 'Tereyağı', 'Kaymak', 'Antep fıstığı', 'Şeker'],
        instructions: ['Hamuru hazırlayın', 'İnce açın', 'İçine tereyağı sürün', 'Katlayın', 'Tavada kızartın'],
        preparationTime: '40 dakika',
        category: 'Tatlı',
        stars: 5,
        isFavorite: true,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yıldızladığım Tarifler',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.star, color: Colors.amber, size: 28),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${starredRecipes.length} tarif kaydettin',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          if (starredRecipes.isEmpty)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Henüz yıldızladığın tarif yok',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Beğendiğin tarifleri yıldızlayarak burada saklayabilirsin',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: starredRecipes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RecipeCard(recipe: starredRecipes[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
} 