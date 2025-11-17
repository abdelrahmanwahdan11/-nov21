import 'package:flutter/material.dart';

import '../models/hotel.dart';

class ComparisonController extends ChangeNotifier {
  final List<Hotel> _selected = [];

  List<Hotel> get selected => List.unmodifiable(_selected);

  void toggleHotel(Hotel hotel) {
    if (_selected.any((h) => h.id == hotel.id)) {
      _selected.removeWhere((h) => h.id == hotel.id);
    } else if (_selected.length < 4) {
      _selected.add(hotel);
    }
    notifyListeners();
  }

  bool contains(Hotel hotel) => _selected.any((h) => h.id == hotel.id);
}
