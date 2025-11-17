import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/utils/dummy_data.dart';
import '../../models/booking.dart';
import '../../models/reward.dart';

class RewardsProfileTabScreen extends StatelessWidget {
  RewardsProfileTabScreen({super.key});

  final List<Reward> rewards = generateRewards();
  final List<Booking> bookings = generateBookings();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildPointsCard(context),
        const SizedBox(height: 16),
        _buildMilestoneCard(context),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: Text(AppLocalizations.of(context).translate('see_rewards')),
        ),
        const SizedBox(height: 24),
        Text('Rewards', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...rewards.map((reward) => ListTile(
              title: Text(reward.title),
              subtitle: Text(reward.description),
              trailing: Text('${reward.points} pts'),
            )),
        const SizedBox(height: 24),
        Text('Bookings', style: Theme.of(context).textTheme.titleMedium),
        ...bookings.map((booking) => ListTile(
              title: Text(booking.hotelName),
              subtitle: Text('${booking.nights} nights · ${booking.date.toLocal().toString().split(' ').first}'),
              trailing: Text('${booking.price} AED'),
            )),
      ],
    );
  }

  Widget _buildPointsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Club member', style: TextStyle(color: Colors.white60)),
          SizedBox(height: 12),
          Text('24,800 pts', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Milestone to 100 nights'),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0.65,
            minHeight: 8,
            borderRadius: BorderRadius.circular(12),
          )
        ],
      ),
    );
  }
}
