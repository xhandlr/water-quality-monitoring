import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import '../models/alert.dart';
import '../models/sensor_reading.dart';
import '../widgets/alerts/alert_filter_selector.dart';
import '../widgets/alerts/alerts_header.dart';
import '../widgets/alerts/alerts_list.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  List<Alert> _alerts = [];
  String _filterStatus = 'Todos';

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  void _loadAlerts() {
    // Datos simulados - en producción vendrían de la API
    setState(() {
      _alerts = [
        Alert(
          id: '1',
          sensorName: 'Turbidez',
          message: 'Nivel crítico detectado',
          severity: SensorStatus.critical,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          value: 48.5,
          unit: 'NTU',
        ),
        Alert(
          id: '2',
          sensorName: 'Flujo',
          message: 'Flujo por encima del umbral',
          severity: SensorStatus.warning,
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          value: 29.2,
          unit: 'L/min',
        ),
        Alert(
          id: '3',
          sensorName: 'pH',
          message: 'Nivel normalizado',
          severity: SensorStatus.good,
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          value: 7.2,
          unit: 'pH',
          isRead: true,
        ),
      ];
    });
  }

  List<Alert> get _filteredAlerts {
    if (_filterStatus == 'Todos') {
      return _alerts;
    }

    SensorStatus? status;
    switch (_filterStatus) {
      case 'Crítico':
        status = SensorStatus.critical;
        break;
      case 'Precaución':
        status = SensorStatus.warning;
        break;
      case 'Normal':
        status = SensorStatus.good;
        break;
    }

    return _alerts.where((alert) => alert.severity == status).toList();
  }

  Map<String, int> get _filterCounts {
    return {
      'Todos': _alerts.length,
      'Crítico': _alerts.where((a) => a.severity == SensorStatus.critical).length,
      'Precaución': _alerts.where((a) => a.severity == SensorStatus.warning).length,
      'Normal': _alerts.where((a) => a.severity == SensorStatus.good).length,
    };
  }

  void _markAllAsRead() {
    setState(() {
      _alerts = _alerts.map((alert) {
        return Alert(
          id: alert.id,
          sensorName: alert.sensorName,
          message: alert.message,
          severity: alert.severity,
          timestamp: alert.timestamp,
          value: alert.value,
          unit: alert.unit,
          isRead: true,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _alerts.where((a) => !a.isRead).length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            AlertsHeader(unreadCount: unreadCount),

            // Filtros
            AlertFilterSelector(
              filters: const ['Todos', 'Crítico', 'Precaución', 'Normal'],
              selectedFilter: _filterStatus,
              onFilterSelected: (newStatus) {
                setState(() {
                  _filterStatus = newStatus;
                });
              },
              counts: _filterCounts,
            ),

            // Lista de alertas
            Expanded(
              child: AlertsList(alerts: _filteredAlerts),
            ),
          ],
        ),
      ),
      floatingActionButton: unreadCount > 0
          ? FloatingActionButton.extended(
              onPressed: _markAllAsRead,
              icon: const Icon(Icons.done_all),
              label: const Text(
                'Marcar todo como leído',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.primary, width: 2),
              ),
            )
          : null,
    );
  }
}
