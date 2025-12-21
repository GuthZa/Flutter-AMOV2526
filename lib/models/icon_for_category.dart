import 'package:flutter/material.dart';

IconData iconForCategory(String categoryName) {
  switch (categoryName) {
    case 'Monumentos':
      return Icons.account_balance;
    case 'Museus':
      return Icons.museum;
    case 'Gastronomia':
      return Icons.restaurant;
    default:
      return Icons.category;
  }
}
