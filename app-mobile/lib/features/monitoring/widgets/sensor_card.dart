import 'package:flutter/material.dart';
import '../models/sensor_reading.dart';
import 'package:intl/intl.dart';

class SensorCard extends StatelessWidget {
  final SensorReading reading;
  final VoidCallback? onTap;

  const SensorCard({
    super.key,
    required this.reading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: reading.status.color.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: reading.status.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      reading.icon,
                      color: reading.status.color,
                      size: 22,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: reading.status.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reading.statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                reading.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  reading.formattedValue,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: reading.status.color,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 12,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      DateFormat('HH:mm').format(reading.timestamp),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: (reading.value - reading.minThreshold) /
                    (reading.maxThreshold - reading.minThreshold),
                backgroundColor: Colors.grey[200],
                color: reading.status.color,
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Min: ${reading.minThreshold}',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Max: ${reading.maxThreshold}',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
