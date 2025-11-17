import 'package:flutter/material.dart';
import '../../controllers/comparison_controller.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key, required this.controller});
  final ComparisonController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          if (controller.selected.isEmpty) {
            return const Center(child: Text('No hotels selected'));
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.selected.map((hotel) {
                return Container(
                  width: 220,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(hotel.image, height: 120, fit: BoxFit.cover)),
                      const SizedBox(height: 8),
                      Text(hotel.name, style: Theme.of(context).textTheme.titleMedium),
                      Text('${hotel.price}\$/night'),
                      Text('Rating: ${hotel.rating}'),
                      Text('Distance: ${hotel.distanceKm} km'),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
