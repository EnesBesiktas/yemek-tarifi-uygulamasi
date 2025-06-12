# TarifBurada Projesi Dokümantasyonu

## Proje Hakkında
TarifBurada, kullanıcıların yemek tariflerini paylaşabilecekleri, keşfedebilecekleri ve favorilerine ekleyebilecekleri bir mobil uygulama projesidir. Flutter framework'ü kullanılarak geliştirilmektedir ve Firebase altyapısı ile desteklenmektedir.

## Teknik Altyapı
- **Framework**: Flutter (Dart)
- **Backend**: Firebase
  - Firebase Authentication (Kullanıcı yönetimi)
  - Cloud Firestore (Veritabanı)
  - Firebase Storage (Medya depolama)
- **Versiyon**: 1.0.0+1

## Mevcut Özellikler
1. **Kullanıcı Yönetimi**
   - Giriş/Kayıt sistemi
   - Kullanıcı profili yönetimi

2. **Tarif Yönetimi**
   - Tarif paylaşma
   - Tarif arama ve keşfetme
   - Kategori bazlı tarif görüntüleme

3. **Arayüz**
   - Modern ve kullanıcı dostu tasarım
   - Material Design 3 uyumlu
   - Özelleştirilmiş tema ve renk şeması

## Yapılacaklar
1. **Kullanıcı Deneyimi İyileştirmeleri**
   - [ ] Tarif favorileme sistemi
   - [ ] Tarif yorum ve puanlama sistemi
   - [ ] Kullanıcı profil sayfası geliştirmeleri

2. **Tarif Özellikleri**
   - [ ] Tarif paylaşma formunun geliştirilmesi
   - [ ] Malzeme listesi ve adım adım yapılış detayları
   - [ ] Tarif düzenleme ve silme özellikleri

3. **Sosyal Özellikler**
   - [ ] Kullanıcılar arası takip sistemi
   - [ ] Tarif paylaşım özelliği
   - [ ] Bildirim sistemi

4. **Performans İyileştirmeleri**
   - [ ] Resim optimizasyonu
   - [ ] Önbellek yönetimi
   - [ ] Sayfalama ve lazy loading implementasyonu

5. **Güvenlik**
   - [ ] Kullanıcı verilerinin güvenliği
   - [ ] İçerik moderasyon sistemi
   - [ ] Kullanıcı raporlama sistemi

## Proje Yapısı
```
lib/
├── main.dart              # Ana uygulama dosyası
├── login.dart            # Giriş sayfası
├── home_page.dart        # Ana sayfa
├── services/            # Firebase servisleri
├── models/             # Veri modelleri
├── screens/           # Uygulama ekranları
├── utils/            # Yardımcı fonksiyonlar
└── widgets/         # Yeniden kullanılabilir widget'lar
```

## Geliştirme Kuralları
1. Kod yazımında Flutter/Dart best practice'lerine uyulmalıdır
2. Tüm widget'lar mümkün olduğunca yeniden kullanılabilir olmalıdır
3. Firebase güvenlik kuralları düzenli olarak gözden geçirilmelidir
4. Performans optimizasyonları sürekli göz önünde bulundurulmalıdır

## Katkıda Bulunma
1. Yeni özellikler için issue açılmalıdır
2. Pull request'ler detaylı açıklama içermelidir
3. Kod değişiklikleri test edilmiş olmalıdır
4. Material Design 3 prensipleri takip edilmelidir 