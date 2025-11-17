import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/bookings_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/booking.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key, required this.bookingId, required this.controller});

  final String bookingId;
  final BookingsController controller;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final booking = controller.all.firstWhere((b) => b.id == bookingId);
        final isRtl = Directionality.of(context) == TextDirection.rtl;
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    SizedBox(
                      height: 280,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Hero(
                              tag: booking.id,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                                child: Image.network(
                                  booking.hotel.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 16,
                            child: _CircleButton(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(booking.hotelName, style: Theme.of(context).textTheme.headlineSmall),
                                    const SizedBox(height: 6),
                                    Text('${booking.city} • ${booking.roomType}'),
                                  ],
                                ),
                              ),
                              Chip(
                                label: Text(t.translate(booking.status.name)),
                                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(IconlyLight.calendar, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                '${t.translate('check_in')}: ${booking.checkIn.toLocal().toString().split(' ').first}\n${t.translate('check_out')}: ${booking.checkOut.toLocal().toString().split(' ').first}',
                              ),
                              const Spacer(),
                              Text('${booking.price.toStringAsFixed(0)} AED'),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _Pill(text: '${booking.nights} ${t.translate('nights')}'),
                              _Pill(text: '${booking.guests} ${t.translate('guests')}'),
                              _Pill(text: booking.isRefundable ? t.translate('refundable') : t.translate('non_refundable')),
                              _Pill(text: booking.transport),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _SectionTitle(title: t.translate('confirmation_code')),
                          const SizedBox(height: 8),
                          _InfoTile(icon: IconlyLight.document, label: booking.confirmationCode),
                          const SizedBox(height: 16),
                          _SectionTitle(title: t.translate('perks')),
                          const SizedBox(height: 8),
                          Column(
                            children: booking.perks
                                .map((perk) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6.0),
                                      child: _InfoTile(icon: Icons.star_border_rounded, label: perk),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          _SectionTitle(title: t.translate('timeline')),
                          const SizedBox(height: 8),
                          _Timeline(
                            items: [
                              _TimelineItem(
                                title: t.translate('check_in'),
                                subtitle: booking.checkIn.toLocal().toString().split(' ').first,
                                icon: IconlyLight.calendar,
                                isDone: booking.status != BookingStatus.upcoming,
                              ),
                              _TimelineItem(
                                title: t.translate('check_out'),
                                subtitle: booking.checkOut.toLocal().toString().split(' ').first,
                                icon: IconlyLight.time_circle,
                                isDone: booking.status == BookingStatus.completed,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        _SectionTitle(title: t.translate('trip_preparation')),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: booking.checklistProgress,
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text('${(booking.checklistProgress * 100).round()}%'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ...booking.tasks.map(
                                (task) => CheckboxListTile(
                                  value: task.done,
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(task.title),
                                  onChanged: (_) => controller.toggleTask(booking.id, task.title),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => controller.completeChecklist(booking.id),
                                  child: Text(t.translate('complete_all')),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SectionTitle(title: t.translate('travel_documents')),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: booking.docsProgress,
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text('${(booking.docsProgress * 100).round()}%'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ...booking.documents.map(
                                (doc) => SwitchListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(doc.title),
                                  subtitle: doc.detail != null ? Text(doc.detail!) : null,
                                  value: doc.ready,
                                  onChanged: (_) => controller.toggleDocument(booking.id, doc.title),
                                ),
                              ),
                              if (booking.documents.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(t.translate('docs_progress')),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SectionTitle(title: t.translate('journal')),
                        const SizedBox(height: 8),
                        if (booking.journal.isEmpty)
                          _InfoTile(
                            icon: IconlyLight.paper,
                            label: t.translate('journal_empty'),
                            trailing: IconButton(
                              icon: const Icon(IconlyLight.plus),
                              onPressed: () => _openJournalSheet(context, booking),
                            ),
                          )
                        else
                          Column(
                            children: [
                              ...booking.journal.map((entry) => _JournalTile(entry: entry)),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () => _openJournalSheet(context, booking),
                                  icon: const Icon(IconlyLight.plus),
                                  label: Text(t.translate('add_entry')),
                                ),
                              )
                            ],
                          ),
                        const SizedBox(height: 16),
                        _SectionTitle(title: t.translate('notes')),
                        const SizedBox(height: 8),
                        _InfoTile(
                          icon: IconlyLight.chat,
                          label: booking.note?.isNotEmpty == true ? booking.note! : t.translate('add_note'),
                          trailing: IconButton(
                            icon: const Icon(IconlyLight.edit),
                            onPressed: () => _openNoteSheet(context, booking),
                          ),
                        ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                const Icon(IconlyLight.ticket),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(t.translate('points_earned'), style: Theme.of(context).textTheme.titleMedium),
                                      Text(t.translate('points_earned_desc')),
                                    ],
                                  ),
                                ),
                                Text('+${booking.pointsEarned}'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _ActionRow(
                            booking: booking,
                            controller: controller,
                            isRtl: isRtl,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openNoteSheet(BuildContext context, Booking booking) {
    final controllerField = TextEditingController(text: booking.note);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final t = AppLocalizations.of(context);
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.translate('add_note'), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(
                controller: controllerField,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: t.translate('notes_hint'),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    controller.addNote(booking.id, controllerField.text.trim());
                    Navigator.of(context).pop();
                  },
                  child: Text(t.translate('save')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openJournalSheet(BuildContext context, Booking booking) {
    final controllerField = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final t = AppLocalizations.of(context);
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.translate('add_entry'), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(
                controller: controllerField,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: t.translate('entry_hint'),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (controllerField.text.trim().isEmpty) return;
                    controller.addJournalEntry(
                      booking.id,
                      TripJournalEntry(title: controllerField.text.trim(), createdAt: DateTime.now()),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(t.translate('save')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(text),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.label, this.trailing});

  final IconData icon;
  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(label)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _JournalTile extends StatelessWidget {
  const _JournalTile({required this.entry});

  final TripJournalEntry entry;

  @override
  Widget build(BuildContext context) {
    final dateLabel = entry.createdAt.toLocal().toString().split(' ').first;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(IconlyLight.document),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title, style: Theme.of(context).textTheme.titleSmall),
                if (entry.detail != null) ...[
                  const SizedBox(height: 4),
                  Text(entry.detail!),
                ],
                const SizedBox(height: 4),
                Text(dateLabel, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.items});

  final List<_TimelineItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _Dot(done: items[i].isDone),
                  if (i < items.length - 1)
                    Container(
                      width: 2,
                      height: 40,
                      color: items[i].isDone ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Icon(items[i].icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items[i].title, style: Theme.of(context).textTheme.titleSmall),
                    Text(items[i].subtitle),
                  ],
                ),
              ),
            ],
          ),
          if (i < items.length - 1) const SizedBox(height: 8),
        ]
      ],
    );
  }
}

class _TimelineItem {
  _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDone = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDone;
}

class _Dot extends StatelessWidget {
  const _Dot({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: done ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.booking, required this.controller, required this.isRtl});

  final Booking booking;
  final BookingsController controller;
  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: booking.status == BookingStatus.upcoming
                ? () => controller.checkIn(booking.id)
                : booking.status == BookingStatus.checkedIn
                    ? () => controller.complete(booking.id)
                    : null,
            icon: Icon(isRtl ? IconlyBold.login : IconlyBold.logout),
            label: Text(
              booking.status == BookingStatus.checkedIn ? t.translate('check_out') : t.translate('check_in'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: booking.status == BookingStatus.upcoming ? () => controller.cancel(booking.id) : null,
            icon: const Icon(IconlyLight.close_square),
            label: Text(t.translate('cancel')),
          ),
        ),
      ],
    );
  }
}
