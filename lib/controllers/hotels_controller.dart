import 'dart:async';

import 'package:flutter/material.dart';

import '../core/utils/dummy_data.dart';
import '../models/hotel.dart';

class HotelsController extends ChangeNotifier {
  HotelsController() {
    _allHotels = generateHotels();
    applyFilters();
  }

  late List<Hotel> _allHotels;
  final ValueNotifier<List<Hotel>> hotelsNotifier = ValueNotifier<List<Hotel>>([]);
  final List<Hotel> _comparison = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  int _page = 1;
  final int _perPage = 6;
  String category = 'Premium';

  List<Hotel> get comparison => List.unmodifiable(_comparison);

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 900));
    _allHotels = generateHotels();
    _page = 1;
    applyFilters();
    isLoading = false;
    notifyListeners();
  }

  void updateCategory(String newCategory) {
    category = newCategory;
    _page = 1;
    applyFilters();
  }

  void applyFilters({String query = '', double? maxPrice, double? minRating, double? maxDistance, List<String>? types, List<String>? tags}) {
    Iterable<Hotel> filtered = _allHotels;
    if (category.isNotEmpty) {
      filtered = filtered.where((h) => h.type == category);
    }
    if (query.isNotEmpty) {
      filtered = filtered.where((h) =>
          h.name.toLowerCase().contains(query.toLowerCase()) ||
          h.city.toLowerCase().contains(query.toLowerCase()) ||
          h.tags.any((t) => t.contains(query.toLowerCase())));
    }
    if (maxPrice != null) {
      filtered = filtered.where((h) => h.price <= maxPrice);
    }
    if (minRating != null) {
      filtered = filtered.where((h) => h.rating >= minRating);
    }
    if (maxDistance != null) {
      filtered = filtered.where((h) => h.distance <= maxDistance);
    }
    if (types != null && types.isNotEmpty) {
      filtered = filtered.where((h) => types.contains(h.type));
    }
    if (tags != null && tags.isNotEmpty) {
      filtered = filtered.where((h) => h.tags.any(tags.contains));
    }
    final list = filtered.take(_page * _perPage).toList();
    hotelsNotifier.value = list;
  }

  Future<void> loadMore({String query = ''}) async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 700));
    _page += 1;
    applyFilters(query: query);
    isLoadingMore = false;
    notifyListeners();
  }

  void toggleComparison(Hotel hotel) {
    if (_comparison.any((h) => h.id == hotel.id)) {
      _comparison.removeWhere((h) => h.id == hotel.id);
    } else {
      if (_comparison.length < 4) {
        _comparison.add(hotel);
      }
    }
    notifyListeners();
  }
}
