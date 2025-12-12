import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/alert.dart';
import '../models/sensor_reading.dart';
import '../widgets/dashboard/alert_card.dart';
import '../widgets/filter_selector.dart';

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

  @override
  Widget build(BuildContext context) {
    final unreadCount = _alerts.where((a) => !a.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Alertas'),
        actions: [
          if (unreadCount > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$unreadCount nuevas',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          FilterSelector(
            filters: const ['Todos', 'Crítico', 'Precaución', 'Normal'],
            selectedFilter: _filterStatus,
            onFilterSelected: (newStatus) {
              setState(() {
                _filterStatus = newStatus;
              });
            },
          ),

          // Lista de alertas
          Expanded(
            child: _filteredAlerts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay alertas',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
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
      floatingActionButton: unreadCount > 0
          ? FloatingActionButton.extended(
              onPressed: () {
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
              },
              icon: const Icon(Icons.done_all),
              label: const Text('Marcar todo como leído'),
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
