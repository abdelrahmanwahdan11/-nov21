import 'package:flutter/foundation.dart';
import '../core/utils/dummy_data.dart';
import '../models/booking.dart';
import '../models/hotel.dart';

class BookingsController extends ChangeNotifier {
  BookingsController() {
    _bookings = buildDummyBookings([]);
  }

  List<Booking> _bookings = [];
  bool _seeded = false;

  List<Booking> get all => List.unmodifiable(_bookings);
  List<Booking> get upcoming =>
      _bookings.where((b) => b.status == BookingStatus.upcoming && b.date.isAfter(DateTime.now())).toList();
  List<Booking> get inHouse => _bookings.where((b) => b.status == BookingStatus.checkedIn).toList();
  List<Booking> get past =>
      _bookings.where((b) => b.status == BookingStatus.completed || b.status == BookingStatus.cancelled).toList();

  void seedHotels(List<Hotel> hotels) {
    if (_seeded || hotels.isEmpty) return;
    _bookings = buildDummyBookings(hotels);
    _seeded = true;
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void checkIn(String id) {
    _updateStatus(id, BookingStatus.checkedIn);
  }

  void complete(String id) {
    _updateStatus(id, BookingStatus.completed);
  }

  void cancel(String id) {
    _updateStatus(id, BookingStatus.cancelled);
  }

  void _updateStatus(String id, BookingStatus status) {
    _bookings = _bookings
        .map((b) => b.id == id
            ? b.copyWith(
                status: status,
              )
            : b)
        .toList();
    notifyListeners();
  }
}
