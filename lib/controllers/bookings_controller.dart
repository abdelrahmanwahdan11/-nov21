import 'package:flutter/material.dart';

import '../core/utils/dummy_data.dart';
import '../models/booking.dart';

class BookingsController extends ChangeNotifier {
  BookingsController() {
    _bookings = generateBookings();
  }

  late List<Booking> _bookings;

  List<Booking> get bookings => List.unmodifiable(_bookings);
  Iterable<Booking> get upcoming => _bookings.where((b) => b.status == BookingStatus.upcoming || b.status == BookingStatus.checkedIn);
  Iterable<Booking> get past => _bookings.where((b) => b.status == BookingStatus.completed || b.status == BookingStatus.cancelled);

  void addBooking(Booking booking) {
    _bookings = [..._bookings, booking];
    notifyListeners();
  }

  void checkIn(String id) {
    _bookings = _bookings
        .map((b) => b.id == id ? b.copyWith(status: BookingStatus.checkedIn) : b)
        .toList();
    notifyListeners();
  }

  void complete(String id) {
    _bookings = _bookings
        .map((b) => b.id == id ? b.copyWith(status: BookingStatus.completed) : b)
        .toList();
    notifyListeners();
  }

  void cancel(String id) {
    _bookings = _bookings
        .map((b) => b.id == id ? b.copyWith(status: BookingStatus.cancelled) : b)
        .toList();
    notifyListeners();
  }
}
