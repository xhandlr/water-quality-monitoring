import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';


class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INFORMACIÓN DE LA CUENTA',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 28),
            _buildInfoItem(Icons.business, 'ORGANIZACIÓN', 'Planta de Tratamiento Principal'),
            const SizedBox(height: 32),
            _buildInfoItem(Icons.phone_outlined, 'TELÉFONO', '+51 987 654 321'),
            const SizedBox(height: 32),
            _buildInfoItem(Icons.email_outlined, 'CORREO ELECTRÓNICO', 'usuario@demo.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFEFF6FF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.accent, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
