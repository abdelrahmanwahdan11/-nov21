import 'package:flutter/material.dart';
import '../../controllers/bookings_controller.dart';
import '../../core/utils/dummy_data.dart';

class RewardsProfileTabScreen extends StatelessWidget {
  const RewardsProfileTabScreen({super.key, required this.bookingsController});
  final BookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    final rewards = buildDummyRewards();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rewards', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Points balance'),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: 0.4, minHeight: 10, borderRadius: BorderRadius.circular(12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Upcoming trips', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Expanded(
                child: AnimatedBuilder(
                  animation: bookingsController,
                  builder: (_, __) => ListView(
                    children: [
                      ...bookingsController.upcoming.map((b) => ListTile(title: Text(b.hotel.name), subtitle: Text('${b.nights} nights'))),
                      const SizedBox(height: 12),
                      const Text('Past'),
                      ...bookingsController.past.map((b) => ListTile(title: Text(b.hotel.name), subtitle: Text('Completed'))),
                    ],
                  ),
                ),
              ),
              Text('Reward options', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: rewards
                      .map((r) => Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r.title), Text('${r.points} pts')]),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
