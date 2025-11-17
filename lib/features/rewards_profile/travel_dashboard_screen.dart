import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/bookings_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/booking.dart';

class TravelDashboardScreen extends StatelessWidget {
  const TravelDashboardScreen({super.key, required this.controller});

  final BookingsController controller;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('readiness_hub'))),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final avgReadiness = controller.averageActiveReadiness;
          final nextTrip = controller.nextTrip;
          final pendingAlerts = _pendingAlerts(controller);
          final cityCounts = controller.cityVisitCounts.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));
          final timeline = [...controller.all]..sort((a, b) => a.checkIn.compareTo(b.checkIn));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _StatCard(
                    label: t.translate('active_trips'),
                    value: (controller.upcoming.length + controller.inHouse.length).toString(),
                    icon: IconlyBold.calendar,
                  ),
                  _StatCard(
                    label: t.translate('completed_trips'),
                    value: controller.past.length.toString(),
                    icon: IconlyBold.time_circle,
                  ),
                  _StatCard(
                    label: t.translate('open_tasks'),
                    value: controller.openTasksCount.toString(),
                    icon: IconlyBold.tick_square,
                  ),
                  _StatCard(
                    label: t.translate('pending_alerts_short'),
                    value: controller.pendingAlertsCount.toString(),
                    icon: IconlyBold.shield,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _ReadinessGauge(avgReadiness: avgReadiness, documents: controller.documentsCompletion),
              const SizedBox(height: 16),
              if (nextTrip != null) _NextTripCard(booking: nextTrip),
              const SizedBox(height: 16),
              _CitiesWrap(cityCounts: cityCounts),
              const SizedBox(height: 16),
              _AlertsList(t: t, pendingAlerts: pendingAlerts, controller: controller),
              const SizedBox(height: 16),
              Text(t.translate('travel_timeline'), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...timeline.map((b) => _TimelineCard(booking: b)),
            ],
          );
        },
      ),
    );
  }

  List<_AlertBundle> _pendingAlerts(BookingsController controller) {
    final items = <_AlertBundle>[];
    for (final booking in controller.all) {
      for (final alert in booking.alerts.where((a) => !a.acknowledged)) {
        items.add(_AlertBundle(booking, alert));
      }
    }
    return items;
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(height: 12),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ReadinessGauge extends StatelessWidget {
  const _ReadinessGauge({required this.avgReadiness, required this.documents});

  final double avgReadiness;
  final double documents;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final readinessPercent = (avgReadiness.clamp(0, 1) * 100).round();
    final docsPercent = (documents.clamp(0, 1) * 100).round();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: avgReadiness.clamp(0, 1).toDouble(),
                  strokeWidth: 10,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$readinessPercent%', style: Theme.of(context).textTheme.titleLarge),
                      Text(t.translate('overall_readiness')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.translate('readiness_overview'), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(IconlyLight.document),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: documents.clamp(0, 1).toDouble(),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('$docsPercent%'),
                  ],
                ),
                const SizedBox(height: 6),
                Text(t.translate('docs_progress'), style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NextTripCard extends StatelessWidget {
  const _NextTripCard({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final daysToGo = booking.checkIn.difference(DateTime.now()).inDays;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(IconlyLight.paper),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.translate('next_trip'), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('${booking.hotelName} · ${booking.city}'),
                const SizedBox(height: 6),
                Text('${booking.nights} ${t.translate('nights')} · ${booking.guests} ${t.translate('guests')}'),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$daysToGo ${t.translate('days_to_go')}'),
              const SizedBox(height: 6),
              Text('${(booking.readinessScore * 100).round()}%',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          )
        ],
      ),
    );
  }
}

class _CitiesWrap extends StatelessWidget {
  const _CitiesWrap({required this.cityCounts});

  final List<MapEntry<String, int>> cityCounts;

  @override
  Widget build(BuildContext context) {
    if (cityCounts.isEmpty) return const SizedBox.shrink();
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.translate('city_focus'), style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: cityCounts
              .map(
                (entry) => Chip(
                  label: Text('${entry.key} · ${entry.value}'),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _AlertsList extends StatelessWidget {
  const _AlertsList({required this.t, required this.pendingAlerts, required this.controller});

  final AppLocalizations t;
  final List<_AlertBundle> pendingAlerts;
  final BookingsController controller;

  @override
  Widget build(BuildContext context) {
    if (pendingAlerts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(IconlyLight.shield_done),
            const SizedBox(width: 12),
            Expanded(child: Text(t.translate('no_alerts'))),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.translate('safety_alerts'), style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...pendingAlerts.map(
          (alert) => Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(IconlyLight.shield_done),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(alert.alert.title, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text(alert.booking.hotelName, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => controller.toggleAlert(alert.booking.id, alert.alert.title),
                  child: Text(t.translate('acknowledge')),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.hotelName, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('${booking.city} · ${booking.checkIn.toLocal().toString().split(' ').first}'),
                  ],
                ),
              ),
              Chip(
                label: Text(t.translate(booking.status.name)),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(IconlyLight.time_circle),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: booking.readinessScore.clamp(0, 1).toDouble(),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 8),
              Text('${(booking.readinessScore * 100).round()}%'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(IconlyLight.document),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: booking.docsProgress,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 8),
              Text('${(booking.docsProgress * 100).round()}%'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertBundle {
  _AlertBundle(this.booking, this.alert);

  final Booking booking;
  final TravelAlert alert;
}
