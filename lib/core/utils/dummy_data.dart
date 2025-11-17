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
    Hotel(
      id: 'h4',
      name: 'Marina Vista Tower',
      city: 'Doha',
      price: 185,
      rating: 4.5,
      distanceKm: 4.4,
      tags: const ['business', 'skyline'],
      image: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511',
      description: 'High-rise views with executive lounge perks.',
      amenities: const ['Wifi', 'Gym', 'Executive lounge'],
    ),
    Hotel(
      id: 'h5',
      name: 'Lagoon Breeze Villas',
      city: 'Muscat',
      price: 260,
      rating: 4.8,
      distanceKm: 6.1,
      tags: const ['luxury', 'spa', 'family'],
      image: 'https://images.unsplash.com/photo-1505761671935-60b3a7427bad',
      description: 'Private villas set on tranquil lagoons with hammam spa.',
      amenities: const ['Pool', 'Spa', 'Kids club', 'Wifi'],
    ),
    Hotel(
      id: 'h6',
      name: 'Dune Edge Camp',
      city: 'Riyadh',
      price: 170,
      rating: 4.2,
      distanceKm: 8.0,
      tags: const ['desert', 'adventure', 'boutique'],
      image: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      description: 'Immersive desert glamping with stargazing decks.',
      amenities: const ['Breakfast', 'Guided tours', 'Wifi'],
    ),
  ];
}

List<Booking> buildDummyBookings(List<Hotel> hotels) {
  if (hotels.length < 3) return [];
  return [
    Booking(
      id: 'b1',
      hotel: hotels[0],
      date: DateTime.now().add(const Duration(days: 5)),
      nights: 3,
      guests: 2,
      confirmationCode: '#RFM-1823',
      roomType: 'Premier Gulf View',
      perks: const ['Late checkout', 'Club lounge access'],
      transport: 'Complimentary airport pickup',
      pointsEarned: 480,
    ),
    Booking(
      id: 'b2',
      hotel: hotels[1],
      date: DateTime.now().subtract(const Duration(days: 1)),
      nights: 2,
      guests: 1,
      status: BookingStatus.checkedIn,
      confirmationCode: '#DBS-3341',
      roomType: 'Executive Studio',
      perks: const ['Breakfast included'],
      transport: 'Ride-share credit ready',
      pointsEarned: 260,
    ),
    Booking(
      id: 'b3',
      hotel: hotels[2],
      date: DateTime.now().subtract(const Duration(days: 20)),
      nights: 2,
      guests: 1,
      status: BookingStatus.completed,
      confirmationCode: '#OGH-1120',
      roomType: 'Garden Deluxe',
      perks: const ['Welcome drink', 'Free wifi'],
      transport: 'Metro stop 3 mins walk',
      note: 'Quiet room requested',
      isRefundable: false,
      pointsEarned: 180,
    ),
  ];
}

List<Reward> buildDummyRewards() {
  return [
    Reward(title: 'Spa voucher', points: 1200, description: 'Unwind with a 60-minute treatment'),
    Reward(title: 'Suite upgrade', points: 2600, description: 'Enjoy complimentary suite upgrades'),
    Reward(title: 'Late checkout', points: 800, description: 'Stay longer on your last day'),
    Reward(title: 'Airport transfer', points: 950, description: 'Round-trip transfer in a luxury sedan'),
  ];
}

List<Color> primaryChoices = const [
  Color(0xFF5B714A),
  Color(0xFF6A8F4E),
  Color(0xFF3A6B57),
  Color(0xFFB3A369),
];
