import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final List<SubCategory>? subCategories;
  final IconData? icon;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    this.subCategories,
    this.icon,
  });
}

class SubCategory {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  SubCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });
} 