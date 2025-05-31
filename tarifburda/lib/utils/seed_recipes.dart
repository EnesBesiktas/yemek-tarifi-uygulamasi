import '../models/recipe.dart';
import '../services/firestore_service.dart';

class SeedRecipes {
  static final FirestoreService _firestoreService = FirestoreService();

  static Future<void> seedRecipes() async {
    final List<Recipe> recipes = [
      Recipe(
        id: 'it1',
        name: 'Spagetti Bolonez',
        description: 'Klasik İtalyan mutfağından nefis bir makarna tarifi',
        imageUrl: 'assets/spagetti.jpg',
        ingredients: ['Spagetti', 'Kıyma', 'Domates', 'Soğan', 'Sarımsak', 'Zeytinyağı', 'Tuz', 'Karabiber'],
        instructions: ['Makarnayı haşlayın', 'Sosu hazırlayın', 'Birleştirin ve servis edin'],
        preparationTime: '30 dakika',
        category: 'İtalyan',
        stars: 5,
      ),
      Recipe(
        id: 'mx1',
        name: 'Taco',
        description: 'Meksika mutfağının vazgeçilmez lezzeti',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/04/taco-sevda.jpg',
        ingredients: ['Tortilla', 'Kıyma', 'Marul', 'Domates', 'Avokado', 'Limon', 'Acı sos'],
        instructions: ['Kıymayı pişirin', 'Malzemeleri hazırlayın', 'Tortillaya doldurun'],
        preparationTime: '25 dakika',
        category: 'Meksika',
        stars: 4,
      ),
      Recipe(
        id: 'hi1',
        name: 'Tavuklu Köri',
        description: 'Hint mutfağından baharatlı tavuk köri',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/02/hindistan-yemek-kulturu-sevda.jpg',
        ingredients: ['Tavuk', 'Köri', 'Soğan', 'Domates', 'Sarımsak', 'Zencefil', 'Yoğurt'],
        instructions: ['Tavukları marine edin', 'Baharatlarla pişirin', 'Servis edin'],
        preparationTime: '40 dakika',
        category: 'Hint',
         stars: 5,
       ),
      Recipe(
                id: 'cn1',
                name: 'Sebzeli Noodle',
                description: 'Çin mutfağından pratik noodle tarifi',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2016/05/cin-mutfagi-yeni-kapak.jpg',
                ingredients: ['Noodle', 'Havuç', 'Biber', 'Soya sosu', 'Susam yağı'],
                instructions: ['Sebzeleri soteleyin', 'Noodle ekleyin', 'Soya sosu ile karıştırın'],
                preparationTime: '20 dakika',
                category: 'Çin',
                stars: 4,
              ),

      Recipe(
                id: 'jp1',
                name: 'Sushi',
                description: 'Japon mutfağının en bilinen lezzeti',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/06/japon-mutfagi-sevda.jpg',
                ingredients: ['Sushi pirinci', 'Nori', 'Somon', 'Avokado', 'Salatalık', 'Pirinç sirkesi'],
                instructions: ['Pirinçleri haşlayın', 'Malzemeleri sarın', 'Dilmlere ayırıp servis edin'],
                preparationTime: '50 dakika',
                category: 'Japon',
                stars: 5,
              ),
      Recipe(
                id: 'od1',
                name: 'Humus',
                description: 'Orta Doğu mutfağından nefis bir meze',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/11/ortadogu-yemekleri-sevda.jpg',
                ingredients: ['Nohut', 'Tahin', 'Limon', 'Sarımsak', 'Zeytinyağı'],
                instructions: ['Nohutları haşlayın', 'Tüm malzemeleri blenderdan geçirin', 'Servis edin'],
                preparationTime: '15 dakika',
                category: 'Orta Doğu',
                stars: 4,
              ),
      Recipe(
                id: 'tr1',
                name: 'Mantı',
                description: 'Türk mutfağının geleneksel lezzeti',
                imageUrl: 'assets/manti.jpg',
                ingredients: ['Un', 'Kıyma', 'Soğan', 'Yoğurt', 'Sarımsak', 'Tereyağı', 'Pul biber'],
                instructions: ['Hamuru açın', 'İç harcı koyun', 'Kaynar suda haşlayın', 'Yoğurt ve sos ile servis edin'],
                preparationTime: '60 dakika',
                category: 'Türk Mutfağı',
                stars: 5,
              ),
      Recipe(
                id: 'fr1',
                name: 'Fırında Tavuk',
                description: 'Pratik ve lezzetli fırın tavuk tarifi',
                imageUrl: 'assets/firindatavuk,jpg.jpg',
                ingredients: ['Tavuk but', 'Zeytinyağı', 'Sarımsak', 'Kekik', 'Tuz', 'Karabiber'],
                instructions: ['Tavukları marine edin', 'Fırına verin', 'Pişince servis edin'],
                preparationTime: '45 dakika',
                category: 'Fırın Yemekleri',
                stars: 5,
              ),



      // Diğer tarifler buraya eklenecek
    ];

    for (var recipe in recipes) {
      await _firestoreService.addRecipe(recipe);
    }
  }
} 