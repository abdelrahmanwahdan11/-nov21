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
  int _points = 2400;

  List<Booking> get all => List.unmodifiable(_bookings);
  List<Booking> get upcoming =>
      _bookings.where((b) => b.status == BookingStatus.upcoming && b.date.isAfter(DateTime.now())).toList();
  List<Booking> get inHouse => _bookings.where((b) => b.status == BookingStatus.checkedIn).toList();
  List<Booking> get past =>
      _bookings.where((b) => b.status == BookingStatus.completed || b.status == BookingStatus.cancelled).toList();
  int get pointsBalance => _points;

  void seedHotels(List<Hotel> hotels) {
    if (_seeded || hotels.isEmpty) return;
    _bookings = buildDummyBookings(hotels);
    _points += _bookings
        .where((b) => b.status == BookingStatus.completed)
        .fold<int>(0, (sum, b) => sum + b.pointsEarned);
    _seeded = true;
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    if (booking.status == BookingStatus.completed) {
      _points += booking.pointsEarned;
    }
    notifyListeners();
  }

  void checkIn(String id) {
    _updateStatus(id, BookingStatus.checkedIn);
  }

  void complete(String id) {
    final booking = _find(id);
    if (booking == null) return;
    if (booking.status != BookingStatus.completed) {
      _points += booking.pointsEarned;
    }
    _updateStatus(id, BookingStatus.completed);
  }

  void cancel(String id) {
    _updateStatus(id, BookingStatus.cancelled);
  }

  void addNote(String id, String note) {
    _bookings = _bookings
        .map((b) => b.id == id
            ? b.copyWith(
                note: note,
              )
            : b)
        .toList();
    notifyListeners();
  }

  bool redeemPoints(int cost) {
    if (cost > _points) return false;
    _points -= cost;
    notifyListeners();
    return true;
  }

  void toggleTask(String bookingId, String title) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  tasks: b.tasks
                      .map((task) => task.title == title ? task.copyWith(done: !task.done) : task)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void toggleDocument(String bookingId, String title) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  documents: b.documents
                      .map((doc) => doc.title == title ? doc.copyWith(ready: !doc.ready) : doc)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void toggleSegment(String bookingId, String title) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  segments: b.segments
                      .map((segment) =>
                          segment.title == title ? segment.copyWith(done: !segment.done) : segment)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void toggleTransfer(String bookingId, String title) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  transfers: b.transfers
                      .map((transfer) =>
                          transfer.title == title ? transfer.copyWith(confirmed: !transfer.confirmed) : transfer)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void toggleDining(String bookingId, String venue) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  dining: b.dining
                      .map((res) => res.venue == venue ? res.copyWith(confirmed: !res.confirmed) : res)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void toggleAlert(String bookingId, String title) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  alerts: b.alerts
                      .map((alert) =>
                          alert.title == title ? alert.copyWith(acknowledged: !alert.acknowledged) : alert)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void togglePacking(String bookingId, String title) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  packing: b.packing
                      .map((item) => item.title == title ? item.copyWith(packed: !item.packed) : item)
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void addBudgetSpend(String bookingId, String category, double amount) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(
                  budgets: b.budgets
                      .map(
                        (budget) => budget.category == category
                            ? budget.copyWith(spent: (budget.spent + amount).clamp(0, budget.planned * 2))
                            : budget,
                      )
                      .toList(),
                )
              : b,
        )
        .toList();
    notifyListeners();
  }

  void addJournalEntry(String bookingId, TripJournalEntry entry) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId ? b.copyWith(journal: [...b.journal, entry]) : b,
        )
        .toList();
    notifyListeners();
  }

  void completeChecklist(String bookingId) {
    _bookings = _bookings
        .map(
          (b) => b.id == bookingId
              ? b.copyWith(tasks: b.tasks.map((task) => task.copyWith(done: true)).toList())
              : b,
        )
        .toList();
    notifyListeners();
  }

  Booking? _find(String id) {
    try {
      return _bookings.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
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
