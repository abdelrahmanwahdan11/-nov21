import 'package:flutter/foundation.dart';
import '../models/hotel.dart';

class ComparisonController extends ChangeNotifier {
  final List<Hotel> selected = [];

  void toggle(Hotel hotel) {
    if (selected.any((h) => h.id == hotel.id)) {
      selected.removeWhere((h) => h.id == hotel.id);
    } else if (selected.length < 4) {
      selected.add(hotel);
    }
    notifyListeners();
  }
}
