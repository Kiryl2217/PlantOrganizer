import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/care_task.dart';
import '../models/plant.dart';
import '../viewmodels/plant_list_viewmodel.dart';
import 'components/calendar_strip.dart';
import 'components/plant_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PlantListViewModel viewModel = PlantListViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: AppBar(
        title: const Text('Органайзер растений', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: viewModel.setSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Поиск растения или комнаты...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Интерактивный календарь процедур',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            CalendarStrip(
              selectedDate: viewModel.selectedDate,
              onDateSelected: viewModel.selectDate,
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'План на ${DateFormat('dd MMMM', 'ru').format(viewModel.selectedDate)}:',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  if (viewModel.tasksForSelectedDate.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('На этот день процедур нет', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    )
                  else
                    ...viewModel.tasksForSelectedDate.map((task) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            task.type == CareType.watering ? Icons.water_drop : Icons.spa,
                            color: Colors.green,
                          ),
                          title: Text(
                            '${task.type.title}: ${task.plantName}',
                            style: TextStyle(
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: task.isCompleted ? Colors.green : Colors.grey,
                            ),
                            onPressed: () => viewModel.toggleTask(task.id),
                          ),
                        )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Каталог растений', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('${viewModel.filteredPlants.length} шт.', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            ...viewModel.filteredPlants.map((plant) => PlantCard(plant: plant)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
