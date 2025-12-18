import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import '../../models/sensor_reading.dart';

class SystemStatusCard extends StatelessWidget {
  final List<SensorReading> readings;

  const SystemStatusCard({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    final criticalCount = readings.where((r) => r.status == SensorStatus.critical).length;
    final warningCount = readings.where((r) => r.status == SensorStatus.warning).length;
    final goodCount = readings.where((r) => r.status == SensorStatus.good).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientMiddle.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estado del Sistema',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.tagBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.tagBorder),
                ),
                child: const Text(
                  'Tiempo real',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusIndicator('NORMAL', goodCount, AppColors.statusNormalIcon,
                  AppColors.statusNormalDashboardBg, Icons.check_circle_outline),
              Container(height: 40, width: 1, color: AppColors.white.withValues(alpha: 0.1)),
              _buildStatusIndicator('ALERTA', warningCount, AppColors.statusWarningIcon,
                  AppColors.statusWarningDashboardBg, Icons.warning_amber_rounded),
              Container(height: 40, width: 1, color: AppColors.white.withValues(alpha: 0.1)),
              _buildStatusIndicator('CRITICO', criticalCount, AppColors.statusCriticalIcon,
                  AppColors.statusCriticalDashboardBg, Icons.error_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(
    String label,
    int count,
    Color iconColor,
    Color backgroundColor,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 10,
              color: AppColors.white.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}