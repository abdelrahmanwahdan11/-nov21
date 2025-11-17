import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/utils/dummy_data.dart';
import '../../models/booking.dart';
import '../../models/reward.dart';
import 'booking_history_widget.dart';
import 'reward_options_screen.dart';

class RewardsProfileTabScreen extends StatelessWidget {
  RewardsProfileTabScreen({super.key});

  final List<Reward> rewards = generateRewards();
  final List<Booking> bookings = generateBookings();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildPointsCard(context),
        const SizedBox(height: 16),
        _buildMilestoneCard(context),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => RewardOptionsScreen()),
          ),
          child: Text(t.translate('see_rewards')),
        ),
        const SizedBox(height: 24),
        Text(t.translate('rewards_section'), style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...rewards.map((reward) => ListTile(
              title: Text(reward.title),
              subtitle: Text(reward.description),
              trailing: Text('${reward.points} pts'),
            )),
        const SizedBox(height: 24),
        Text(t.translate('booking_history'), style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        BookingHistoryWidget(bookings: bookings),
      ],
    );
  }

  Widget _buildPointsCard(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate('club_member'), style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 12),
          const Text('24,800 pts', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate('milestone_title')),
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
