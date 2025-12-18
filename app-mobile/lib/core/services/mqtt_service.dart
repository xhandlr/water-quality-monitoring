import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  MqttServerClient? _client;
  final _dataController = StreamController<Map<String, dynamic>>.broadcast();

  // Configuración del broker MQTT (debe coincidir con arduino_mqtt_gateway.py)
  static const String broker = 'broker.hivemq.com';
  static const int port = 1883;
  static const String topic = 'aurix/water/data'; // Topic para suscribirse

  bool _isConnected = false;

  Stream<Map<String, dynamic>> get dataStream => _dataController.stream;
  bool get isConnected => _isConnected;

  Future<void> connect() async {
    try {
      // Generar un ID único para evitar conflictos si la sesión anterior quedó colgada
      String clientId = 'aurix_mobile_${Random().nextInt(100000)}';

      _client = MqttServerClient.withPort(broker, clientId, port);

      // Configuración mejorada para conexión más estable
      _client!.logging(on: false); // Desactivar logging para producción
      _client!.keepAlivePeriod = 20;
      _client!.connectTimeoutPeriod = 5000; // 5 segundos de timeout
      _client!.autoReconnect = true;
      _client!.onDisconnected = _onDisconnected;
      _client!.onConnected = _onConnected;
      _client!.onSubscribed = _onSubscribed;

      // Usar protocolo 3.1.1 para mayor compatibilidad con HiveMQ
      _client!.setProtocolV311();

      final connMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
          .startClean() // Iniciar con sesión limpia
          .withWillQos(MqttQos.atMostOnce);

      _client!.connectionMessage = connMessage;

      try {
        await _client!.connect();
      } on NoConnectionException catch (e) {
        print('MQTT connection failed: $e');
        _client!.disconnect();
        // Relanzar el error para que la UI sepa que falló
        rethrow;
      } on SocketException catch (e) {
        print('MQTT socket exception: $e');
        _client!.disconnect();
        // Relanzar el error para que la UI sepa que falló
        rethrow;
      }

      if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
        print('✅ MQTT client connected successfully');
        _isConnected = true;
        _subscribe();
      } else {
        print('❌ MQTT connection failed - status: ${_client!.connectionStatus}');
        _client!.disconnect();
        _isConnected = false;
        throw Exception('Connection failed with status: ${_client!.connectionStatus}');
      }
    } catch (e) {
      print('❌ ERROR connecting to MQTT: $e');
      _isConnected = false;
      rethrow; // Asegurar que el error llegue a la UI
    }
  }

  void _subscribe() {
    print('📡 Suscribiendo a topic: $topic');
    _client!.subscribe(topic, MqttQos.atMostOnce);

    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      final recMess = messages[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('📥 Mensaje MQTT recibido: $payload');

      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        print('✅ JSON parseado: $data');
        _dataController.add(data);
      } catch (e) {
        print('❌ Error parsing MQTT message: $e');
      }
    }, onError: (error) {
      print('❌ Error en updates stream: $error');
    });
  }

  void _onConnected() {
    print('✅ MQTT: Callback onConnected ejecutado');
    _isConnected = true;
  }

  void _onDisconnected() {
    print('⚠️ MQTT: Callback onDisconnected ejecutado');
    _isConnected = false;
  }

  void _onSubscribed(String topic) {
    print('✅ Suscrito exitosamente al topic: $topic');
  }

  void dispose() {
    _client?.disconnect();
    _dataController.close();
  }

  void publish(String topic, Map<String, dynamic> message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(jsonEncode(message));
    _client?.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }
}
