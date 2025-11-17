import 'package:flutter/material.dart';

import '../../controllers/bookings_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/booking.dart';
import '../../models/hotel.dart';
import 'hotel_detail_flip_card_widget.dart';
import 'hotel_image_overlay_widget.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key, required this.hotel, required this.bookingsController});

  final Hotel hotel;
  final BookingsController bookingsController;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  bool _overlayVisible = false;

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 320,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: hotel.id,
                    child: GestureDetector(
                      onTap: () => setState(() => _overlayVisible = true),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(hotel.image, fit: BoxFit.cover),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black54, Colors.transparent],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotel.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('${hotel.city} · ${hotel.distance} km · ⭐️${hotel.rating} (${hotel.reviews} reviews)'),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: hotel.amenities.map((a) => Chip(label: Text(a))).toList(),
                      ),
                      const SizedBox(height: 24),
                      Text(hotel.description),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => _openBookingSheet(context),
                        child: Text('${AppLocalizations.of(context).translate('book_now')} · ${hotel.price.toStringAsFixed(0)} AED'),
                      ),
                      const SizedBox(height: 24),
                      Text(AppLocalizations.of(context).translate('flip_insights')),
                      const SizedBox(height: 12),
                      HotelDetailFlipCardWidget(hotel: hotel),
                      const SizedBox(height: 24),
                      Text(AppLocalizations.of(context).translate('guest_reviews'),
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      _ReviewRow(hotel: hotel),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context).translate('gallery')),
                              content: SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(hotel.image, width: 200, fit: BoxFit.cover),
                                    ),
                                  ),
                                  itemCount: 3,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context).translate('videos_photos')),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          if (_overlayVisible)
            HotelImageOverlayWidget(
              hotel: hotel,
              onClose: () => setState(() => _overlayVisible = false),
            )
        ],
      ),
    );
  }

  void _openBookingSheet(BuildContext context) {
    final t = AppLocalizations.of(context);
    int guests = 2;
    int nights = 2;
    DateTime checkIn = DateTime.now().add(const Duration(days: 2));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        final total = widget.hotel.price * nights;
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(t.translate('booking_summary'), style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text(t.translate('check_in'))),
                  TextButton(
                    onPressed: () async {
                      final selected = await showDatePicker(
                        context: context,
                        initialDate: checkIn,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 180)),
                      );
                      if (selected != null) {
                        setState(() => checkIn = selected);
                      }
                    },
                    child: Text('${checkIn.toLocal().toString().split(' ').first}'),
                  )
                ],
              ),
              _StepperRow(
                label: t.translate('guests'),
                value: guests,
                onChanged: (v) => setState(() => guests = v.clamp(1, 6).toInt()),
              ),
              _StepperRow(
                label: t.translate('nights'),
                value: nights,
                onChanged: (v) => setState(() => nights = v.clamp(1, 14).toInt()),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('${t.translate('total')}: ', style: Theme.of(context).textTheme.titleMedium),
                  Text('${total.toStringAsFixed(0)} AED',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.bookingsController.addBooking(
                    Booking(
                      id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
                      hotelName: widget.hotel.name,
                      city: widget.hotel.city,
                      checkIn: checkIn,
                      nights: nights,
                      guests: guests,
                      price: total,
                      status: BookingStatus.upcoming,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.translate('booking_confirmed'))),
                  );
                },
                child: Text(t.translate('confirm_booking')),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({required this.label, required this.value, required this.onChanged});

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          IconButton(
            onPressed: () => onChanged(value - 1),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text('$value', style: Theme.of(context).textTheme.titleMedium),
          IconButton(
            onPressed: () => onChanged(value + 1),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.hotel});

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.reviews_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${hotel.rating} / 5 • ${hotel.reviews}'),
                const SizedBox(height: 4),
                Text(t.translate('review_highlight')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
