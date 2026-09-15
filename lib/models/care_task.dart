enum CareType {
  watering('Полив'),
  fertilizing('Подкормка'),
  spraying('Опрыскивание'),
  repotting('Пересадка');

  final String title;
  const CareType(this.title);
}

class CareTask {
  final String id;
  final String plantName;
  final CareType type;
  final DateTime dueDate;
  bool isCompleted;

  CareTask({
    required this.id,
    required this.plantName,
    required this.type,
    required this.dueDate,
    this.isCompleted = false,
  });
}
