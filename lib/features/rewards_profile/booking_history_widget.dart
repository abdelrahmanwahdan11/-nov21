import 'package:flutter/material.dart';

import '../../controllers/bookings_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/booking.dart';

class BookingHistoryWidget extends StatelessWidget {
  const BookingHistoryWidget({super.key, required this.bookingsController});

  final BookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: bookingsController,
      builder: (context, _) {
        final upcoming = bookingsController.upcoming.toList();
        final past = bookingsController.past.toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (upcoming.isNotEmpty) _buildSection(context, t.translate('upcoming'), upcoming),
            if (past.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildSection(context, t.translate('past'), past),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Booking> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...data.map(
          (booking) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.hotelName, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${booking.nights} nights · ${booking.checkIn.toLocal().toString().split(' ').first}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text('${booking.guests} guests · ${booking.checkOut.toLocal().toString().split(' ').first}',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Chip(label: Text('${booking.price} AED')),
              ],
            ),
          ),
        )
      ],
    );
  }
}
