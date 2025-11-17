import 'package:flutter/material.dart';

import '../../controllers/comparison_controller.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key, required this.controller});

  final ComparisonController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comparison')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final hotels = controller.selected;
          if (hotels.isEmpty) {
            return const Center(child: Text('Pick hotels to compare.'));
          }
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
                          _metricRow('Price', '${hotel.price.toStringAsFixed(0)} AED'),
                          _metricRow('Rating', hotel.rating.toStringAsFixed(1)),
                          _metricRow('Distance', '${hotel.distance} km'),
                          _metricRow('Reviews', hotel.reviews.toString()),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            children: hotel.amenities.map((e) => Chip(label: Text(e))).toList(),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: () => controller.toggleHotel(hotel),
                            child: const Text('Remove'),
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

  Widget _metricRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
