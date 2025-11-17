import 'dart:math';

import 'package:flutter/material.dart';

import '../../controllers/comparison_controller.dart';
import '../../core/localization/app_localizations.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key, required this.controller});

  final ComparisonController controller;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('comparison'))),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final hotels = controller.selected;
          if (hotels.isEmpty) {
            return Center(child: Text(t.translate('ai_info')));
          }
          final bestPrice = hotels.map((h) => h.price).reduce(min);
          final bestRating = hotels.map((h) => h.rating).reduce(max);
          final bestDistance = hotels.map((h) => h.distance).reduce(min);
          final bestReviews = hotels.map((h) => h.reviews).reduce(max);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: hotels
                  .map(
                    (hotel) => Container(
                      width: 240,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hotel.name, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 12),
                          _metricRow(
                            context,
                            t.translate('price'),
                            '${hotel.price.toStringAsFixed(0)} AED',
                            highlight: hotel.price == bestPrice,
                          ),
                          _metricRow(
                            context,
                            t.translate('rating'),
                            hotel.rating.toStringAsFixed(1),
                            highlight: hotel.rating == bestRating,
                          ),
                          _metricRow(
                            context,
                            t.translate('distance'),
                            '${hotel.distance} km',
                            highlight: hotel.distance == bestDistance,
                          ),
                          _metricRow(
                            context,
                            t.translate('reviews'),
                            hotel.reviews.toString(),
                            highlight: hotel.reviews == bestReviews,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            children: hotel.amenities.map((e) => Chip(label: Text(e))).toList(),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: () => controller.toggleHotel(hotel),
                            child: Text(t.translate('remove')),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _metricRow(BuildContext context, String title, String value, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: highlight ? Theme.of(context).colorScheme.primary.withOpacity(0.08) : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
