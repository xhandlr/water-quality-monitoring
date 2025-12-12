import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import '../pages/devices_page.dart'; // For Device model

class DeviceConfigModal extends StatelessWidget {
  final Device device;

  const DeviceConfigModal({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = device.isActive ? AppColors.deviceOnline : AppColors.deviceOffline;
    final statusBg = device.isActive ? AppColors.deviceOnlineBg : AppColors.deviceOfflineBg;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.router,
                  color: statusColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      device.location,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (device.isActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.deviceBadgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Activo',
                    style: TextStyle(
                      color: AppColors.deviceBadgeText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Opciones de configuración',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Editar nombre'),
            onTap: () {
              Navigator.pop(context);
              // Implementar edición
            },
          ),
          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text('Configurar red WiFi'),
            onTap: () {
              Navigator.pop(context);
              // Implementar config WiFi
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Eliminar dispositivo', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              // Implementar eliminación
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
