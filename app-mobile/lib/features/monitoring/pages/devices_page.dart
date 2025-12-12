import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import '../widgets/device_card.dart';
import '../widgets/device_config_modal.dart';
import '../widgets/add_device_dialog.dart';

class Device {
  final String id;
  final String name;
  final String location;
  final bool isActive;
  final DateTime lastSync;

  const Device({
    required this.id,
    required this.name,
    required this.location,
    required this.isActive,
    required this.lastSync,
  });
}

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  String? _selectedDeviceId;

  List<Device> get _devices {
    final now = DateTime.now();
    return [
      Device(
        id: '1',
        name: 'Aurix Monitor 001',
        location: 'Planta Principal - Sector A',
        isActive: true,
        lastSync: now.subtract(const Duration(minutes: 2)),
      ),
      Device(
        id: '2',
        name: 'Aurix Monitor 002',
        location: 'Planta Principal - Sector B',
        isActive: true,
        lastSync: now.subtract(const Duration(minutes: 5)),
      ),
      Device(
        id: '3',
        name: 'Aurix Monitor 003',
        location: 'Planta Secundaria',
        isActive: false,
        lastSync: now.subtract(const Duration(hours: 2)),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _selectedDeviceId = _devices.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mis dispositivos',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: AppColors.white),
                      onPressed: _showAddDeviceDialog,
                      tooltip: 'Agregar dispositivo',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final device = _devices[index];
                  final isSelected = device.id == _selectedDeviceId;

                  return DeviceCard(
                    device: device,
                    isSelected: isSelected,
                    onConfigTap: () => _showConfigDeviceDialog(device),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _showConfigDeviceDialog(Device device) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DeviceConfigModal(device: device),
    );
  }

  void _showAddDeviceDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddDeviceDialog(),
    );
  }
}
