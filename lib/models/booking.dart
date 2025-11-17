class Booking {
  const Booking({
    required this.id,
    required this.hotelName,
    required this.date,
    required this.nights,
    required this.price,
  });

  final String id;
  final String hotelName;
  final DateTime date;
  final int nights;
  final double price;
}
