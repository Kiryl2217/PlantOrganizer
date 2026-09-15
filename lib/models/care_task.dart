enum CareType { watering, fertilizing, spraying, repotting }

extension CareTypeExtension on CareType {
  String get title {
    switch (this) {
      case CareType.watering: return 'Полив';
      case CareType.fertilizing: return 'Подкормка';
      case CareType.spraying: return 'Опрыскивание';
      case CareType.repotting: return 'Пересадка';
    }
  }
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
