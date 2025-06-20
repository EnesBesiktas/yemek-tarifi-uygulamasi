import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/recipe.dart';
import '../widgets/category_card.dart';
import '../widgets/recipe_card.dart';
import 'add_recipe_screen.dart';
import 'favorites_screen.dart';
import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainMenuScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    
    // Tüm kategoriler
    final List<Category> mainCategories = [
      Category(
        id: '1',
        name: 'Dünya Mutfağı',
        imageUrl: 'assets/images/categories/dunya-mutfagi.jpg',
        description: 'Farklı ülkelerin mutfaklarından lezzetler',
        icon: Icons.public,
        subCategories: [
          SubCategory(
            id: '1-1',
            name: 'İtalyan',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/10/italyan-makarna-sevda.jpg',
            description: 'İtalyan mutfağından lezzetli tarifler',
          ),
          SubCategory(
            id: '1-2',
            name: 'Meksika',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/04/taco-sevda.jpg',
            description: 'Meksika mutfağından baharatlı lezzetler',
          ),
          SubCategory(
            id: '1-3',
            name: 'Hint',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/02/hindistan-yemek-kulturu-sevda.jpg',
            description: 'Hint mutfağından baharatlı yemekler',
          ),
          SubCategory(
            id: '1-4',
            name: 'Çin',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2016/05/cin-mutfagi-yeni-kapak.jpg',
            description: 'Çin mutfağından farklı lezzetler',
          ),
          SubCategory(
            id: '1-5',
            name: 'Japon',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/06/japon-mutfagi-sevda.jpg',
            description: 'Japon mutfağından eşsiz lezzetler',
          ),
          SubCategory(
            id: '1-6',
            name: 'Orta Doğu',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/11/ortadogu-yemekleri-sevda.jpg',
            description: 'Orta Doğu mutfağından baharatlı tarifler',
          ),
          SubCategory(
            id: '1-7',
            name: 'Türk Mutfağı',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/06/geleneksel-turk-yemekleri-sevda.jpg',
            description: 'Türk mutfağından geleneksel tarifler',
          ),
        ]
      ),
      Category(
        id: '2',
        name: 'Pişirme Yöntemi',
        imageUrl: 'assets/images/categories/pisirme-yontemi.jpg',
        description: 'Farklı pişirme tekniklerine göre tarifler',
        icon: Icons.soup_kitchen,
        subCategories: [
          SubCategory(
            id: '2-1',
            name: 'Fırın Yemekleri',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2015/01/firinda-tavuk-but-yemekcom.jpg',
            description: 'Fırında yapılan pratik ve lezzetli yemekler',
          ),
          SubCategory(
            id: '2-2',
            name: 'Tencere Yemekleri',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/10/kis-yemekleri-sevda.jpg',
            description: 'Tencerede pişirilen lezzetli yemekler',
          ),
          SubCategory(
            id: '2-3',
            name: 'Izgara',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2015/06/izgara-kofte-yeni-one-cikan.jpg',
            description: 'Izgarada pişirilen et ve sebze tarifleri',
          ),
          SubCategory(
            id: '2-4',
            name: 'Buharda',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/03/buharda-pisirme-sevda.jpg',
            description: 'Buharda pişirilen sağlıklı tarifler',
          ),
          SubCategory(
            id: '2-5',
            name: 'Kızartmalar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/01/patates-kizartmasi-yemekcom.jpg',
            description: 'Kızartma tekniğiyle hazırlanan tarifler',
          ),
          SubCategory(
            id: '2-6',
            name: 'Çiğ Tarifler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/05/raw-food-sevda.jpg',
            description: 'Pişirilmeden hazırlanan sağlıklı tarifler',
          ),
        ]
      ),
      Category(
        id: '3',
        name: 'Öğüne Göre',
        imageUrl: 'assets/images/categories/ogune-gore.jpg',
        description: 'Günün her öğünü için lezzetli tarifler',
        icon: Icons.restaurant_menu,
        subCategories: [
          SubCategory(
            id: '3-1',
            name: 'Kahvaltılıklar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2015/04/kahvalti-tabagi-yeni.jpg',
            description: 'Güne enerji dolu başlamak için kahvaltılık tarifler',
          ),
          SubCategory(
            id: '3-2',
            name: 'Öğle Yemekleri',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/06/pratik-ogle-yemekleri-sevda.jpg',
            description: 'Ofiste veya evde pratik öğle yemeği tarifleri',
          ),
          SubCategory(
            id: '3-3',
            name: 'Akşam Yemekleri',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/01/tek-kisilik-aksamyemegi-sevda.jpg',
            description: 'Akşam için doyurucu ve lezzetli yemek tarifleri',
          ),
          SubCategory(
            id: '3-4',
            name: 'Ara Öğünler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/12/saglikli-atiştirmaliklar-sevda.jpg',
            description: 'Ara öğünler için sağlıklı atıştırmalıklar',
          ),
          SubCategory(
            id: '3-5',
            name: 'Atıştırmalıklar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/04/ev-cipsi-yemekcom.jpg',
            description: 'Film akşamları için pratik atıştırmalıklar',
          ),
        ]
      ),
      Category(
        id: '4',
        name: 'Özel Diyetler',
        imageUrl: 'assets/images/categories/ozel-diyetler.jpg',
        description: 'Farklı beslenme düzenlerine uygun tarifler',
        icon: Icons.favorite_border,
        subCategories: [
          SubCategory(
            id: '4-1',
            name: 'Düşük Karbonhidrat',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/05/dusuk-karbonhidratli-yiyecekler-sevda-3.jpg',
            description: 'Düşük karbonhidrat içeren sağlıklı tarifler',
          ),
          SubCategory(
            id: '4-2',
            name: 'Keto',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/01/ketojenik-diyet-yemekcom.jpg',
            description: 'Ketojenik beslenmeye uygun yağ oranı yüksek tarifler',
          ),
          SubCategory(
            id: '4-3',
            name: 'Glutensiz',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2017/05/gluten-free-1.jpg',
            description: 'Gluten içermeyen hamur işleri ve yemekler',
          ),
          SubCategory(
            id: '4-4',
            name: 'Şekersiz',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/09/sekersiz-tatlilar-sevda.jpg',
            description: 'Şeker ilavesiz sağlıklı tatlılar',
          ),
          SubCategory(
            id: '4-5',
            name: 'Paleo',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2016/05/paleo-beslenme-yemekcom.jpg',
            description: 'Paleo beslenme düzenine uygun doğal tarifler',
          ),
        ]
      ),
      Category(
        id: '5',
        name: 'Zaman ve Zorluk',
        imageUrl: 'assets/images/categories/zaman-ve-zorluk.jpg',
        description: 'Zaman ve beceri seviyesine göre tarifler',
        icon: Icons.access_time,
        subCategories: [
          SubCategory(
            id: '5-1',
            name: '15 Dakikada Tarifler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/09/15-dakika-tarifler-sevda.jpg',
            description: 'Sadece 15 dakikada hazırlayabileceğiniz pratik tarifler',
          ),
          SubCategory(
            id: '5-2',
            name: 'Kolay Tarifler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/04/en-kolay-tarifler-sevda.jpg',
            description: 'Mutfakta yeni olanlar için basit ve kolay tarifler',
          ),
          SubCategory(
            id: '5-3',
            name: 'Tek Tencere Yemekler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/06/tek-tencere-yemekleri-sevda.jpg',
            description: 'Tek tencerede pişirilen pratik yemekler',
          ),
          SubCategory(
            id: '5-4',
            name: 'Öğrenci Yemekleri',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/07/ogrenci-evi-yemekleri-sevda.jpg',
            description: 'Öğrenciler için ekonomik ve hızlı tarifler',
          ),
        ]
      ),
      Category(
        id: '6',
        name: 'Tatlılar ve Hamur İşleri',
        imageUrl: 'assets/images/categories/tatlilar-ve-hamur-isleri.jpg',
        description: 'Tatlı krizleri için nefis tarifler',
        icon: Icons.cake,
        subCategories: [
          SubCategory(
            id: '6-1',
            name: 'Sütlü Tatlılar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/06/sutlu-tatli-yemekcom.jpg',
            description: 'Sütlü nefis tatlı tarifleri',
          ),
          SubCategory(
            id: '6-2',
            name: 'Şerbetli Tatlılar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/05/serbetli-tatlilar-sevda.jpg',
            description: 'Geleneksel şerbetli tatlı tarifleri',
          ),
          SubCategory(
            id: '6-3',
            name: 'Kurabiyeler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/05/ev-kurabiyesi-tarifi-sevda.jpg',
            description: 'Çay ve kahve yanına nefis kurabiyeler',
          ),
          SubCategory(
            id: '6-4',
            name: 'Pastalar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/07/ev-pastasi-sevda.jpg',
            description: 'Özel günler için pasta tarifleri',
          ),
          SubCategory(
            id: '6-5',
            name: 'Ekmek ve Poğaçalar',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/04/ev-ekmegi-tarifi-videolu-sevda.jpg',
            description: 'Ev yapımı ekmek ve poğaça tarifleri',
          ),
        ]
      ),
      Category(
        id: '7',
        name: 'İçecekler',
        imageUrl: 'assets/images/categories/icecekler.jpg',
        description: 'Ferahlatıcı içecek tarifleri',
        icon: Icons.local_drink,
        subCategories: [
          SubCategory(
            id: '7-1',
            name: 'Smoothie ve Detoks',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2016/10/smoothie-tarifi-yemekcom.jpg',
            description: 'Sağlıklı smoothie ve detoks içecekleri',
          ),
          SubCategory(
            id: '7-2',
            name: 'Ev Yapımı Soğuk İçecekler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/05/serinleten-icecekler-sevda.jpg',
            description: 'Sıcak yaz günleri için serinletici içecekler',
          ),
          SubCategory(
            id: '7-3',
            name: 'Sıcak İçecekler',
            imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/10/kis-cayi-sevda.jpg',
            description: 'Kış günleri için ısıtıcı çay ve içecek tarifleri',
          ),
        ]
      ),
    ];

    // Günün tarifleri
    final List<Recipe> dailyRecipes = [
      Recipe(
        id: '1',
        name: 'Kremalı Mantar Çorbası',
        description: 'Günün tarifi: Soğuk kış günleri için ısıtıcı bir çorba',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2014/09/kremali-mantar-corbasi-yeni-one-cikan.jpg',
        ingredients: ['Mantar', 'Krema', 'Soğan', 'Sarımsak', 'Tereyağı', 'Un', 'Tuz', 'Karabiber'],
        instructions: ['Mantarları temizleyip doğrayın', 'Soğan ve sarımsağı yağda kavurun', 'Mantarları ekleyip kavurmaya devam edin', 'Un ve kremayı ekleyin'],
        preparationTime: '30 dakika',
        category: 'Çorbalar',
        stars: 4,
      ),
      Recipe(
        id: '2',
        name: 'Fırında Tavuk But',
        description: 'Günün tarifi: Yumuşacık ve baharatlı fırın but',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2015/01/firin-posetinde-tavuk-but-yeni.jpg',
        ingredients: ['Tavuk but', 'Zeytinyağı', 'Sarımsak', 'Kekik', 'Pul biber', 'Tuz', 'Karabiber'],
        instructions: ['Tavuk butları yıkayıp kurulayın', 'Baharatları karıştırın', 'Tavukları marine edin', 'Fırında pişirin'],
        preparationTime: '45 dakika',
        category: 'Et Yemekleri',
        stars: 5,
      ),
      Recipe(
        id: '3',
        name: 'Karamelli Cheesecake',
        description: 'Günün tatlısı: Yumuşacık dokulu enfes cheesecake',
        imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/04/karamelli-cheesecake-sevda.jpg',
        ingredients: ['Bisküvi', 'Tereyağı', 'Labne peyniri', 'Krema', 'Şeker', 'Yumurta', 'Vanilya', 'Karamel sos'],
        instructions: ['Bisküvileri robottan geçirin', 'Tereyağı ile karıştırıp kalıba bastırın', 'Peynirli harcı hazırlayın', 'Üzerine karamel sos gezdirin'],
        preparationTime: '60 dakika',
        category: 'Tatlılar',
        stars: 5,
      ),
    ];

    return StreamBuilder<List<String>>(
      stream: _firestoreService.getUserFavoriteIds(userId ?? ''),
      builder: (context, favoriteSnapshot) {
        final favoriteIds = favoriteSnapshot.data ?? [];
        
        return Scaffold(
          
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Arama Çubuğu
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tarif veya malzeme ara...',
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF2A6CB0)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Arama özelliği yakında: $value')),
                          );
                        }
                      },
                    ),
                  ),
                  
                  // Kategoriler Başlığı
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kategoriler',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tümünü Gör',
                        style: TextStyle(
                          color: Color(0xFF2A6CB0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Kategoriler Listesi (yatay kaydırılabilir)
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mainCategories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CategoryCard(category: mainCategories[index]),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Popüler Kategoriler
                  const Text(
                    'Popüler Kategoriler',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Popüler kategorilerin grid görünümü
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 4, // İlk 4 kategoriyi gösterelim
                    itemBuilder: (context, index) {
                      return _buildPopularCategoryItem(mainCategories[index]);
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Günün Tarifleri Başlığı
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Günün Tarifleri',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tümünü Gör',
                        style: TextStyle(
                          color: Color(0xFF2A6CB0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Günün Tarifleri Listesi
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dailyRecipes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RecipeCard(
                          recipe: dailyRecipes[index],
                          userFavoriteIds: favoriteIds,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildPopularCategoryItem(Category category) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            // Kategori detayına gidecek
          },
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Arkaplan resmi
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: category.imageUrl.startsWith('assets/')
                    ? Image.asset(
                        category.imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        category.imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              // Karartma efekti
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              // Kategori bilgisi
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      category.icon ?? Icons.category,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 