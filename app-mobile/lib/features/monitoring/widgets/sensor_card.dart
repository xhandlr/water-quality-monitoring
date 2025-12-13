import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import '../models/sensor_reading.dart';

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
    // Definir colores según el estado
    Color iconColor;
    Color iconBgColor;
    Color iconBorderColor;

    // Override para Turbidez si es crítico
    if (reading.name == 'Turbidez' && reading.status == SensorStatus.critical) {
      iconColor = AppColors.turbidezCritical;
      iconBgColor = AppColors.statusCriticalBg;
      iconBorderColor = AppColors.statusCriticalBorder;
    } else if (reading.name == 'Conductividad') {
      iconColor = AppColors.conductivityIcon;
      iconBgColor = AppColors.conductivityBg;
      iconBorderColor = AppColors.conductivityBorder;
    } else if (reading.name == 'Flujo') {
      iconColor = AppColors.flowIcon;
      iconBgColor = AppColors.flowBg;
      iconBorderColor = AppColors.flowBorder;
    } else {
      switch (reading.status) {
        case SensorStatus.good:
          iconColor = AppColors.statusNormalIcon;
          iconBgColor = AppColors.statusNormalBg;
          iconBorderColor = AppColors.statusNormalBorder;
          break;
        case SensorStatus.warning:
          iconColor = AppColors.statusWarningIcon;
          iconBgColor = AppColors.statusWarningBg;
          iconBorderColor = AppColors.statusWarningBorder;
          break;
        case SensorStatus.critical:
          iconColor = AppColors.statusCriticalIcon;
          iconBgColor = AppColors.statusCriticalBg;
          iconBorderColor = AppColors.statusCriticalBorder;
          break;
      }
    }

    return Card(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.transparent, // Evitar tinte grisáceo en M3
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppColors.tagBorder,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: iconBorderColor),
                    ),
                    child: Icon(
                      reading.icon,
                      color: iconColor,
                      size: 28,
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Gráfico simple de historial
              SizedBox(
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(12, (index) {
                    // Simulación de datos históricos
                    final height = 4.0 + (index * index * 37 % 16);
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: iconColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                reading.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: reading.value.toString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextSpan(
                      text: ' ${reading.unit}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
