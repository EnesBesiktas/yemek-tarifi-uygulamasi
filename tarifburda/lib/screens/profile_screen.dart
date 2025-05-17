import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek kullanıcı bilgileri
    const String name = 'Ahmet Yılmaz';
    const String email = 'ahmet.yilmaz@example.com';
    const String avatarUrl = 'https://randomuser.me/api/portraits/men/32.jpg';
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Üst kısım
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2A6CB0),
                  const Color(0xFF3949AB),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Profil resmi
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(avatarUrl),
                    onBackgroundImageError: (_, __) {},
                    child: avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 60, color: Color(0xFF2A6CB0))
                        : null,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Kullanıcı adı
                const Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Kullanıcı e-postası
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // İstatistikler
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatItem(value: '12', label: 'Yıldızlanan', color: Color(0xFFFF5722), icon: Icons.favorite),
                _StatItem(value: '3', label: 'Paylaşılan', color: Color(0xFF4CAF50), icon: Icons.upload_file),
                _StatItem(value: '48', label: 'Görüntülenen', color: Color(0xFF2A6CB0), icon: Icons.visibility),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Ayarlar menüsü
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _ProfileMenuItem(
                  icon: Icons.settings,
                  title: 'Hesap Ayarları',
                  subtitle: 'Profil bilgilerinizi düzenleyin',
                  color: Colors.blue,
                  onTap: () {},
                ),
                
                const Divider(height: 1),
                
                _ProfileMenuItem(
                  icon: Icons.notifications,
                  title: 'Bildirim Ayarları',
                  subtitle: 'Bildirimleri özelleştirin',
                  color: Colors.amber,
                  onTap: () {},
                ),
                
                const Divider(height: 1),
                
                _ProfileMenuItem(
                  icon: Icons.lock,
                  title: 'Gizlilik Ayarları',
                  subtitle: 'Güvenlik ve gizlilik tercihleriniz',
                  color: Colors.green,
                  onTap: () {},
                ),
                
                const Divider(height: 1),
                
                _ProfileMenuItem(
                  icon: Icons.language,
                  title: 'Dil Seçenekleri',
                  subtitle: 'Uygulama dilini değiştirin',
                  color: Colors.deepPurple,
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Çıkış yap butonu
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                // Çıkış yap işlemi
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Çıkış Yap'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red.shade700,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// İstatistik gösterimi için widget
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

// Profil menü elemanı
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
} 