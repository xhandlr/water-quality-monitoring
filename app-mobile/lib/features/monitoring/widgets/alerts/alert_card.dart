import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/alert.dart';
import '../../models/sensor_reading.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;
  final VoidCallback onTap;

  const AlertCard({
    super.key,
    required this.alert,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color severityColor;
    Color softColor;
    Color textColor;
    String statusText;
    IconData statusIcon;

    switch (alert.severity) {
      case SensorStatus.critical:
        severityColor = const Color(0xFFEF4444); // Red
        softColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFEF4444);
        statusText = 'CRÍTICO';
        statusIcon = Icons.warning_amber_rounded;
        break;
      case SensorStatus.warning:
        severityColor = const Color(0xFFF59E0B); // Orange
        softColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFDA790A);
        statusText = 'PRECAUCIÓN';
        statusIcon = Icons.info_outline_rounded;
        break;
      case SensorStatus.good:
        severityColor = const Color(0xFF84CC16); // Lime
        softColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF6DAD0D);
        statusText = 'NORMAL';
        statusIcon = Icons.check_circle_outline_rounded;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: severityColor,
                width: 6,
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icono
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: severityColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            statusIcon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Contenido
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.sensorName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                alert.message,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Valor
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${alert.value} ${alert.unit}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ),
                        // Estado
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: softColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('dd MMM, HH:mm').format(alert.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}