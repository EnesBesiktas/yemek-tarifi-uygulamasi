import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // En çok yıldızlanan tarifler (örnek)
    final List<Recipe> popularRecipes = [
      Recipe(
        id: '3',
        name: 'Karnıyarık',
        description: 'Geleneksel Türk mutfağından klasik lezzet',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2014/06/karniyarik-yemekcom.jpg',
        ingredients: ['Patlıcan', 'Kıyma', 'Soğan', 'Domates', 'Biber', 'Zeytinyağı', 'Tuz', 'Karabiber'],
        instructions: ['Patlıcanları yıkayıp boyuna yarın', 'Kızartın', 'İç harcı hazırlayın', 'Patlıcanları doldurun', 'Fırınlayın'],
        preparationTime: '45 dakika',
        category: 'Ana Yemek',
        stars: 5,
      ),
      Recipe(
        id: '4',
        name: 'Profiterol',
        description: 'Çikolata soslu nefis tatlı',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/01/ev-yapimi-profiterol-yemekcom.jpg',
        ingredients: ['Un', 'Su', 'Tereyağı', 'Yumurta', 'Tuz', 'Şeker', 'Çikolata', 'Krema'],
        instructions: ['Hamuru hazırlayın', 'Küçük toplar yapın', 'Fırınlayın', 'Kremayı hazırlayıp doldurun', 'Çikolata sosunu dökün'],
        preparationTime: '60 dakika',
        category: 'Tatlı',
        stars: 5,
      ),
      Recipe(
        id: '5',
        name: 'Mercimek Çorbası',
        description: 'Türk mutfağının vazgeçilmez çorbası',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2014/06/mercimek-corbasi-yemekcom.jpg',
        ingredients: ['Kırmızı mercimek', 'Soğan', 'Havuç', 'Patates', 'Tuz', 'Karabiber', 'Tereyağı', 'Limon'],
        instructions: ['Sebzeleri doğrayın', 'Mercimek ile pişirin', 'Blenderdan geçirin', 'Tereyağı ve baharatlarla servis edin'],
        preparationTime: '40 dakika',
        category: 'Çorba',
        stars: 5,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popüler Tarifler',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kullanıcılarımızın en çok beğendiği tarifler',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: popularRecipes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RecipeCard(recipe: popularRecipes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 