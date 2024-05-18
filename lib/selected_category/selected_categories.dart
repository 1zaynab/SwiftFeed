import 'package:flutter/material.dart';

class SelectedCategories extends ChangeNotifier {
  List<String> _selectedCategories = [];

  List<String> get selectedCategories => _selectedCategories;

  void setSelectedCategories(List<String> categories) {
    _selectedCategories = categories;
    notifyListeners();
  }
}
