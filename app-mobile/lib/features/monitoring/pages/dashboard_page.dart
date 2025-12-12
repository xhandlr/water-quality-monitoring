import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import '../models/sensor_reading.dart';
import '../widgets/dashboard/sensor_card.dart';

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
          icon: Icons.science_outlined,
          minThreshold: 6.5,
          maxThreshold: 8.5,
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
          id: '2',
          name: 'Flujo',
          value: 28.5,
          unit: 'L/min',
          status: SensorStatus.warning,
          timestamp: DateTime.now(),
          icon: Icons.waves,
          minThreshold: 15.0,
          maxThreshold: 30.0,
        ),
        SensorReading(
          id: '5',
          name: 'Conductividad',
          value: 520,
          unit: 'µS/cm',
          status: SensorStatus.good,
          timestamp: DateTime.now(),
          icon: Icons.bolt,
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
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _refreshData,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
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
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadow,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Header con resumen de estado
                  SliverToBoxAdapter(
                    child: Container(
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.tagBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.tagBorder,
                                  ),
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
                              _buildStatusIndicator(
                                'NORMAL',
                                goodCount,
                                AppColors.statusNormalIcon,
                                AppColors.statusNormalDashboardBg,
                                Icons.check_circle_outline,
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: AppColors.white.withValues(alpha: 0.1),
                              ),
                              _buildStatusIndicator(
                                'ALERTA',
                                warningCount,
                                AppColors.statusWarningIcon,
                                AppColors.statusWarningDashboardBg,
                                Icons.warning_amber_rounded,
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: AppColors.white.withValues(alpha: 0.1),
                              ),
                              _buildStatusIndicator(
                                'CRITICO',
                                criticalCount,
                                AppColors.statusCriticalIcon,
                                AppColors.statusCriticalDashboardBg,
                                Icons.error_outline,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Grid de tarjetas de sensores
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Métricas en tiempo real',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.white.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
