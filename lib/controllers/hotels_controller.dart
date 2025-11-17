import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/utils/dummy_data.dart';
import '../models/hotel.dart';
import '../models/search_filters.dart';

class HotelsController extends ChangeNotifier {
  HotelsController() {
    _all = buildDummyHotels();
    _visible = _all.take(_pageSize).toList();
  }

  final int _pageSize = 2;
  List<Hotel> _all = [];
  List<Hotel> _visible = [];
  final Set<String> _favorites = {};
  final Set<String> _comparison = {};
  bool _isLoadingMore = false;

  List<Hotel> get allHotels => _all;
  List<Hotel> get visible => _visible;
  bool get isLoadingMore => _isLoadingMore;
  Set<String> get favorites => _favorites;
  Set<String> get comparison => _comparison;

  bool isFavorite(Hotel hotel) => _favorites.contains(hotel.id);

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _all = buildDummyHotels();
    _visible = _all.take(_pageSize).toList();
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || _visible.length >= _all.length) return;
    _isLoadingMore = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final next = _all.skip(_visible.length).take(_pageSize);
    _visible = [..._visible, ...next];
    _isLoadingMore = false;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }

  void toggleComparison(String id) {
    if (_comparison.contains(id)) {
      _comparison.remove(id);
    } else {
      _comparison.add(id);
    }
    notifyListeners();
  }

  List<Hotel> filter({String query = '', List<String>? tags, SearchFilters? filters}) {
    final lower = query.toLowerCase();
    final f = filters ?? const SearchFilters();
    return _all.where((hotel) {
      final matchesQuery = lower.isEmpty ||
          hotel.name.toLowerCase().contains(lower) ||
          hotel.city.toLowerCase().contains(lower) ||
          hotel.tags.any((t) => t.toLowerCase().contains(lower));
      final matchesTags = tags == null || tags.isEmpty || tags.any((tag) => hotel.tags.contains(tag.toLowerCase()));
      final withinPrice = hotel.price <= f.maxPrice;
      final withinRating = hotel.rating >= f.minRating;
      final withinDistance = hotel.distanceKm <= f.maxDistance;
      final matchesType = f.types.isEmpty || f.types.any((type) => hotel.tags.contains(type.toLowerCase()));
      return matchesQuery && matchesTags && withinPrice && withinRating && withinDistance && matchesType;
    }).toList();
  }
}
