import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aurix/core/config/theme.dart';
import '../models/alert.dart';
import '../models/sensor_reading.dart';
import '../widgets/alerts/alert_card.dart';
import '../widgets/alerts/alert_filter_selector.dart';

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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notificaciones',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Historial de eventos y alertas',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      // Bell Icon with notification dot
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            if (unreadCount > 0)
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

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
              child: _filteredAlerts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay alertas',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredAlerts.length,
                      itemBuilder: (context, index) {
                        final alert = _filteredAlerts[index];
                        return AlertCard(
                          alert: alert,
                          onTap: () => _showAlertDetail(alert),
                        );
                      },
                    ),
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





  void _showAlertDetail(Alert alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(alert.icon, color: alert.severity.color),
            const SizedBox(width: 12),
            Expanded(child: Text(alert.sensorName)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alert.message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Valor', '${alert.value} ${alert.unit}'),
            _buildDetailRow('Severidad', alert.severity.name.toUpperCase()),
            _buildDetailRow(
              'Fecha',
              DateFormat('dd/MM/yyyy HH:mm:ss').format(alert.timestamp),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // Navegar al sensor específico
            },
            icon: const Icon(Icons.show_chart),
            label: const Text('Ver Gráfico'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
