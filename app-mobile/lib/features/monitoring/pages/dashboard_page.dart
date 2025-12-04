import 'package:flutter/material.dart';
import '../models/sensor_reading.dart';
import '../widgets/sensor_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Simulación de datos - en producción vendría de la API
  List<SensorReading> _sensorReadings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }

  Future<void> _loadSensorData() async {
    // Simular carga de API
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _sensorReadings = [
        SensorReading(
          id: '1',
          name: 'pH',
          value: 7.2,
          unit: 'pH',
          status: SensorStatus.good,
          timestamp: DateTime.now(),
          icon: Icons.science,
          minThreshold: 6.5,
          maxThreshold: 8.5,
        ),
        SensorReading(
          id: '2',
          name: 'Temperatura',
          value: 28.5,
          unit: '°C',
          status: SensorStatus.warning,
          timestamp: DateTime.now(),
          icon: Icons.thermostat,
          minThreshold: 15.0,
          maxThreshold: 30.0,
        ),
        SensorReading(
          id: '4',
          name: 'Turbidez',
          value: 45.2,
          unit: 'NTU',
          status: SensorStatus.critical,
          timestamp: DateTime.now(),
          icon: Icons.water_drop,
          minThreshold: 0,
          maxThreshold: 50,
        ),
        SensorReading(
          id: '5',
          name: 'Conductividad',
          value: 520,
          unit: 'µS/cm',
          status: SensorStatus.good,
          timestamp: DateTime.now(),
          icon: Icons.electric_bolt,
          minThreshold: 200,
          maxThreshold: 800,
        ),
      ];
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    await _loadSensorData();
  }

  @override
  Widget build(BuildContext context) {
    final criticalCount = _sensorReadings
        .where((r) => r.status == SensorStatus.critical)
        .length;
    final warningCount = _sensorReadings
        .where((r) => r.status == SensorStatus.warning)
        .length;
    final goodCount = _sensorReadings
        .where((r) => r.status == SensorStatus.good)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoreo de Calidad del Agua'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/alerts');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: CustomScrollView(
                slivers: [
                  // Header con resumen de estado
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estado General del Sistema',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatusIndicator(
                                'Normal',
                                goodCount,
                                SensorStatus.good.color,
                                Icons.check_circle,
                              ),
                              _buildStatusIndicator(
                                'Precaución',
                                warningCount,
                                SensorStatus.warning.color,
                                Icons.warning,
                              ),
                              _buildStatusIndicator(
                                'Crítico',
                                criticalCount,
                                SensorStatus.critical.color,
                                Icons.error,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Grid de tarjetas de sensores
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final reading = _sensorReadings[index];
                          return SensorCard(
                            reading: reading,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/sensor-detail',
                                arguments: reading,
                              );
                            },
                          );
                        },
                        childCount: _sensorReadings.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatusIndicator(
    String label,
    int count,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
