import 'package:flutter/material.dart';

class SelectedCategories extends ChangeNotifier {
  List<String> _selectedInterests = [];

  List<String> get selectedInterests => _selectedInterests;

  void setSelectedInterests(List<String> interests) {
    _selectedInterests = interests;
    notifyListeners();
  }
}
