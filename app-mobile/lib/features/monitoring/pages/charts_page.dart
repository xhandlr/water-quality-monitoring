import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/filter_selector.dart';
import '../widgets/time_range_selector.dart';
import '../widgets/sensor_trend_chart.dart';

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
    'Temperatura',
    'Turbidez',
    'Conductividad',
  ];

  // Datos simulados para gráficos
  List<FlSpot> _generateChartData() {
    final List<FlSpot> spots = [];

    switch (_selectedRange) {
      case TimeRange.day24h:
        for (int i = 0; i < 24; i++) {
          spots.add(FlSpot(
            i.toDouble(),
            7.0 + (0.5 - (i % 3) * 0.2),
          ));
        }
        break;
      case TimeRange.days7:
        for (int i = 0; i < 7; i++) {
          spots.add(FlSpot(
            i.toDouble(),
            7.0 + (0.5 - (i % 2) * 0.3),
          ));
        }
        break;
      case TimeRange.days30:
        for (int i = 0; i < 30; i++) {
          spots.add(FlSpot(
            i.toDouble(),
            7.0 + (0.5 - (i % 4) * 0.2),
          ));
        }
        break;
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos de Tendencia'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Selector de sensor
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seleccionar Sensor',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
               FilterSelector(
                filters: _sensors, 
                selectedFilter: _selectedSensor, 
                onFilterSelected: (newSensor) {
                  setState(() {
                    _selectedSensor = newSensor;
                  });
                },
              ),
              ],
            ),
          ),

          // Selector de rango de tiempo
          TimeRangeSelector(
            selectedRange: _selectedRange,
            onRangeSelected: (newRange) {
              setState(() {
                _selectedRange = newRange;
              });
            },
          ),

          // Gráfico principal
          SensorTrendChart(
            sensorName: _selectedSensor,
            selectedRange: _selectedRange,
            dataPoints: _generateChartData(),
            unit: 'pH', // Esto debería ser dinámico según el sensor
          ),
        ],
      ),
    );
  }
}
