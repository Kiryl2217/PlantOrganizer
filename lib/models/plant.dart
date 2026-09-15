class Plant {
  final String id;
  final String name;
  final String scientificName;
  final String room;
  final DateTime nextWateringDate;
  final int wateringIntervalDays;

  Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.room,
    required this.nextWateringDate,
    required this.wateringIntervalDays,
  });

  bool get isWateringOverdue {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final wateringDay = DateTime(nextWateringDate.year, nextWateringDate.month, nextWateringDate.day);
    return wateringDay.isBefore(today);
  }

  bool get isWateringToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final wateringDay = DateTime(nextWateringDate.year, nextWateringDate.month, nextWateringDate.day);
    return wateringDay.isAtSameMomentAs(today);
  }
}
