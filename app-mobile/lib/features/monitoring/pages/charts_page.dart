import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/sensor_reading.dart';

enum TimeRange {
  day24h('Últimas 24 horas'),
  days7('Últimos 7 días'),
  days30('Últimos 30 días');

  final String label;
  const TimeRange(this.label);
}

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
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seleccionar Sensor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sensors.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final sensor = _sensors[index];
                      final isSelected = sensor == _selectedSensor;
                      return FilterChip(
                        selected: isSelected,
                        label: Text(sensor),
                        onSelected: (selected) {
                          setState(() {
                            _selectedSensor = sensor;
                          });
                        },
                        backgroundColor: Colors.white.withOpacity(0.2),
                        selectedColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Selector de rango de tiempo
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: TimeRange.values.map((range) {
                final isSelected = range == _selectedRange;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Center(
                        child: Text(
                          range.label,
                          style: const TextStyle(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedRange = range;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Gráfico principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedSensor,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: SensorStatus.good.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Normal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              horizontalInterval: 1,
                              verticalInterval: 1,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.grey.withOpacity(0.2),
                                  strokeWidth: 1,
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: Colors.grey.withOpacity(0.2),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  interval: _selectedRange == TimeRange.day24h
                                      ? 4
                                      : _selectedRange == TimeRange.days7
                                          ? 1
                                          : 5,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 0.5,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    return Text(
                                      value.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                  reservedSize: 42,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                            minX: 0,
                            maxX: _selectedRange == TimeRange.day24h
                                ? 23
                                : _selectedRange == TimeRange.days7
                                    ? 6
                                    : 29,
                            minY: 5,
                            maxY: 9,
                            lineBarsData: [
                              LineChartBarData(
                                spots: _generateChartData(),
                                isCurved: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).primaryColor.withOpacity(0.5),
                                  ],
                                ),
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3),
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.0),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Estadísticas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Promedio', '7.2', Icons.analytics),
                          _buildStatItem('Máximo', '7.5', Icons.arrow_upward),
                          _buildStatItem('Mínimo', '6.8', Icons.arrow_downward),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
