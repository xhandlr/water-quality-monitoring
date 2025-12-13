import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartCard extends StatelessWidget {
  final String sensorName;
  final String unit;
  final List<FlSpot> dataPoints;
  final double average;
  final double max;
  final double min;

  const ChartCard({
    super.key,
    required this.sensorName,
    required this.unit,
    required this.dataPoints,
    required this.average,
    required this.max,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sensorName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Light green
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'NORMAL',
                  style: TextStyle(
                    color: Color(0xFF10B981), // Green
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Chart
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: dataPoints.first.x,
                maxX: dataPoints.last.x,
                minY: min * 0.9,
                maxY: max * 1.1,
                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints,
                    isCurved: true,
                    color: const Color(0xFF009EE3), // Celeste del sistema
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF009EE3).withOpacity(0.3),
                          const Color(0xFF009EE3).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard('PROMEDIO', average),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('MÁXIMO', max),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('MÍNIMO', min),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, double value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Gray almost white
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
