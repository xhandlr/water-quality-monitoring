import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido de nuevo,',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          Image.asset(
            'assets/icon/aurix_icon.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.water_drop,
                size: 32,
                color: AppColors.primary,
              );
            },
          ),
        ],
      ),
    );
  }
}