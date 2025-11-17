import 'hotel.dart';

enum BookingStatus { upcoming, checkedIn, completed, cancelled }

class Booking {
  Booking({
    required this.id,
    required this.hotel,
    required this.date,
    required this.nights,
    required this.guests,
    this.status = BookingStatus.upcoming,
    this.confirmationCode = '',
    this.roomType = 'Deluxe',
    this.perks = const [],
    this.transport = 'Airport pickup included',
    this.note,
    this.isRefundable = true,
    this.pointsEarned = 0,
    this.tasks = const [],
    this.documents = const [],
    this.journal = const [],
    this.segments = const [],
    this.packing = const [],
    this.budgets = const [],
    this.transfers = const [],
    this.dining = const [],
    this.alerts = const [],
    this.tips = const [],
  });

  final String id;
  final Hotel hotel;
  final DateTime date;
  final int nights;
  final int guests;
  final BookingStatus status;
  final String confirmationCode;
  final String roomType;
  final List<String> perks;
  final String transport;
  final String? note;
  final bool isRefundable;
  final int pointsEarned;
  final List<TripTask> tasks;
  final List<TravelDocument> documents;
  final List<TripJournalEntry> journal;
  final List<TripSegment> segments;
  final List<PackingItem> packing;
  final List<TripBudget> budgets;
  final List<TransferPlan> transfers;
  final List<DiningReservation> dining;
  final List<TravelAlert> alerts;
  final List<CityGuideTip> tips;

  String get hotelName => hotel.name;
  String get city => hotel.city;
  DateTime get checkIn => date;
  DateTime get checkOut => date.add(Duration(days: nights));
  double get price => hotel.price * nights;
  double get checklistProgress => tasks.isEmpty
      ? 1
      : tasks.where((task) => task.done).length / tasks.length;
  double get docsProgress => documents.isEmpty
      ? 1
      : documents.where((doc) => doc.ready).length / documents.length;
  double get itineraryProgress => segments.isEmpty
      ? 1
      : segments.where((seg) => seg.done).length / segments.length;
  double get packingProgress => packing.isEmpty
      ? 1
      : packing.where((item) => item.packed).length / packing.length;
  double get budgetPlanned => budgets.fold(0, (sum, b) => sum + b.planned);
  double get budgetSpent => budgets.fold(0, (sum, b) => sum + b.spent);
  double get budgetProgress => budgetPlanned == 0 ? 0 : budgetSpent / budgetPlanned;
  double get transferProgress => transfers.isEmpty
      ? 1
      : transfers.where((transfer) => transfer.confirmed).length / transfers.length;
  double get diningProgress =>
      dining.isEmpty ? 1 : dining.where((res) => res.confirmed).length / dining.length;
  double get alertsProgress => alerts.isEmpty
      ? 1
      : alerts.where((alert) => alert.acknowledged).length / alerts.length;
  double get readinessScore {
    final pieces = [
      checklistProgress,
      docsProgress,
      itineraryProgress,
      packingProgress,
      transferProgress,
      diningProgress,
      alertsProgress,
    ];
    return pieces.reduce((a, b) => a + b) / pieces.length;
  }

  Booking copyWith({
    String? id,
    Hotel? hotel,
    DateTime? date,
    int? nights,
    int? guests,
    BookingStatus? status,
    String? confirmationCode,
    String? roomType,
    List<String>? perks,
    String? transport,
    String? note,
    bool? isRefundable,
    int? pointsEarned,
    List<TripTask>? tasks,
    List<TravelDocument>? documents,
    List<TripJournalEntry>? journal,
    List<TripSegment>? segments,
    List<PackingItem>? packing,
    List<TripBudget>? budgets,
    List<TransferPlan>? transfers,
    List<DiningReservation>? dining,
    List<TravelAlert>? alerts,
    List<CityGuideTip>? tips,
  }) {
    return Booking(
      id: id ?? this.id,
      hotel: hotel ?? this.hotel,
      date: date ?? this.date,
      nights: nights ?? this.nights,
      guests: guests ?? this.guests,
      status: status ?? this.status,
      confirmationCode: confirmationCode ?? this.confirmationCode,
      roomType: roomType ?? this.roomType,
      perks: perks ?? this.perks,
      transport: transport ?? this.transport,
      note: note ?? this.note,
      isRefundable: isRefundable ?? this.isRefundable,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      tasks: tasks ?? this.tasks,
      documents: documents ?? this.documents,
      journal: journal ?? this.journal,
      segments: segments ?? this.segments,
      packing: packing ?? this.packing,
      budgets: budgets ?? this.budgets,
      transfers: transfers ?? this.transfers,
      dining: dining ?? this.dining,
      alerts: alerts ?? this.alerts,
      tips: tips ?? this.tips,
    );
  }
}

