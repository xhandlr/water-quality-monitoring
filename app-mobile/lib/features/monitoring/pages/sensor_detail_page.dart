import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/config/theme.dart';
import '../../../core/services/mqtt_service.dart';
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
  late SensorReading _currentReading;
  final MqttService _mqttService = MqttService();

  @override
  void initState() {
    super.initState();
    _currentReading = widget.reading;
    _loadHistoricalData();
    _setupMqttAndListen();
  }

  Future<void> _setupMqttAndListen() async {
    try {
      await _mqttService.connect();
      _listenToMqtt();
    } catch (e) {
      debugPrint('Error conectando a MQTT en sensor detail: $e');
    }
  }

  void _listenToMqtt() {
    _mqttService.dataStream.listen((data) {
      if (!mounted) return;

      // Mapear el nombre del sensor a la clave del JSON (que viene en minúsculas)
      String? jsonKey;
      if (_currentReading.name == 'Flujo') jsonKey = 'flujo';
      if (_currentReading.name == 'pH') jsonKey = 'ph';
      if (_currentReading.name == 'Volumen') jsonKey = 'volumen';

      if (jsonKey != null && data.containsKey(jsonKey)) {
        final double newValue = (data[jsonKey] as num).toDouble();
        
        setState(() {
          // 1. Actualizar valor actual
          _currentReading = SensorReading(
            id: _currentReading.id,
            name: _currentReading.name,
            value: newValue,
            unit: _currentReading.unit,
            status: (newValue < _currentReading.minThreshold || newValue > _currentReading.maxThreshold) 
                ? SensorStatus.warning 
                : SensorStatus.good,
            timestamp: DateTime.now(),
            icon: _currentReading.icon,
            minThreshold: _currentReading.minThreshold,
            maxThreshold: _currentReading.maxThreshold,
            history: _currentReading.history,
          );

          // 2. Agregar punto al gráfico en tiempo real
          double xValue = _historicalData.isEmpty ? 0 : _historicalData.last.x + 1;
          _historicalData.add(FlSpot(xValue, newValue));
          
          // Mantener ventana de visualización (ej. últimos 20 puntos)
          if (_historicalData.length > 20) {
            _historicalData.removeAt(0);
          }
        });
      }
    });
  }

  Future<void> _loadHistoricalData() async {
    setState(() {
      _isLoading = true;
    });

    // Simular carga de datos históricos
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      // Si ya tenemos historial en el modelo, usarlo
      if (widget.reading.history.isNotEmpty) {
        _historicalData = widget.reading.history.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value);
        }).toList();
      } else {
        // Si no, iniciar con el valor actual
        _historicalData = [FlSpot(0, widget.reading.value)];
      }
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
          _currentReading.name,
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
            SensorHeaderCard(reading: _currentReading),
            const SizedBox(height: 24),
            SensorChartCard(
              reading: _currentReading,
              historicalData: _historicalData,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
            SensorStatsGrid(reading: _currentReading),
            const SizedBox(height: 24),
            SensorThresholdsCard(reading: _currentReading),
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

  @override
  void dispose() {
    _mqttService.dispose();
    super.dispose();
  }
}
