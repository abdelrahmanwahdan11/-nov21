import 'package:flutter/foundation.dart';
import '../core/utils/dummy_data.dart';
import '../models/booking.dart';
import '../models/hotel.dart';

class BookingsController extends ChangeNotifier {
  BookingsController() {
    _bookings = buildDummyBookings([]);
  }

  List<Booking> _bookings = [];

  List<Booking> get upcoming =>
      _bookings.where((b) => b.status == BookingStatus.upcoming && b.date.isAfter(DateTime.now())).toList();
  List<Booking> get past =>
      _bookings.where((b) => b.status != BookingStatus.upcoming || b.date.isBefore(DateTime.now())).toList();

  void seedHotels(List<Hotel> hotels) {
    _bookings = buildDummyBookings(hotels);
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }
}
