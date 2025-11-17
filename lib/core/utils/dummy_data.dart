import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/booking.dart';
import '../../models/chat_message.dart';
import '../../models/hotel.dart';
import '../../models/reward.dart';

final _random = Random(42);

List<Hotel> generateHotels() {
  const images = [
    'https://images.unsplash.com/photo-1501117716987-c8e1ecb210cc',
    'https://images.unsplash.com/photo-1445019980597-93fa8acb246c',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
    'https://images.unsplash.com/photo-1505693314120-0d443867891c',
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
  ];
  final List<Hotel> hotels = [];
  for (var i = 0; i < 25; i++) {
    final price = 120 + _random.nextInt(200);
    final rating = 3 + _random.nextDouble() * 2;
    final distance = 0.5 + _random.nextDouble() * 8;
    hotels.add(
      Hotel(
        id: 'hotel_$i',
        name: 'Serenity ${i + 1}',
        city: ['Dubai', 'Cairo', 'Riyadh', 'Beirut'][i % 4],
        price: price.toDouble(),
        rating: double.parse(rating.toStringAsFixed(1)),
        distance: double.parse(distance.toStringAsFixed(1)),
        tags: ['spa', 'family', 'business', 'beach', 'suites']..shuffle(),
        type: ['Premium', 'Essential', 'Luxury', 'Suites'][i % 4],
        image: images[i % images.length],
        description:
            'Thoughtfully curated spaces with calming earthy palettes, smart concierge and AI powered itineraries for every stay.',
        amenities: const [
          'Free breakfast',
          'Wellness spa',
          '24h concierge',
          'Airport shuttle',
          'Smart room service',
        ],
        reviews: 120 + _random.nextInt(600),
      ),
    );
  }
  return hotels;
}

List<Booking> generateBookings() => List.generate(
      4,
      (index) => Booking(
        id: 'book_$index',
        hotelName: 'Serenity ${index + 2}',
        date: index.isEven
            ? DateTime.now().add(Duration(days: 6 * (index + 1)))
            : DateTime.now().subtract(Duration(days: 10 * (index + 1))),
        nights: 2 + index,
        price: 150 + index * 40,
      ),
    );

List<Reward> generateRewards() => const [
      Reward(
        title: 'Spa escape',
        description: '2 complimentary treatments in our partner resorts.',
        points: 400,
      ),
      Reward(
        title: 'Suite upgrade',
        description: 'Upgrade to panoramic sky suites for one night.',
        points: 800,
      ),
    ];

List<ChatMessage> initialMessages() => const [
      ChatMessage(
        id: 'm1',
        text: 'Hi! I am Roamify AI. Ready to design a soulful stay for you.',
        sentAt: DateTime(2024, 1, 1, 12, 0),
        sender: SenderType.bot,
      ),
      ChatMessage(
        id: 'm2',
        text: 'Ask me for premium picks or compare suites instantly.',
        sentAt: DateTime(2024, 1, 1, 12, 1),
        sender: SenderType.bot,
      ),
    ];

Color lighten(Color color) {
  final hsl = HSLColor.fromColor(color);
  final light = hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0));
  return light.toColor();
}
