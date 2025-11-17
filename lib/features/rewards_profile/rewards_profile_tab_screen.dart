import 'package:flutter/material.dart';
import '../../controllers/bookings_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/dummy_data.dart';
import '../home/favorites_screen.dart';
import 'my_trips_screen.dart';
import 'reward_options_screen.dart';

class RewardsProfileTabScreen extends StatelessWidget {
  const RewardsProfileTabScreen({super.key, required this.bookingsController, required this.hotelsController});
  final BookingsController bookingsController;
  final HotelsController hotelsController;

  @override
  Widget build(BuildContext context) {
    final rewards = buildDummyRewards();
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.translate('rewards'), style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.translate('points_balance')),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: 0.4, minHeight: 10, borderRadius: BorderRadius.circular(12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _QuickActions(t: t, bookingsController: bookingsController, hotelsController: hotelsController),
              const SizedBox(height: 12),
              Expanded(
                child: AnimatedBuilder(
                  animation: bookingsController,
                  builder: (_, __) {
                    final upcoming = bookingsController.upcoming;
                    final inHouse = bookingsController.inHouse;
                    final past = bookingsController.past;
                    return ListView(
                      children: [
                        Text(t.translate('upcoming_trips'), style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        if (upcoming.isEmpty)
                          Text(t.translate('no_upcoming'))
                        else
                          ...upcoming.map((b) => ListTile(
                                title: Text(b.hotel.name),
                                subtitle: Text('${b.nights} ${t.translate('nights')}'),
                              )),
                        if (inHouse.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(t.translate('checkedIn'), style: Theme.of(context).textTheme.titleMedium),
                          ...inHouse.map((b) => ListTile(
                                title: Text(b.hotel.name),
                                subtitle: Text('${b.nights} ${t.translate('nights')}'),
                              )),
                        ],
                        const SizedBox(height: 12),
                        Text(t.translate('past_trips'), style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        if (past.isEmpty)
                          Text(t.translate('no_history'))
                        else
                          ...past.map((b) => ListTile(
                                title: Text(b.hotel.name),
                                subtitle: Text(t.translate(b.status.name)),
                              )),
                        const SizedBox(height: 16),
                        Text(t.translate('reward_options'), style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: rewards
                                .map((r) => Container(
                                      width: 200,
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(r.title, style: Theme.of(context).textTheme.titleMedium),
                                          const SizedBox(height: 6),
                                          Text(r.description),
                                          const Spacer(),
                                          Text('${r.points} pts'),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.t, required this.bookingsController, required this.hotelsController});

  final AppLocalizations t;
  final BookingsController bookingsController;
  final HotelsController hotelsController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            label: t.translate('open_favorites'),
            icon: Icons.favorite_border,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FavoritesScreen(
                  hotelsController: hotelsController,
                  bookingsController: bookingsController,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionCard(
            label: t.translate('open_bookings'),
            icon: Icons.route,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MyTripsScreen(bookingsController: bookingsController))),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionCard(
            label: t.translate('open_rewards'),
            icon: Icons.card_giftcard,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RewardOptionsScreen())),
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const Spacer(),
            Text(label, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
