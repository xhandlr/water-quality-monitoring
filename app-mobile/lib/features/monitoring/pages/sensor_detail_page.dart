import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/config/theme.dart';
import '../models/sensor_reading.dart';
import '../widgets/sensor_detail/sensor_header_card.dart';
import '../widgets/sensor_detail/sensor_chart_card.dart';
import '../widgets/sensor_detail/sensor_stats_grid.dart';
import '../widgets/sensor_detail/sensor_thresholds_card.dart';

class SensorDetailPage extends StatefulWidget {
  final SensorReading reading;

  const SensorDetailPage({
    super.key,
    required this.reading,
  });

  @override
  State<SensorDetailPage> createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends State<SensorDetailPage> {
  bool _isLoading = false;
  List<FlSpot> _historicalData = [];

  @override
  void initState() {
    super.initState();
    _loadHistoricalData();
  }

  Future<void> _loadHistoricalData() async {
    setState(() {
      _isLoading = true;
    });

    // Simular carga de datos históricos
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _historicalData = List.generate(24, (index) {
        return FlSpot(
          index.toDouble(),
          widget.reading.value + (index % 5 - 2) * 0.3,
        );
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.reading.name,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF1F2937)),
            onPressed: _shareReport,
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined, color: Color(0xFF1F2937)),
            onPressed: _downloadReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SensorHeaderCard(reading: widget.reading),
            const SizedBox(height: 24),
            SensorChartCard(
              reading: widget.reading,
              historicalData: _historicalData,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
            SensorStatsGrid(reading: widget.reading),
            const SizedBox(height: 24),
            SensorThresholdsCard(reading: widget.reading),
          ],
        ),
      ),
    );
  }

  void _shareReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compartiendo reporte...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _downloadReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Descargando reporte PDF...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
