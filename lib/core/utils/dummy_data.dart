import 'package:flutter/material.dart';
import '../../models/booking.dart';
import '../../models/hotel.dart';
import '../../models/reward.dart';

List<Hotel> buildDummyHotels() {
  return [
    Hotel(
      id: 'h1',
      name: 'Palm Oasis Resort',
      city: 'Dubai',
      price: 220,
      rating: 4.7,
      distanceKm: 1.2,
      tags: const ['luxury', 'beach', 'family'],
      image: 'https://images.unsplash.com/photo-1501117716987-c8e1ecb210af',
      description: 'Soothing beachfront escape with curated dining.',
      amenities: const ['Pool', 'Spa', 'Gym', 'Wifi'],
    ),
    Hotel(
      id: 'h2',
      name: 'Desert Bloom Suites',
      city: 'Abu Dhabi',
      price: 140,
      rating: 4.3,
      distanceKm: 3.4,
      tags: const ['business', 'urban'],
      image: 'https://images.unsplash.com/photo-1501119990246-6c8744b3205e',
      description: 'City retreat close to the promenade with skyline views.',
      amenities: const ['Wifi', 'Parking', 'Lounge'],
    ),
    Hotel(
      id: 'h3',
      name: 'Olive Garden Hotel',
      city: 'Amman',
      price: 110,
      rating: 4.0,
      distanceKm: 2.6,
      tags: const ['budget', 'boutique'],
      image: 'https://images.unsplash.com/photo-1507679799987-c73779587ccf',
      description: 'Calm urban boutique with leafy terraces.',
      amenities: const ['Breakfast', 'Wifi'],
    ),
  ];
}

List<Booking> buildDummyBookings(List<Hotel> hotels) {
  if (hotels.length < 2) return [];
  return [
    Booking(
      id: 'b1',
      hotel: hotels[0],
      date: DateTime.now().add(const Duration(days: 5)),
      nights: 3,
      guests: 2,
    ),
    Booking(
      id: 'b2',
      hotel: hotels[1],
      date: DateTime.now().subtract(const Duration(days: 1)),
      nights: 2,
      guests: 1,
      status: BookingStatus.checkedIn,
    ),
    Booking(
      id: 'b3',
      hotel: hotels[1],
      date: DateTime.now().subtract(const Duration(days: 20)),
      nights: 2,
      guests: 1,
      status: BookingStatus.completed,
    ),
  ];
}

List<Reward> buildDummyRewards() {
  return [
    Reward(title: 'Spa voucher', points: 1200, description: 'Unwind with a 60-minute treatment'),
    Reward(title: 'Suite upgrade', points: 2600, description: 'Enjoy complimentary suite upgrades'),
    Reward(title: 'Late checkout', points: 800, description: 'Stay longer on your last day'),
  ];
}

List<Color> primaryChoices = const [
  Color(0xFF5B714A),
  Color(0xFF6A8F4E),
  Color(0xFF3A6B57),
  Color(0xFFB3A369),
];
