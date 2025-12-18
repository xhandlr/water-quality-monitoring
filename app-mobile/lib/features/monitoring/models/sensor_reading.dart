import 'package:flutter/material.dart';

enum SensorStatus {
  good,
  warning,
  critical;

  Color get color {
    switch (this) {
      case SensorStatus.good:
        return const Color(0xFF4CAF50); // Verde
      case SensorStatus.warning:
        return const Color(0xFFFF9800); // Naranja
      case SensorStatus.critical:
        return const Color(0xFFF44336); // Rojo
    }
  }

  String get label {
    switch (this) {
      case SensorStatus.good:
        return 'Normal';
      case SensorStatus.warning:
        return 'Precaución';
      case SensorStatus.critical:
        return 'Crítico';
    }
  }
}

class SensorReading {
  final String id;
  final String name;
  final double value;
  final String unit;
  final SensorStatus status;
  final DateTime timestamp;
  final IconData icon;
  final double minThreshold;
  final double maxThreshold;
  final List<double> history;

  const SensorReading({
    required this.id,
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.timestamp,
    required this.icon,
    required this.minThreshold,
    required this.maxThreshold,
    this.history = const [],
  });

  String get formattedValue => '${value.toStringAsFixed(2)} $unit';

  String get statusText {
    switch (status) {
      case SensorStatus.good:
        return 'Normal';
      case SensorStatus.warning:
        return 'Precaución';
      case SensorStatus.critical:
        return 'Crítico';
    }
  }
}
