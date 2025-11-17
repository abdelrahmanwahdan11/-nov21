import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/bookings_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/booking.dart';
import 'booking_detail_screen.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key, required this.bookingsController});

  final BookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('my_bookings'))),
      body: AnimatedBuilder(
        animation: bookingsController,
        builder: (context, _) {
          final upcoming = bookingsController.upcoming.toList();
          final past = bookingsController.past.toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionTitle(title: t.translate('upcoming_trips'), icon: IconlyBold.calendar),
              if (upcoming.isEmpty)
                _EmptyState(message: t.translate('no_upcoming'))
              else
                ...upcoming.map(
                  (b) => _TripCard(
                    booking: b,
                    bookingsController: bookingsController,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookingDetailScreen(
                          bookingId: b.id,
                          controller: bookingsController,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              _SectionTitle(title: t.translate('past_trips'), icon: IconlyBold.time_circle),
              if (past.isEmpty)
                _EmptyState(message: t.translate('no_history'))
              else
                ...past.map(
                  (b) => _TripCard(
                    booking: b,
                    bookingsController: bookingsController,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookingDetailScreen(
                          bookingId: b.id,
                          controller: bookingsController,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.booking, required this.bookingsController, this.onTap});

  final Booking booking;
  final BookingsController bookingsController;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final chipColor = _statusColor(context, booking.status);
    final nextSegment = booking.segments.where((s) => !s.done).toList();
    final nextStop = nextSegment.isNotEmpty ? nextSegment.first : null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
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
                  backgroundColor: chipColor.withOpacity(0.15),
                  labelStyle: TextStyle(color: chipColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(IconlyLight.calendar),
                const SizedBox(width: 8),
                Text('${booking.nights} ${t.translate('nights')} · ${booking.guests} ${t.translate('guests')}'),
                const Spacer(),
                Text('${booking.price.toStringAsFixed(0)} AED'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: booking.checklistProgress,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${(booking.checklistProgress * 100).round()}%'),
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
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(IconlyLight.time_circle),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: booking.itineraryProgress,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${(booking.itineraryProgress * 100).round()}%'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(IconlyLight.bag_2),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: booking.packingProgress,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${(booking.packingProgress * 100).round()}%'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(IconlyLight.wallet),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: booking.budgetProgress.clamp(0, 1).toDouble(),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(12),
                        color: booking.budgetProgress > 1
                            ? Colors.redAccent
                            : Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 4),
                      Text('${t.translate('spent')}: ${booking.budgetSpent.toStringAsFixed(0)} / ${booking.budgetPlanned.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            if (nextStop != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(IconlyLight.paper),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('${t.translate('next_step')}: ${nextStop.title} • ${nextStop.time}'),
                  ),
                ],
              )
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(
                  onPressed: booking.status == BookingStatus.upcoming ? () => bookingsController.checkIn(booking.id) : null,
                  child: Text(t.translate('check_in')),
                ),
                TextButton(
                  onPressed: booking.status == BookingStatus.checkedIn ? () => bookingsController.complete(booking.id) : null,
                  child: Text(t.translate('check_out')),
                ),
                const Spacer(),
                IconButton(
                  onPressed: booking.status == BookingStatus.upcoming ? () => bookingsController.cancel(booking.id) : null,
                  icon: const Icon(Icons.cancel_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context, BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return Theme.of(context).colorScheme.primary;
      case BookingStatus.checkedIn:
        return Colors.orange;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.redAccent;
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(IconlyLight.info_circle),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
