import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/bookings_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/dummy_data.dart';
import '../../models/reward.dart';

class RewardsWalletScreen extends StatelessWidget {
  const RewardsWalletScreen({super.key, required this.bookingsController});

  final BookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    final rewards = buildDummyRewards();
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('wallet'))),
      body: AnimatedBuilder(
        animation: bookingsController,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(IconlyBold.ticket),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.translate('points_balance'), style: Theme.of(context).textTheme.titleMedium),
                            Text('${bookingsController.pointsBalance} pts'),
                          ],
                        ),
                        const Spacer(),
                        Text(t.translate('rewards_wallet_hint')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: (bookingsController.pointsBalance % 3000) / 3000,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(t.translate('reward_options'), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...rewards.map((reward) => _RewardCard(reward: reward, onRedeem: () => _redeem(context, reward))),
            ],
          );
        },
      ),
    );
  }

  void _redeem(BuildContext context, Reward reward) {
    final t = AppLocalizations.of(context);
    final success = bookingsController.redeemPoints(reward.points);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? t.translate('redeemed') : t.translate('insufficient_points')),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({required this.reward, required this.onRedeem});

  final Reward reward;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(reward.description),
                const SizedBox(height: 6),
                Text('${reward.points} pts'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onRedeem,
            child: Text(t.translate('redeem')),
          ),
        ],
      ),
    );
  }
}
