import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/alert.dart';
import '../models/sensor_reading.dart';

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
          sensorName: 'Temperatura',
          message: 'Temperatura por encima del umbral',
          severity: SensorStatus.warning,
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          value: 29.2,
          unit: '°C',
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
        Alert(
          id: '4',
          sensorName: 'Oxígeno Disuelto',
          message: 'Nivel bajo detectado',
          severity: SensorStatus.warning,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          value: 5.1,
          unit: 'mg/L',
          isRead: true,
        ),
        Alert(
          id: '5',
          sensorName: 'Cloro Residual',
          message: 'Nivel crítico bajo',
          severity: SensorStatus.critical,
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          value: 0.3,
          unit: 'mg/L',
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
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Todos'),
                _buildFilterChip('Crítico'),
                _buildFilterChip('Precaución'),
                _buildFilterChip('Normal'),
              ],
            ),
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
                      return _buildAlertCard(alert);
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

  Widget _buildFilterChip(String label) {
    final isSelected = label == _filterStatus;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        onSelected: (selected) {
          setState(() {
            _filterStatus = label;
          });
        },
        selectedColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAlertCard(Alert alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: alert.isRead ? 1 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: alert.isRead
              ? Colors.grey.withOpacity(0.2)
              : alert.severity.color.withOpacity(0.5),
          width: alert.isRead ? 1 : 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          _showAlertDetail(alert);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icono de estado
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: alert.severity.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  alert.icon,
                  color: alert.severity.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Información de la alerta
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          alert.sensorName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: alert.isRead
                                ? FontWeight.w600
                                : FontWeight.bold,
                          ),
                        ),
                        if (!alert.isRead) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${alert.value.toStringAsFixed(2)} ${alert.unit}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: alert.severity.color,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatTimestamp(alert.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours} h';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(timestamp);
    }
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
