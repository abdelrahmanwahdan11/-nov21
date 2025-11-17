import 'package:flutter/material.dart';

import 'hotels_controller.dart';

class SearchFilters {
  SearchFilters({
    this.maxPrice,
    this.minRating,
    this.maxDistance,
    this.types = const [],
    this.tags = const [],
  });

  final double? maxPrice;
  final double? minRating;
  final double? maxDistance;
  final List<String> types;
  final List<String> tags;

  SearchFilters copyWith({
    double? maxPrice,
    double? minRating,
    double? maxDistance,
    List<String>? types,
    List<String>? tags,
  }) {
    return SearchFilters(
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      maxDistance: maxDistance ?? this.maxDistance,
      types: types ?? this.types,
      tags: tags ?? this.tags,
    );
  }
}

class SearchController extends ChangeNotifier {
  SearchController(this._hotelsController);

  final HotelsController _hotelsController;
  final TextEditingController queryController = TextEditingController();
  SearchFilters filters = SearchFilters();

  void updateQuery(String value) {
    _hotelsController.applyFilters(
      query: value,
      maxPrice: filters.maxPrice,
      minRating: filters.minRating,
      maxDistance: filters.maxDistance,
      types: filters.types,
      tags: filters.tags,
      ignoreCategory: true,
    );
    notifyListeners();
  }

  void updateFilters(SearchFilters newFilters) {
    filters = newFilters;
    updateQuery(queryController.text);
  }

  void resetFilters() {
    filters = SearchFilters();
    updateQuery(queryController.text);
  }
}
