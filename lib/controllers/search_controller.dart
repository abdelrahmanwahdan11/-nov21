import 'package:flutter/foundation.dart';
import '../models/hotel.dart';
import 'hotels_controller.dart';

enum SortOption { price, rating, distance }

class SearchController extends ChangeNotifier {
  SearchController(this.hotelsController);

  final HotelsController hotelsController;
  String query = '';
  List<String> tags = [];
  SortOption sortOption = SortOption.price;

  List<Hotel> get results {
    final filtered = hotelsController.filter(query: query, tags: tags);
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
}
