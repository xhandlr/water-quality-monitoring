import serial
import serial.tools.list_ports
import json
import time
import paho.mqtt.client as mqtt
import sys

# --- CONFIGURACIÓN ---

# 1. Configuración del Puerto Serial (Arduino)
# En Linux suele ser /dev/ttyACM0 o /dev/ttyUSB0
# En Windows suele ser COM3, COM4, etc.
SERIAL_PORT = '/dev/ttyUSB0' 
BAUD_RATE = 9600

# 2. Configuración MQTT (Nube)
# Usamos un broker público para pruebas. Para producción usa HiveMQ Cloud o tu propio servidor.
MQTT_BROKER = "broker.hivemq.com"
MQTT_PORT = 1883
MQTT_TOPIC = "aurix/water/data"
CLIENT_ID = "AurixGatewayPC"

# --- FUNCIONES ---

def on_connect(client, userdata, flags, rc, properties=None):
    if rc == 0:
        print(f"[MQTT] Conectado exitosamente al broker: {MQTT_BROKER}", flush=True)
    else:
        print(f"[MQTT] Error de conexión, código: {rc}", flush=True)

def main():
    print("=== Aurix Gateway: Serial a MQTT ===", flush=True)

    # Configurar Cliente MQTT
    # Compatibilidad con paho-mqtt v2.0.0+
    try:
        client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2, CLIENT_ID)
    except AttributeError:
        client = mqtt.Client(CLIENT_ID)

    client.on_connect = on_connect
    

    # Conectar a MQTT
    try:
        print(f"[MQTT] Conectando a {MQTT_BROKER}...", flush=True)
        client.connect(MQTT_BROKER, MQTT_PORT, 60)
        client.loop_start() # Inicia el proceso en segundo plano
    except Exception as e:
        print(f"[MQTT] Error crítico MQTT: {e}", flush=True)
        return

    # Conectar a Serial (Arduino)
    try:
        print(f"[SERIAL] Intentando abrir puerto {SERIAL_PORT}...", flush=True)
        ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
        time.sleep(2) # Esperar reinicio del Arduino
        ser.reset_input_buffer()
        print("[SERIAL] Puerto abierto correctamente. Esperando datos...", flush=True)
    except Exception as e:
        print(f"[SERIAL] ERROR: No se pudo abrir el puerto {SERIAL_PORT}", flush=True)
        print(f"Detalle: {e}", flush=True)
        print("\n--- Puertos disponibles ---", flush=True)
        ports = serial.tools.list_ports.comports()
        for p in ports:
            print(f"   {p.device} - {p.description}", flush=True)
        print("---------------------------", flush=True)
        client.loop_stop()
        return

    # Bucle Principal
    while True:
        try:
            if ser.in_waiting > 0:
                # Leer línea del Arduino, decodificar y quitar espacios
                line = ser.readline().decode('utf-8', errors='ignore').strip()
                
                # Tu main.ino envía JSON: {"flujo": 12.5, "volumen": 5.0}
                if line.startswith('{') and line.endswith('}'):
                    try:
                        # Validar que sea JSON real
                        data = json.loads(line)
                        
                        # Publicar a MQTT
                        payload = json.dumps(data)
                        client.publish(MQTT_TOPIC, payload, retain=True)
                        print(f"[ENVIADO] {payload}", flush=True)
                        
                    except json.JSONDecodeError:
                        print(f"[ERROR] JSON malformado: {line}", flush=True)
                elif line:
                    # Imprimir logs del Arduino que no son datos (ej. "Inicializando...")
                    print(f"[ARDUINO] {line}", flush=True)
                    
        except KeyboardInterrupt:
            print("\nDeteniendo Gateway...", flush=True)
            break
        except Exception as e:
            print(f"Error en bucle: {e}", flush=True)

    # Limpieza al salir
    ser.close()
    client.loop_stop()
    client.disconnect()

if __name__ == "__main__":
    main()