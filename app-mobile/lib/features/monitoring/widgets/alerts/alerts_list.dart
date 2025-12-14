import 'package:flutter/material.dart';
import '../../models/alert.dart';
import 'alert_card.dart';

class AlertsList extends StatelessWidget {
  final List<Alert> alerts;

  const AlertsList({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No hay alertas',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return AlertCard(
          alert: alert,
          onTap: () {}, // AlertCard handles the tap internally
        );
      },
    );
  }
}
