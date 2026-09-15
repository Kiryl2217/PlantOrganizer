import 'package:flutter/foundation.dart';
import '../models/plant.dart';
import '../models/care_task.dart';

class PlantListViewModel extends ChangeNotifier {
  List<Plant> _plants = [];
  List<CareTask> _tasks = [];
  DateTime _selectedDate = DateTime.now();
  String _searchQuery = '';

  List<Plant> get plants => _plants;
  DateTime get selectedDate => _selectedDate;
  String get searchQuery => _searchQuery;

  PlantListViewModel() {
    _loadInitialData();
  }

  List<Plant> get filteredPlants {
    if (_searchQuery.trim().isEmpty) return _plants;
    return _plants.where((p) =>
      p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      p.room.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  List<CareTask> get tasksForSelectedDate {
    return _tasks.where((t) =>
      t.dueDate.year == _selectedDate.year &&
      t.dueDate.month == _selectedDate.month &&
      t.dueDate.day == _selectedDate.day
    ).toList();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void _loadInitialData() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final inTwoDays = today.add(const Duration(days: 2));

    _plants = [
      Plant(
        id: '1',
        name: 'Монстера Деликатесная',
        scientificName: 'Monstera Deliciosa',
        room: 'Гостиная',
        nextWateringDate: yesterday,
        wateringIntervalDays: 5,
      ),
      Plant(
        id: '2',
        name: 'Фикус Бенджамина',
        scientificName: 'Ficus Benjamina',
        room: 'Спальня',
        nextWateringDate: today,
        wateringIntervalDays: 3,
      ),
      Plant(
        id: '3',
        name: 'Сансевиерия',
        scientificName: 'Sansevieria Trifasciata',
        room: 'Кабинет',
        nextWateringDate: inTwoDays,
        wateringIntervalDays: 14,
      ),
    ];

    _tasks = [
      CareTask(id: 't1', plantName: 'Монстера', type: CareType.watering, dueDate: yesterday),
      CareTask(id: 't2', plantName: 'Фикус', type: CareType.watering, dueDate: today),
      CareTask(id: 't3', plantName: 'Фикус', type: CareType.spraying, dueDate: today, isCompleted: true),
      CareTask(id: 't4', plantName: 'Сансевиерия', type: CareType.fertilizing, dueDate: inTwoDays),
    ];
    notifyListeners();
  }
}
