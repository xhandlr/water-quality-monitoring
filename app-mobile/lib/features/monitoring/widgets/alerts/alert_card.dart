import 'package:flutter/material.dart';
import '../../models/alert.dart';
import '../../models/sensor_reading.dart';
import 'alert_card_content.dart';
import 'alert_detail_modal.dart';

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
            color: Colors.black.withOpacity(0.05),
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
              onTap: () => _showAlertDialog(context, severityColor, statusIcon, statusText),
              child: AlertCardContent(
                alert: alert,
                severityColor: severityColor,
                softColor: softColor,
                textColor: textColor,
                statusText: statusText,
                statusIcon: statusIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, Color color, IconData icon, String status) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AlertDetailModal(
        alert: alert,
        color: color,
        icon: icon,
        status: status,
      ),
    );
  }
}