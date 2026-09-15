import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/plant.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    Color cardBg = Colors.white;
    Color borderColor = Colors.grey.shade200;
    Color statusColor = Colors.green;
    String statusText = 'В норме';

    if (plant.isWateringOverdue) {
      cardBg = const Color(0xFFFFF0F0);
      borderColor = Colors.red.shade300;
      statusColor = Colors.red;
      statusText = 'Просрочен полив!';
    } else if (plant.isWateringToday) {
      cardBg = const Color(0xFFFFF8E7);
      borderColor = Colors.orange.shade300;
      statusColor = Colors.orange.shade800;
      statusText = 'Полить сегодня';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: statusColor.withOpacity(0.12),
            child: Icon(Icons.eco, color: statusColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  plant.scientificName,
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.room, size: 12, color: Colors.grey.shade600),
                    const SizedBox(width: 2),
                    Text(plant.room, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                DateFormat('dd.MM.yyyy').format(plant.nextWateringDate),
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
