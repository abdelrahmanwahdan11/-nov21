import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/utils/dummy_data.dart';
import '../../models/reward.dart';

class RewardOptionsScreen extends StatelessWidget {
  RewardOptionsScreen({super.key});

  final List<Reward> rewards = buildDummyRewards();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('reward_options'))),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(reward.description),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Chip(label: Text('${reward.points} pts')),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text(t.translate('book_now'))),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: rewards.length,
      ),
    );
  }
}
