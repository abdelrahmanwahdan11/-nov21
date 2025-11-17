import 'hotel.dart';

enum BookingStatus { upcoming, checkedIn, completed, cancelled }

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

  String get hotelName => hotel.name;
  String get city => hotel.city;
  DateTime get checkIn => date;
  double get price => hotel.price * nights;

  Booking copyWith({
    String? id,
    Hotel? hotel,
    DateTime? date,
    int? nights,
    int? guests,
    BookingStatus? status,
  }) {
    return Booking(
      id: id ?? this.id,
      hotel: hotel ?? this.hotel,
      date: date ?? this.date,
      nights: nights ?? this.nights,
      guests: guests ?? this.guests,
      status: status ?? this.status,
    );
  }
}
