import 'package:flutter/material.dart';
import 'sensor_reading.dart';

class Alert {
  final String id;
  final String sensorName;
  final String message;
  final SensorStatus severity;
  final DateTime timestamp;
  final double value;
  final String unit;
  final bool isRead;

  const Alert({
    required this.id,
    required this.sensorName,
    required this.message,
    required this.severity,
    required this.timestamp,
    required this.value,
    required this.unit,
    this.isRead = false,
  });

  IconData get icon {
    switch (severity) {
      case SensorStatus.critical:
        return Icons.error;
      case SensorStatus.warning:
        return Icons.warning;
      case SensorStatus.good:
        return Icons.check_circle;
    }
  }
}
