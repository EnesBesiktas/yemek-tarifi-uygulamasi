import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../services/user_service.dart';
import '../services/firestore_service.dart';
import '../models/recipe.dart';

String formatTimestamp(dynamic timestamp) {
  if (timestamp == null) return '-';
  if (timestamp is DateTime) {
    return DateFormat('dd.MM.yyyy HH:mm').format(timestamp);
  }
  if (timestamp.toString().contains('Timestamp')) {
    try {
      return DateFormat('dd.MM.yyyy HH:mm').format(timestamp.toDate());
    } catch (_) {}
  }
  return timestamp.toString();
}

class ProfileScreen extends StatelessWidget {
  final UserService _userService = UserService();
  final FirestoreService _firestoreService = FirestoreService();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text('Kullanıcı bulunamadı'));
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profilim'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bilgilerim'),
              Tab(text: 'Tariflerim'),
              Tab(text: 'Favorilerim'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserInfoTab(user),
            _buildUserRecipesTab(user.uid),
            _buildUserFavoritesTab(user.uid),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTab(User user) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: _userService.getUserStream(user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data;
        if (userData == null) {
          return const Center(child: Text('Kullanıcı bilgileri bulunamadı'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: userData['photoUrl'] != null
                      ? NetworkImage(userData['photoUrl'])
                      : null,
                  child: userData['photoUrl'] == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoCard('E-posta', userData['email'] ?? ''),
              _buildInfoCard('Kullanıcı Adı', userData['displayName'] ?? ''),
              _buildInfoCard('Kayıt Tarihi', formatTimestamp(userData['createdAt'])),
              _buildInfoCard('Son Giriş', formatTimestamp(userData['lastLoginAt'])),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserRecipesTab(String userId) {
    return StreamBuilder<List<String>>(
      stream: _userService.getUserRecipes(userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final recipeIds = snapshot.data!;
        if (recipeIds.isEmpty) {
          return const Center(child: Text('Henüz tarif eklenmemiş'));
        }

        return StreamBuilder<List<Recipe>>(
          stream: _firestoreService.getRecipes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final recipes = snapshot.data!
                .where((recipe) => recipeIds.contains(recipe.id))
                .toList();

            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: recipe.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              recipe.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.restaurant, size: 40),
                    title: Text(recipe.name),
                    subtitle: Text(recipe.description),
                    trailing: Text('${recipe.stars} ⭐'),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildUserFavoritesTab(String userId) {
    return StreamBuilder<List<String>>(
      stream: _userService.getUserFavorites(userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final favoriteIds = snapshot.data!;
        if (favoriteIds.isEmpty) {
          return const Center(child: Text('Henüz favori tarif eklenmemiş'));
        }

        return StreamBuilder<List<Recipe>>(
          stream: _firestoreService.getRecipes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final recipes = snapshot.data!
                .where((recipe) => favoriteIds.contains(recipe.id))
                .toList();

            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: recipe.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              recipe.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.restaurant, size: 40),
                    title: Text(recipe.name),
                    subtitle: Text(recipe.description),
                    trailing: Text('${recipe.stars} ⭐'),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 