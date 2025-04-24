import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  int _selectedId = 1;

  int get selectedId => _selectedId;

  void setCategory(int id) {
    _selectedId = id;
    notifyListeners();
  }
}