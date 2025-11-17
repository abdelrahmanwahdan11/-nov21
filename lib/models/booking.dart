import 'hotel.dart';

enum BookingStatus { upcoming, completed, cancelled }

class Booking {
  Booking({
    required this.id,
    required this.hotel,
    required this.date,
    required this.nights,
    required this.guests,
    this.status = BookingStatus.upcoming,
  });

  final String id;
  final Hotel hotel;
  final DateTime date;
  final int nights;
  final int guests;
  final BookingStatus status;
}
