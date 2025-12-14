import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/alert.dart';

class AlertCardContent extends StatelessWidget {
  final Alert alert;
  final Color severityColor;
  final Color softColor;
  final Color textColor;
  final String statusText;
  final IconData statusIcon;

  const AlertCardContent({
    super.key,
    required this.alert,
    required this.severityColor,
    required this.softColor,
    required this.textColor,
    required this.statusText,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          alert.sensorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900, // Extra bold
                            color: Colors.black, // Pure black
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: softColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w300, // Light weight
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
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
            ],
          ),
        ],
      ),
    );
  }
}
