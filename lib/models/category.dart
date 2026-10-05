import 'package:flutter/material.dart';

class CategoryInfo {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryInfo(this.name, this.icon, this.color);

  static const List<CategoryInfo> expenseCategories = [
    CategoryInfo('Food', Icons.restaurant, Color(0xFFF59E0B)),
    CategoryInfo('Transportation', Icons.directions_bus, Color(0xFF3B82F6)),
    CategoryInfo('School Needs', Icons.menu_book, Color(0xFF8B5CF6)),
    CategoryInfo('Load', Icons.phone_android, Color(0xFF06B6D4)),
    CategoryInfo('Personal', Icons.person, Color(0xFFEC4899)),
    CategoryInfo('Other', Icons.category, Color(0xFF6B7C85)),
  ];

  static const CategoryInfo income =
      CategoryInfo('Allowance', Icons.savings, Color(0xFF14A38B));

  static CategoryInfo byName(String name) {
    final all = [...expenseCategories, income];
    return all.firstWhere(
      (c) => c.name == name,
      orElse: () => expenseCategories.last,
    );
  }
}