enum BookingStatus { upcoming, checkedIn, completed, cancelled }

class Booking {
  const Booking({
    required this.id,
    required this.hotelName,
    required this.city,
    required this.checkIn,
    required this.nights,
    required this.guests,
    required this.price,
    required this.status,
  });

  final String id;
  final String hotelName;
  final String city;
  final DateTime checkIn;
  final int nights;
  final int guests;
  final double price;
  final BookingStatus status;

  DateTime get checkOut => checkIn.add(Duration(days: nights));

  Booking copyWith({BookingStatus? status}) {
    return Booking(
      id: id,
      hotelName: hotelName,
      city: city,
      checkIn: checkIn,
      nights: nights,
      guests: guests,
      price: price,
      status: status ?? this.status,
    );
  }
}
