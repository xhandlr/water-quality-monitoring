import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/services/mqtt_service.dart';
import '../models/sensor_reading.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/system_status_card.dart';
import '../widgets/dashboard/sensor_list_section.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final MqttService _mqttService = MqttService();
  List<SensorReading> _sensorReadings = [];
  bool _isLoading = true;
  StreamSubscription? _mqttSubscription;
  String _debugStatus = "Iniciando..."; // Variable para ver logs en pantalla

  @override
  void initState() {
    super.initState();
    _initializeDashboard();
  }

  Future<void> _initializeDashboard() async {
    await _loadSensorData();
    await _setupMqttConnection();
  }

  Future<void> _setupMqttConnection() async {
    try {
      if (mounted) setState(() => _debugStatus = "Conectando a MQTT...");
      // IMPORTANTE: Escuchar antes de conectar para capturar mensajes retenidos
      _listenToMqttData();
      debugPrint('Iniciando conexión MQTT...');
      await _mqttService.connect();
      if (mounted) setState(() => _debugStatus = "Conectado. Esperando datos...");
      debugPrint('Conexión MQTT establecida correctamente');
    } catch (e) {
      if (mounted) setState(() => _debugStatus = "Error conexión: $e");
      debugPrint('Error conectando a MQTT: $e');
    }
  }

  void _listenToMqttData() {
    _mqttSubscription = _mqttService.dataStream.listen((data) {
      debugPrint('Datos recibidos MQTT: $data');
      if (!mounted) return;
      setState(() {
        _debugStatus = "Último dato recibido:\n$data";
      });
      _updateSensorValues(data);
    }, onError: (error) {
      debugPrint('Error en stream MQTT: $error');
    });
  }

  void _updateSensorValues(Map<String, dynamic> data) {
    if (!mounted) return;

    setState(() {
      _sensorReadings = _sensorReadings.map((sensor) {
        String? jsonKey = _getJsonKeyForSensor(sensor.name);

        if (jsonKey != null && data.containsKey(jsonKey)) {
          final double newValue = (data[jsonKey] as num).toDouble();
          debugPrint('Actualizando sensor ${sensor.name}: $newValue');

          // Actualizar historial
          List<double> newHistory = List.from(sensor.history);
          newHistory.add(newValue);
          if (newHistory.length > 12) newHistory.removeAt(0);

          return SensorReading(
            id: sensor.id,
            name: sensor.name,
            value: newValue,
            unit: sensor.unit,
            status: _calculateStatus(newValue, sensor.minThreshold, sensor.maxThreshold),
            timestamp: DateTime.now(),
            icon: sensor.icon,
            minThreshold: sensor.minThreshold,
            maxThreshold: sensor.maxThreshold,
            history: newHistory,
          );
        }
        return sensor;
      }).toList();
    });
  }

  String? _getJsonKeyForSensor(String sensorName) {
    switch (sensorName) {
      case 'pH': return 'ph';
      case 'Flujo': return 'flujo';
      case 'Volumen': return 'volumen';
      case 'Turbidez': return 'turbidez';
      case 'Conductividad': return 'conductividad';
      default: return null;
    }
  }

  SensorStatus _calculateStatus(double value, double min, double max) {
    if (value < min || value > max) {
      return SensorStatus.warning;
    }
    return SensorStatus.good;
  }

  Future<void> _loadSensorData() async {
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
          history: [7.0, 7.1, 7.2],
        ),
        SensorReading(
          id: '2',
          name: 'Flujo',
          value: 0.0,
          unit: 'L/min',
          status: SensorStatus.warning,
          timestamp: DateTime.now(),
          icon: Icons.waves,
          minThreshold: 15.0,
          maxThreshold: 30.0,
          history: [0.0],
        ),
        SensorReading(
          id: '3',
          name: 'Turbidez',
          value: 45.2,
          unit: 'NTU',
          status: SensorStatus.critical,
          timestamp: DateTime.now(),
          icon: Icons.water_drop,
          minThreshold: 0,
          maxThreshold: 50,
          history: [42.0, 43.5, 45.2],
        ),
        SensorReading(
          id: '4',
          name: 'Conductividad',
          value: 520,
          unit: 'µS/cm',
          status: SensorStatus.good,
          timestamp: DateTime.now(),
          icon: Icons.bolt,
          minThreshold: 200,
          maxThreshold: 800,
          history: [510, 515, 520],
        ),
      ];
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    await _loadSensorData();
  }

  void _navigateToSensorDetail(SensorReading reading) {
    Navigator.pushNamed(
      context,
      '/sensor-detail',
      arguments: reading,
    );
  }

  @override
  void dispose() {
    _mqttSubscription?.cancel();
    _mqttService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _refreshData,
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: DashboardHeader(),
                    ),
                    SliverToBoxAdapter(
                      child: SystemStatusCard(readings: _sensorReadings),
                    ),
                    SliverToBoxAdapter(
                      child: SensorListSection(
                        readings: _sensorReadings,
                        onSensorTap: _navigateToSensorDetail,
                      ),
                    ),
                    // Sección de Debug para ver los datos en el APK sin consola
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black12,
                          child: Text(
                            'DEBUG LOG:\n$_debugStatus',
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
