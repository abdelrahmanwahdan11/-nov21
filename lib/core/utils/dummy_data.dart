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
      packing: const [
        PackingItem(title: 'Smart casual outfits'),
        PackingItem(title: 'Swimming gear', packed: true),
        PackingItem(title: 'Camera batteries'),
        PackingItem(title: 'Gift for concierge', detail: 'Small chocolate box'),
      ],
      budgets: const [
        TripBudget(category: 'Dining', planned: 800, spent: 150),
        TripBudget(category: 'Transport', planned: 250, spent: 80),
        TripBudget(category: 'Activities', planned: 900, spent: 120),
      ],
      tasks: const [
        TripTask(title: 'Confirm airport pickup'),
        TripTask(title: 'Share arrival time with hotel'),
        TripTask(title: 'Add pillow preference', done: true),
      ],
      documents: const [
        TravelDocument(title: 'Passport copy', ready: true),
        TravelDocument(title: 'Visa PDF'),
        TravelDocument(title: 'Vaccination card', ready: true),
      ],
      journal: [
        TripJournalEntry(
          title: 'Spa booking confirmed',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          detail: 'Reserved couples massage at 6 PM on day 2.',
        ),
      ],
      segments: const [
        TripSegment(
          title: 'Airport pickup',
          time: 'Day 1 · 3:00 PM',
          note: 'Driver meets at arrivals gate 6',
        ),
        TripSegment(
          title: 'Check-in & welcome drink',
          time: 'Day 1 · 4:00 PM',
          note: 'Ask for high floor Gulf view',
        ),
        TripSegment(
          title: 'Sunset dinner',
          time: 'Day 1 · 7:30 PM',
          note: 'Book terrace table',
        ),
        TripSegment(
          title: 'Pool morning',
          time: 'Day 2 · 10:00 AM',
          done: true,
          note: 'Use spa access after swim',
        ),
      ],
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
      packing: const [
        PackingItem(title: 'Business attire', packed: true),
        PackingItem(title: 'Laptop & charger', packed: true),
        PackingItem(title: 'Noise cancelling headphones'),
      ],
      budgets: const [
        TripBudget(category: 'Dining', planned: 400, spent: 220),
        TripBudget(category: 'Transport', planned: 160, spent: 60),
        TripBudget(category: 'Tips', planned: 120, spent: 40),
      ],
      tasks: const [
        TripTask(title: 'Upload passport copy', done: true),
        TripTask(title: 'Request quiet room'),
        TripTask(title: 'Add late checkout request'),
      ],
      documents: const [
        TravelDocument(title: 'Boarding pass', ready: true),
        TravelDocument(title: 'Work permit letter'),
      ],
      journal: [
        TripJournalEntry(
          title: 'Checked in via app',
          createdAt: DateTime.now().subtract(const Duration(hours: 6)),
          detail: 'Mobile key ready at 4 PM.',
        ),
      ],
      segments: const [
        TripSegment(
          title: 'Client meeting',
          time: 'Day 1 · 11:00 AM',
          done: true,
          note: 'Boardroom level 12',
        ),
        TripSegment(
          title: 'Gym & recovery',
          time: 'Day 1 · 6:00 PM',
          note: 'Steam room booking',
        ),
        TripSegment(
          title: 'Check-out ride',
          time: 'Day 2 · 4:00 PM',
          note: 'Use ride-share credit',
        ),
      ],
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
      packing: const [
        PackingItem(title: 'Light jacket', packed: true),
        PackingItem(title: 'Reusable bottle', packed: true),
        PackingItem(title: 'Portable wifi'),
      ],
      budgets: const [
        TripBudget(category: 'Dining', planned: 500, spent: 480),
        TripBudget(category: 'Gifts', planned: 200, spent: 140),
        TripBudget(category: 'Transport', planned: 180, spent: 160),
      ],
      tasks: const [
        TripTask(title: 'Review stay notes', done: true),
        TripTask(title: 'Add loyalty number', done: true),
        TripTask(title: 'Share checkout feedback', done: true),
      ],
      documents: const [
        TravelDocument(title: 'Passport copy', ready: true),
        TravelDocument(title: 'Metro card reload', ready: true),
      ],
      journal: [
        TripJournalEntry(
          title: 'Great rooftop breakfast',
          createdAt: DateTime.now().subtract(const Duration(days: 18)),
          detail: 'Ask for corner table, best sunrise view.',
        ),
        TripJournalEntry(
          title: 'Late checkout approved',
          createdAt: DateTime.now().subtract(const Duration(days: 17)),
        ),
      ],
      segments: const [
        TripSegment(
          title: 'Rooftop coffee',
          time: 'Day 1 · 9:00 AM',
          done: true,
          note: 'Try local roast',
        ),
        TripSegment(
          title: 'Souq walk',
          time: 'Day 1 · 2:00 PM',
          done: true,
          note: 'Pick up spices',
        ),
        TripSegment(
          title: 'Checkout',
          time: 'Day 2 · 12:00 PM',
          done: true,
        ),
      ],
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
