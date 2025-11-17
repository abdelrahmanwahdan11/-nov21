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
    this.confirmationCode = '',
    this.roomType = 'Deluxe',
    this.perks = const [],
    this.transport = 'Airport pickup included',
    this.note,
    this.isRefundable = true,
    this.pointsEarned = 0,
  });

  final String id;
  final Hotel hotel;
  final DateTime date;
  final int nights;
  final int guests;
  final BookingStatus status;
  final String confirmationCode;
  final String roomType;
  final List<String> perks;
  final String transport;
  final String? note;
  final bool isRefundable;
  final int pointsEarned;

  String get hotelName => hotel.name;
  String get city => hotel.city;
  DateTime get checkIn => date;
  DateTime get checkOut => date.add(Duration(days: nights));
  double get price => hotel.price * nights;

  Booking copyWith({
    String? id,
    Hotel? hotel,
    DateTime? date,
    int? nights,
    int? guests,
    BookingStatus? status,
    String? confirmationCode,
    String? roomType,
    List<String>? perks,
    String? transport,
    String? note,
    bool? isRefundable,
    int? pointsEarned,
  }) {
    return Booking(
      id: id ?? this.id,
      hotel: hotel ?? this.hotel,
      date: date ?? this.date,
      nights: nights ?? this.nights,
      guests: guests ?? this.guests,
      status: status ?? this.status,
      confirmationCode: confirmationCode ?? this.confirmationCode,
      roomType: roomType ?? this.roomType,
      perks: perks ?? this.perks,
      transport: transport ?? this.transport,
      note: note ?? this.note,
      isRefundable: isRefundable ?? this.isRefundable,
      pointsEarned: pointsEarned ?? this.pointsEarned,
    );
  }
}
