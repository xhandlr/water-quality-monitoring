import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aurix/core/config/theme.dart';
import '../widgets/charts/sensor_selector.dart';
import '../widgets/charts/time_range_selector.dart';
import '../widgets/charts/chart_card.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  TimeRange _selectedRange = TimeRange.day24h;
  String _selectedSensor = 'pH';

  final List<String> _sensors = [
    'pH',
    'Flujo',
    'Turbidez',
    'Conductividad',
  ];

  // Datos simulados para gráficos
  List<FlSpot> _generateChartData() {
    final List<FlSpot> spots = [];
    // Simulación simple de datos
    int points = _selectedRange == TimeRange.day24h ? 24 : (_selectedRange == TimeRange.days7 ? 7 : 30);
    
    for (int i = 0; i < points; i++) {
      // Generar valores aleatorios pero coherentes
      double baseValue = 7.0;
      if (_selectedSensor == 'Flujo') baseValue = 45.0;
      if (_selectedSensor == 'Turbidez') baseValue = 2.5;
      if (_selectedSensor == 'Conductividad') baseValue = 150.0;
      
      double noise = (i % 3 == 0 ? 0.5 : -0.3) + (i % 5 == 0 ? 0.2 : 0.0);
      spots.add(FlSpot(i.toDouble(), baseValue + noise));
    }
    return spots;
  }

  String _getUnit() {
    switch (_selectedSensor) {
      case 'pH': return 'pH';
      case 'Flujo': return 'L/min';
      case 'Turbidez': return 'NTU';
      case 'Conductividad': return 'µS/cm';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _generateChartData();
    // Calcular estadísticas simples
    double sum = 0;
    double max = double.negativeInfinity;
    double min = double.infinity;
    
    for (var spot in data) {
      sum += spot.y;
      if (spot.y > max) max = spot.y;
      if (spot.y < min) min = spot.y;
    }
    double average = sum / data.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
                child: Text(
                  'Tendencias',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              
              // Texto "Seleccionar sensor"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Seleccionar Sensor',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280), // Gray 500
                  ),
                ),
              ),

              const SizedBox(height: 12),
              
              // Selector de Sensor
              SensorSelector(
                sensors: _sensors,
                selectedSensor: _selectedSensor,
                onSensorSelected: (sensor) {
                  setState(() {
                    _selectedSensor = sensor;
                  });
                },
              ),
              
              const SizedBox(height: 8),
              
              // Selector de Rango de Tiempo
              TimeRangeSelector(
                selectedRange: _selectedRange,
                onRangeSelected: (range) {
                  setState(() {
                    _selectedRange = range;
                  });
                },
              ),
              
              // Gráfico y Estadísticas
              ChartCard(
                sensorName: _selectedSensor,
                unit: _getUnit(),
                dataPoints: data,
                average: average,
                max: max,
                min: min,
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
