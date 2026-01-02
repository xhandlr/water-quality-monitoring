import time
import json
import random
import sys

# Intentar importar paho.mqtt.client
try:
    import paho.mqtt.client as mqtt
except ImportError:
    print("Error: Necesitas instalar la librería paho-mqtt")
    print("Ejecuta: pip install paho-mqtt")
    sys.exit(1)

# Configuración del Broker (Debe coincidir con mqtt_service.dart)
BROKER = "broker.hivemq.com"
PORT = 1883
TOPIC = "aurix/water/data"
CLIENT_ID = f"aurix-simulator-{random.randint(1000, 9999)}"

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print(f"✅ Conectado exitosamente al broker: {BROKER}")
        print(f"📡 Publicando en el tema: {TOPIC}")
    else:
        print(f"❌ Fallo en conexión, código de retorno: {rc}")

def generate_sensor_data():
    """Genera valores realistas simulando calidad del agua"""
    return {
        # pH: Rango normal entre 6.5 y 8.5
        "ph": round(random.uniform(6.5, 8.5), 2),
        
        # Turbidez: 0 a 5 NTU es agua clara
        "turbidez": round(random.uniform(0.5, 8.0), 2),
        
        # Conductividad: 200-800 µS/cm es típico
        "conductividad": round(random.uniform(200, 800), 2),
        
        # Flujo: Litros por minuto
        "flujo": round(random.uniform(1.5, 4.0), 1),
        
        "timestamp": int(time.time() * 1000)
    }

def main():
    # Compatibilidad con paho-mqtt 2.x para evitar advertencias
    if hasattr(mqtt, 'CallbackAPIVersion'):
        client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION1, CLIENT_ID)
    else:
        client = mqtt.Client(CLIENT_ID)
    client.on_connect = on_connect

    print("🌊 Iniciando Simulador de Sensores Aurix...")
    
    try:
        client.connect(BROKER, PORT, 60)
        client.loop_start() # Inicia el hilo de red en segundo plano

        while True:
            data = generate_sensor_data()
            payload = json.dumps(data)
            
            client.publish(TOPIC, payload)
            print(f"📤 Enviado: {payload}")
            
            # Esperar 5 segundos antes del siguiente envío
            time.sleep(5)

    except KeyboardInterrupt:
        print("\nSimulador detenido por el usuario")
        client.loop_stop()
        client.disconnect()
    except Exception as e:
        print(f"\nOcurrió un error: {e}")
if __name__ == "__main__":
    main()