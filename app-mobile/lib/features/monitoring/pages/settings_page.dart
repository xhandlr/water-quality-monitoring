import 'package:flutter/material.dart';

class ThresholdSetting {
  final String sensorId;
  final String sensorName;
  final IconData icon;
  double minWarning;
  double maxWarning;
  double minCritical;
  double maxCritical;
  final String unit;

  ThresholdSetting({
    required this.sensorId,
    required this.sensorName,
    required this.icon,
    required this.minWarning,
    required this.maxWarning,
    required this.minCritical,
    required this.maxCritical,
    required this.unit,
  });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<ThresholdSetting> _thresholds = [
    ThresholdSetting(
      sensorId: 'ph',
      sensorName: 'pH',
      icon: Icons.science,
      minWarning: 6.5,
      maxWarning: 8.5,
      minCritical: 6.0,
      maxCritical: 9.0,
      unit: 'pH',
    ),
    ThresholdSetting(
      sensorId: 'flow',
      sensorName: 'Flujo',
      icon: Icons.waves,
      minWarning: 15.0,
      maxWarning: 30.0,
      minCritical: 10.0,
      maxCritical: 35.0,
      unit: 'L/min',
    ),
    ThresholdSetting(
      sensorId: 'turbidity',
      sensorName: 'Turbidez',
      icon: Icons.water_drop,
      minWarning: 0,
      maxWarning: 50,
      minCritical: 0,
      maxCritical: 100,
      unit: 'NTU',
    ),
  ];

  bool _notificationsEnabled = true;
  bool _emailAlertsEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Umbrales'),
      ),
      body: ListView(
        children: [
          // Configuración de notificaciones
          _buildSection(
            'Notificaciones',
            [
              SwitchListTile(
                title: const Text('Notificaciones Push'),
                subtitle: const Text('Recibir alertas en el dispositivo'),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Alertas por Email'),
                subtitle: const Text('Enviar alertas al correo electrónico'),
                value: _emailAlertsEnabled,
                onChanged: (value) {
                  setState(() {
                    _emailAlertsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Sonido de Alerta'),
                subtitle: const Text('Reproducir sonido en alertas críticas'),
                value: _soundEnabled,
                onChanged: (value) {
                  setState(() {
                    _soundEnabled = value;
                  });
                },
              ),
            ],
          ),

          const Divider(height: 32),

          // Configuración de umbrales
          _buildSection(
            'Umbrales de Sensores',
            _thresholds.map((threshold) {
              return ExpansionTile(
                leading: Icon(threshold.icon, color: Theme.of(context).primaryColor),
                title: Text(
                  threshold.sensorName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Unidad: ${threshold.unit}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Umbrales de precaución
                        _buildThresholdControl(
                          'Precaución (Amarillo)',
                          Colors.orange,
                          threshold.minWarning,
                          threshold.maxWarning,
                          (minValue, maxValue) {
                            setState(() {
                              threshold.minWarning = minValue;
                              threshold.maxWarning = maxValue;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Umbrales críticos
                        _buildThresholdControl(
                          'Crítico (Rojo)',
                          Colors.red,
                          threshold.minCritical,
                          threshold.maxCritical,
                          (minValue, maxValue) {
                            setState(() {
                              threshold.minCritical = minValue;
                              threshold.maxCritical = maxValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _saveThreshold(threshold);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                          ),
                          child: const Text('Guardar Cambios'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildThresholdControl(
    String label,
    Color color,
    double minValue,
    double maxValue,
    Function(double, double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mínimo',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      hintText: minValue.toString(),
                    ),
                    onChanged: (value) {
                      final newMin = double.tryParse(value);
                      if (newMin != null) {
                        onChanged(newMin, maxValue);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Máximo',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      hintText: maxValue.toString(),
                    ),
                    onChanged: (value) {
                      final newMax = double.tryParse(value);
                      if (newMax != null) {
                        onChanged(minValue, newMax);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveThreshold(ThresholdSetting threshold) {
    // Aquí se guardarían los cambios en la API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Umbrales de ${threshold.sensorName} guardados'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
