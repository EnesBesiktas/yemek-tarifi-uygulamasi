import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/category.dart';
import '../widgets/recipe_card.dart';

class RecipePage extends StatelessWidget {
  final Category category;
  final SubCategory? subCategory;

  const RecipePage({
    super.key,
    required this.category,
    this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    // Örnek tarifler - gerçek uygulamada bu veriler bir API'den gelecek
    final List<Recipe> recipes = _getRecipesForCategory(category, subCategory);

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
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RecipeCard(recipe: recipes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Recipe> _getRecipesForCategory(Category category, SubCategory? subCategory) {
    switch (category.id) {
      case '1': // Dünya Mutfağı
        switch (subCategory?.id) {
          case '1-1': // İtalyan
            return [
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
            ];
          case '1-2': // Meksika
            return [
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
            ];
          case '1-3': // Hint
            return [
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
            ];
          case '1-4': // Çin
            return [
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
            ];
          case '1-5': // Japon
            return [
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
            ];
          case '1-6': // Orta Doğu
            return [
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
            ];
          case '1-7': // Türk Mutfağı
            return [
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
            ];
          default:
            return [];
        }
      case '2': // Pişirme Yöntemi
        switch (subCategory?.id) {
          case '2-1': // Fırın Yemekleri
            return [
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
            ];
          case '2-2': // Tencere Yemekleri
            return [
              Recipe(
                id: 'tc1',
                name: 'Etli Taze Fasulye',
                description: 'Tencerede pişen klasik bir yemek',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/10/kis-yemekleri-sevda.jpg',
                ingredients: ['Taze fasulye', 'Kuşbaşı et', 'Soğan', 'Domates', 'Zeytinyağı', 'Tuz'],
                instructions: ['Etleri kavurun', 'Sebzeleri ekleyin', 'Tencerede pişirin'],
                preparationTime: '50 dakika',
                category: 'Tencere Yemekleri',
                stars: 4,
              ),
            ];
          case '2-3': // Izgara
            return [
              Recipe(
                id: 'iz1',
                name: 'Izgara Köfte',
                description: 'Izgarada pişen nefis köfte tarifi',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2015/06/izgara-kofte-yeni-one-cikan.jpg',
                ingredients: ['Kıyma', 'Soğan', 'Ekmek içi', 'Tuz', 'Karabiber', 'Kimyon'],
                instructions: ['Malzemeleri yoğurun', 'Şekil verin', 'Izgarada pişirin'],
                preparationTime: '30 dakika',
                category: 'Izgara',
                stars: 5,
              ),
            ];
          case '2-4': // Buharda
            return [
              Recipe(
                id: 'bh1',
                name: 'Buharda Sebze',
                description: 'Buharda pişmiş sağlıklı sebzeler',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/03/buharda-pisirme-sevda.jpg',
                ingredients: ['Brokoli', 'Havuç', 'Karnabahar', 'Tuz'],
                instructions: ['Sebzeleri doğrayın', 'Buharda pişirin', 'Servis edin'],
                preparationTime: '20 dakika',
                category: 'Buharda',
                stars: 4,
              ),
            ];
          case '2-5': // Kızartmalar
            return [
              Recipe(
                id: 'kz1',
                name: 'Patates Kızartması',
                description: 'Klasik çıtır patates kızartması',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/01/patates-kizartmasi-yemekcom.jpg',
                ingredients: ['Patates', 'Ayçiçek yağı', 'Tuz'],
                instructions: ['Patatesleri doğrayın', 'Kızgın yağda kızartın', 'Tuzlayıp servis edin'],
                preparationTime: '15 dakika',
                category: 'Kızartmalar',
                stars: 5,
              ),
            ];
          case '2-6': // Çiğ Tarifler
            return [
              Recipe(
                id: 'cg1',
                name: 'Çiğ Kabak Salatası',
                description: 'Pişirilmeden hazırlanan sağlıklı salata',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/05/raw-food-sevda.jpg',
                ingredients: ['Kabak', 'Havuç', 'Limon', 'Zeytinyağı', 'Tuz'],
                instructions: ['Kabak ve havucu rendeleyin', 'Limon ve yağ ile karıştırın'],
                preparationTime: '10 dakika',
                category: 'Çiğ Tarifler',
                stars: 4,
              ),
            ];
          default:
            return [];
        }
      case '3': // Öğüne Göre
        switch (subCategory?.id) {
          case '3-1': // Kahvaltılıklar
            return [
              Recipe(
                id: 'kh1',
                name: 'Menemen',
                description: 'Türk kahvaltısının vazgeçilmezi',
                imageUrl: 'assets/menemen.jpg',
                ingredients: ['Yumurta', 'Domates', 'Biber', 'Soğan', 'Zeytinyağı', 'Tuz'],
                instructions: ['Sebzeleri doğrayın', 'Pişirin', 'Yumurtaları ekleyin'],
                preparationTime: '20 dakika',
                category: 'Kahvaltılıklar',
                stars: 5,
              ),
            ];
          case '3-2': // Öğle Yemekleri
            return [
              Recipe(
                id: 'oy1',
                name: 'Tavuklu Salata',
                description: 'Öğle için hafif ve doyurucu salata',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/06/pratik-ogle-yemekleri-sevda.jpg',
                ingredients: ['Tavuk göğsü', 'Marul', 'Domates', 'Salatalık', 'Zeytinyağı'],
                instructions: ['Tavukları haşlayın', 'Sebzelerle karıştırın', 'Sos ekleyin'],
                preparationTime: '25 dakika',
                category: 'Öğle Yemekleri',
                stars: 4,
              ),
            ];
          case '3-3': // Akşam Yemekleri
            return [
              Recipe(
                id: 'ay1',
                name: 'Fırında Somon',
                description: 'Akşam için sağlıklı ve pratik bir balık yemeği',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/01/tek-kisilik-aksamyemegi-sevda.jpg',
                ingredients: ['Somon', 'Limon', 'Zeytinyağı', 'Tuz', 'Karabiber'],
                instructions: ['Somonu yağlayın', 'Fırında pişirin', 'Limonla servis edin'],
                preparationTime: '30 dakika',
                category: 'Akşam Yemekleri',
                stars: 5,
              ),
            ];
          case '3-4': // Ara Öğünler
            return [
              Recipe(
                id: 'ar1',
                name: 'Enerji Topları',
                description: 'Ara öğün için sağlıklı atıştırmalık',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/12/saglikli-atiştirmaliklar-sevda.jpg',
                ingredients: ['Yulaf', 'Fıstık ezmesi', 'Bal', 'Kakao', 'Ceviz'],
                instructions: ['Tüm malzemeleri karıştırın', 'Toplar yapın', 'Buzdolabında dinlendirin'],
                preparationTime: '15 dakika',
                category: 'Ara Öğünler',
                stars: 4,
              ),
            ];
          case '3-5': // Atıştırmalıklar
            return [
              Recipe(
                id: 'at1',
                name: 'Ev Yapımı Cips',
                description: 'Film akşamları için pratik cips tarifi',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/04/ev-cipsi-yemekcom.jpg',
                ingredients: ['Patates', 'Zeytinyağı', 'Tuz', 'Baharatlar'],
                instructions: ['Patatesleri ince dilimleyin', 'Fırında kızartın', 'Baharatlayıp servis edin'],
                preparationTime: '20 dakika',
                category: 'Atıştırmalıklar',
                stars: 4,
              ),
            ];
          default:
            return [];
        }
      case '4': // Özel Diyetler
        switch (subCategory?.id) {
          case '4-1': // Düşük Karbonhidrat
            return [
              Recipe(
                id: 'dk1',
                name: 'Karnabahar Pilavı',
                description: 'Karbonhidrat oranı düşük sağlıklı pilav',
                imageUrl: 'assets/karnabaharpilavi.jpg',
                ingredients: ['Karnabahar', 'Zeytinyağı', 'Sarımsak', 'Tuz', 'Karabiber'],
                instructions: ['Karnabaharı rendeleyin', 'Pişirin', 'Baharatlarla servis edin'],
                preparationTime: '25 dakika',
                category: 'Düşük Karbonhidrat',
                stars: 4,
              ),
            ];
          case '4-2': // Keto
            return [
              Recipe(
                id: 'kt1',
                name: 'Keto Omlet',
                description: 'Yüksek yağlı, düşük karbonhidratlı omlet',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2019/01/ketojenik-diyet-yemekcom.jpg',
                ingredients: ['Yumurta', 'Kaşar peyniri', 'Tereyağı', 'Ispanak'],
                instructions: ['Yumurtaları çırpın', 'Malzemeleri ekleyin', 'Tavada pişirin'],
                preparationTime: '10 dakika',
                category: 'Keto',
                stars: 5,
              ),
            ];
          case '4-3': // Glutensiz
            return [
              Recipe(
                id: 'gl1',
                name: 'Glutensiz Kek',
                description: 'Gluten içermeyen yumuşacık kek',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2017/05/gluten-free-1.jpg',
                ingredients: ['Glutensiz un', 'Yumurta', 'Şeker', 'Süt', 'Kabartma tozu'],
                instructions: ['Malzemeleri karıştırın', 'Fırında pişirin'],
                preparationTime: '35 dakika',
                category: 'Glutensiz',
                stars: 4,
              ),
            ];
          case '4-4': // Şekersiz
            return [
              Recipe(
                id: 'sk1',
                name: 'Şekersiz Muzlu Kek',
                description: 'Şeker ilavesiz sağlıklı kek',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2021/09/sekersiz-tatlilar-sevda.jpg',
                ingredients: ['Muz', 'Yumurta', 'Yulaf unu', 'Kabartma tozu'],
                instructions: ['Malzemeleri karıştırın', 'Fırında pişirin'],
                preparationTime: '30 dakika',
                category: 'Şekersiz',
                stars: 4,
              ),
            ];
          case '4-5': // Paleo
            return [
              Recipe(
                id: 'pl1',
                name: 'Paleo Kurabiye',
                description: 'Paleo beslenmeye uygun kurabiye',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2016/05/paleo-beslenme-yemekcom.jpg',
                ingredients: ['Badem unu', 'Yumurta', 'Bal', 'Hindistan cevizi yağı'],
                instructions: ['Malzemeleri karıştırın', 'Şekil verin', 'Fırında pişirin'],
                preparationTime: '20 dakika',
                category: 'Paleo',
                stars: 4,
              ),
            ];
          default:
            return [];
        }
      case '5': // Zaman ve Zorluk
        switch (subCategory?.id) {
          case '5-1': // 15 Dakikada Tarifler
            return [
              Recipe(
                id: '15d1',
                name: 'Hızlı Makarna',
                description: '15 dakikada hazır pratik makarna',
                imageUrl: 'assets/hizlimakarna.jpg',
                ingredients: ['Makarna', 'Zeytinyağı', 'Sarımsak', 'Pul biber', 'Tuz'],
                instructions: ['Makarnayı haşlayın', 'Sosu hazırlayın', 'Birleştirin'],
                preparationTime: '15 dakika',
                category: '15 Dakikada Tarifler',
                stars: 4,
              ),
            ];
          case '5-2': // Kolay Tarifler
            return [
              Recipe(
                id: 'kl1',
                name: 'Kolay Krep',
                description: 'Mutfakta yeni başlayanlar için pratik krep',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/04/en-kolay-tarifler-sevda.jpg',
                ingredients: ['Un', 'Yumurta', 'Süt', 'Tuz'],
                instructions: ['Malzemeleri karıştırın', 'Tavada pişirin'],
                preparationTime: '10 dakika',
                category: 'Kolay Tarifler',
                stars: 4,
              ),
            ];
          case '5-3': // Tek Tencere Yemekler
            return [
              Recipe(
                id: 'tt1',
                name: 'Tek Tencerede Tavuklu Pilav',
                description: 'Tek tencerede kolayca hazırlanan pilav',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/06/tek-tencere-yemekleri-sevda.jpg',
                ingredients: ['Pirinç', 'Tavuk', 'Tereyağı', 'Tuz', 'Karabiber'],
                instructions: ['Tavukları kavurun', 'Pirinç ekleyin', 'Suyunu çekene kadar pişirin'],
                preparationTime: '35 dakika',
                category: 'Tek Tencere Yemekler',
                stars: 4,
              ),
            ];
          case '5-4': // Öğrenci Yemekleri
            return [
              Recipe(
                id: 'ogr1',
                name: 'Makarna Salatası',
                description: 'Öğrenciler için ekonomik ve pratik salata',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/07/ogrenci-evi-yemekleri-sevda.jpg',
                ingredients: ['Makarna', 'Yoğurt', 'Mayonez', 'Mısır', 'Salatalık turşusu'],
                instructions: ['Makarnayı haşlayın', 'Malzemeleri karıştırın', 'Soğuk servis edin'],
                preparationTime: '20 dakika',
                category: 'Öğrenci Yemekleri',
                stars: 4,
              ),
            ];
          default:
            return [];
        }
      case '6': // Tatlılar ve Hamur İşleri
        switch (subCategory?.id) {
          case '6-1': // Sütlü Tatlılar
            return [
              Recipe(
                id: 'st1',
                name: 'Kazandibi',
                description: 'Geleneksel Türk tatlısı',
                imageUrl: 'assets/kazandibi.jpg',
                ingredients: ['Süt', 'Pirinç unu', 'Şeker', 'Tereyağı'],
                instructions: ['Malzemeleri karıştırın', 'Pişirin', 'Soğutun'],
                preparationTime: '40 dakika',
                category: 'Sütlü Tatlılar',
                stars: 5,
              ),
            ];
          case '6-2': // Şerbetli Tatlılar
            return [
              Recipe(
                id: 'ser1',
                name: 'Baklava',
                description: 'Geleneksel şerbetli tatlı',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/05/serbetli-tatlilar-sevda.jpg',
                ingredients: ['Yufka', 'Ceviz', 'Tereyağı', 'Şeker', 'Su', 'Limon'],
                instructions: ['Yufkaları dizin', 'Ceviz serpin', 'Şerbeti hazırlayın', 'Fırında pişirin'],
                preparationTime: '60 dakika',
                category: 'Şerbetli Tatlılar',
                stars: 5,
              ),
            ];
          case '6-3': // Kurabiyeler
            return [
              Recipe(
                id: 'krb1',
                name: 'Un Kurabiyesi',
                description: 'Ağızda dağılan klasik kurabiye',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/05/ev-kurabiyesi-tarifi-sevda.jpg',
                ingredients: ['Un', 'Tereyağı', 'Pudra şekeri'],
                instructions: ['Malzemeleri yoğurun', 'Şekil verin', 'Fırında pişirin'],
                preparationTime: '25 dakika',
                category: 'Kurabiyeler',
                stars: 4,
              ),
            ];
          case '6-4': // Pastalar
            return [
              Recipe(
                id: 'pst1',
                name: 'Çikolatalı Pasta',
                description: 'Özel günler için çikolatalı pasta',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/07/ev-pastasi-sevda.jpg',
                ingredients: ['Un', 'Yumurta', 'Şeker', 'Kakao', 'Krema'],
                instructions: ['Kek harcını hazırlayın', 'Fırında pişirin', 'Kremasını sürün'],
                preparationTime: '50 dakika',
                category: 'Pastalar',
                stars: 5,
              ),
            ];
          case '6-5': // Ekmek ve Poğaçalar
            return [
              Recipe(
                id: 'ek1',
                name: 'Ev Ekmeği',
                description: 'Evde kolayca yapılan ekmek tarifi',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/04/ev-ekmegi-tarifi-videolu-sevda.jpg',
                ingredients: ['Un', 'Su', 'Tuz', 'Maya'],
                instructions: ['Hamuru yoğurun', 'Mayalandırın', 'Fırında pişirin'],
                preparationTime: '90 dakika',
                category: 'Ekmek ve Poğaçalar',
                stars: 4,
              ),
            ];
          default:
            return [];
        }
      case '7': // İçecekler
        switch (subCategory?.id) {
          case '7-1': // Smoothie ve Detoks
            return [
              Recipe(
                id: 'sm1',
                name: 'Yeşil Smoothie',
                description: 'Sağlıklı ve enerji veren smoothie',
                imageUrl: 'assets/yesilsmoothie.jpg',
                ingredients: ['Ispanak', 'Muz', 'Elma', 'Limon', 'Su'],
                instructions: ['Tüm malzemeleri blenderdan geçirin', 'Servis edin'],
                preparationTime: '5 dakika',
                category: 'Smoothie',
                stars: 4,
              ),
            ];
          case '7-2': // Ev Yapımı Soğuk İçecekler
            return [
              Recipe(
                id: 'sic1',
                name: 'Limonata',
                description: 'Ev yapımı serinletici limonata',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2022/05/serinleten-icecekler-sevda.jpg',
                ingredients: ['Limon', 'Şeker', 'Su', 'Nane'],
                instructions: ['Limonları sıkın', 'Şeker ve su ile karıştırın', 'Buz ve nane ekleyin'],
                preparationTime: '10 dakika',
                category: 'Soğuk İçecekler',
                stars: 5,
              ),
            ];
          case '7-3': // Sıcak İçecekler
            return [
              Recipe(
                id: 'sic2',
                name: 'Kış Çayı',
                description: 'Kış günleri için ısıtıcı bitki çayı',
                imageUrl: 'https://cdn.yemek.com/mnresize/940/940/uploads/2020/10/kis-cayi-sevda.jpg',
                ingredients: ['Ihlamur', 'Tarçın', 'Karanfil', 'Zencefil', 'Bal'],
                instructions: ['Tüm malzemeleri demleyin', 'Sıcak servis edin'],
                preparationTime: '15 dakika',
                category: 'Sıcak İçecekler',
                stars: 4,
              ),
            ];
          default:
            return [];
        }
      default:
        return [];
    }
  }
} 