class TravelAlert {
  const TravelAlert({
    required this.title,
    required this.severity,
    this.detail,
    this.acknowledged = false,
  });

  final String title;
  final String severity;
  final String? detail;
  final bool acknowledged;

  TravelAlert copyWith({String? title, String? severity, String? detail, bool? acknowledged}) {
    return TravelAlert(
      title: title ?? this.title,
      severity: severity ?? this.severity,
      detail: detail ?? this.detail,
      acknowledged: acknowledged ?? this.acknowledged,
    );
  }
}

class CityGuideTip {
  const CityGuideTip({required this.title, required this.category, this.detail});

  final String title;
  final String category;
  final String? detail;
}

class TripTask {
  const TripTask({required this.title, this.done = false});

  final String title;
  final bool done;

  TripTask copyWith({String? title, bool? done}) {
    return TripTask(
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
}

class TransferPlan {
  const TransferPlan({
    required this.title,
    required this.time,
    this.contact,
    this.note,
    this.confirmed = false,
  });

  final String title;
  final String time;
  final String? contact;
  final String? note;
  final bool confirmed;

  TransferPlan copyWith({String? title, String? time, String? contact, String? note, bool? confirmed}) {
    return TransferPlan(
      title: title ?? this.title,
      time: time ?? this.time,
      contact: contact ?? this.contact,
      note: note ?? this.note,
      confirmed: confirmed ?? this.confirmed,
    );
  }
}

class DiningReservation {
  const DiningReservation({
    required this.venue,
    required this.time,
    this.note,
    this.confirmed = false,
  });

  final String venue;
  final String time;
  final String? note;
  final bool confirmed;

  DiningReservation copyWith({String? venue, String? time, String? note, bool? confirmed}) {
    return DiningReservation(
      venue: venue ?? this.venue,
      time: time ?? this.time,
      note: note ?? this.note,
      confirmed: confirmed ?? this.confirmed,
    );
  }
}

class TravelDocument {
  const TravelDocument({required this.title, this.ready = false, this.detail});

  final String title;
  final bool ready;
  final String? detail;

  TravelDocument copyWith({String? title, bool? ready, String? detail}) {
    return TravelDocument(
      title: title ?? this.title,
      ready: ready ?? this.ready,
      detail: detail ?? this.detail,
    );
  }
}

class TripJournalEntry {
  const TripJournalEntry({required this.title, required this.createdAt, this.detail});

  final String title;
  final DateTime createdAt;
  final String? detail;

  TripJournalEntry copyWith({String? title, DateTime? createdAt, String? detail}) {
    return TripJournalEntry(
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      detail: detail ?? this.detail,
    );
  }
}

class TripSegment {
  const TripSegment({required this.title, required this.time, this.note, this.done = false});

  final String title;
  final String time;
  final String? note;
  final bool done;

  TripSegment copyWith({String? title, String? time, String? note, bool? done}) {
    return TripSegment(
      title: title ?? this.title,
      time: time ?? this.time,
      note: note ?? this.note,
      done: done ?? this.done,
    );
  }
}

class PackingItem {
  const PackingItem({required this.title, this.packed = false, this.detail});

  final String title;
  final bool packed;
  final String? detail;

  PackingItem copyWith({String? title, bool? packed, String? detail}) {
    return PackingItem(
      title: title ?? this.title,
      packed: packed ?? this.packed,
      detail: detail ?? this.detail,
    );
  }
}

class TripBudget {
  const TripBudget({required this.category, required this.planned, this.spent = 0, this.note});

  final String category;
  final double planned;
  final double spent;
  final String? note;

  double get remaining => (planned - spent).clamp(0, planned);

  TripBudget copyWith({String? category, double? planned, double? spent, String? note}) {
    return TripBudget(
      category: category ?? this.category,
      planned: planned ?? this.planned,
      spent: spent ?? this.spent,
      note: note ?? this.note,
    );
  }
}
