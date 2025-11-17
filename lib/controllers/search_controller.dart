import 'package:flutter/foundation.dart';
import '../models/hotel.dart';
import '../models/search_filters.dart';
import 'hotels_controller.dart';

enum SortOption { price, rating, distance }

class SearchController extends ChangeNotifier {
  SearchController(this.hotelsController);

  final HotelsController hotelsController;
  String query = '';
  List<String> tags = [];
  SortOption sortOption = SortOption.price;
  SearchFilters filters = const SearchFilters();
  List<String> recentQueries = [];
  List<SearchPreset> presets = [];

  List<Hotel> get results {
    final filtered = hotelsController.filter(query: query, tags: tags, filters: filters);
    filtered.sort((a, b) {
      switch (sortOption) {
        case SortOption.rating:
          return b.rating.compareTo(a.rating);
        case SortOption.distance:
          return a.distanceKm.compareTo(b.distanceKm);
        case SortOption.price:
        default:
          return a.price.compareTo(b.price);
      }
    });
    return filtered;
  }

  void updateQuery(String value) {
    query = value;
    notifyListeners();
  }

  void updateTags(List<String> value) {
    tags = value;
    notifyListeners();
  }

  void updateSort(SortOption option) {
    sortOption = option;
    notifyListeners();
  }

  void updateFilters(SearchFilters value) {
    filters = value;
    notifyListeners();
  }

  void resetFilters() {
    filters = const SearchFilters();
    notifyListeners();
  }

  void addRecentQuery(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return;
    recentQueries.remove(clean);
    recentQueries.insert(0, clean);
    if (recentQueries.length > 5) {
      recentQueries = recentQueries.sublist(0, 5);
    }
    notifyListeners();
  }

  void clearRecents() {
    recentQueries = [];
    notifyListeners();
  }

  void savePreset(String label) {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return;
    presets.removeWhere((p) => p.label == trimmed);
    presets.insert(
      0,
      SearchPreset(
        label: trimmed,
        query: query,
        tags: List.from(tags),
        sort: sortOption,
        filters: filters,
      ),
    );
    if (presets.length > 4) {
      presets = presets.sublist(0, 4);
    }
    notifyListeners();
  }

  void removePreset(String label) {
    presets.removeWhere((p) => p.label == label);
    notifyListeners();
  }

  void applyPreset(SearchPreset preset) {
    query = preset.query;
    tags = List.from(preset.tags);
    sortOption = preset.sort;
    filters = preset.filters;
    notifyListeners();
  }
}

class SearchPreset {
  SearchPreset({
    required this.label,
    this.query = '',
    this.tags = const [],
    this.sort = SortOption.price,
    this.filters = const SearchFilters(),
  });

  final String label;
  final String query;
  final List<String> tags;
  final SortOption sort;
  final SearchFilters filters;
}
