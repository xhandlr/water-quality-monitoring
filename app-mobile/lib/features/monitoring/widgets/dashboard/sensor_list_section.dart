import 'package:flutter/material.dart';
import '../../models/sensor_reading.dart';
import '../sensor_card.dart';

class SensorListSection extends StatelessWidget {
  final List<SensorReading> readings;
  final Function(SensorReading) onSensorTap;

  const SensorListSection({
    super.key,
    required this.readings,
    required this.onSensorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Métricas en tiempo real',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: readings.length,
          itemBuilder: (context, index) {
            final reading = readings[index];
            return SensorCard(
              reading: reading,
              onTap: () => onSensorTap(reading),
            );
          },
        ),
      ],
    );
  }
}
