import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final List<String> favoriteRecipes;
  final List<String> myRecipes;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.favoriteRecipes = const [],
    this.myRecipes = const [],
    required this.createdAt,
    required this.lastLoginAt,
  });

  // Firestore'dan veri okuma için factory constructor
  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      id: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      favoriteRecipes: List<String>.from(data['favoriteRecipes'] ?? []),
      myRecipes: List<String>.from(data['myRecipes'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp).toDate(),
    );
  }

  // Firestore'a veri yazma için Map'e dönüştürme
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'favoriteRecipes': favoriteRecipes,
      'myRecipes': myRecipes,
      'createdAt': createdAt,
      'lastLoginAt': lastLoginAt,
    };
  }
} 