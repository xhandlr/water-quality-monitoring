Aurix prototype

```
├── firmware/                    # Código para ESP32
│   ├── src/
│   │   ├── main.ino            # Programa principal Arduino
│   │   ├── sensors/            # Drivers de sensores (pH, TDS, turbidez)
│   │   └── mqtt_client/        # Cliente MQTT
│   └── config/                 # Configuración WiFi y MQTT
│
├── backend/                     # Node.js + Express
│   ├── services/
│   │   ├── mqtt-subscriber/    # Servicio de ingesta MQTT
│   │   └── api/                # API REST
│   ├── models/                 # Modelos de datos
│   ├── db/                     # Configuración TimescaleDB
│   └── tests/
│
├── ml-engine/                   # Python para ML
│   ├── notebooks/              # Jupyter notebooks para PoC
│   ├── models/                 # Scripts de detección de anomalías
│   ├── data/                   # Datasets de prueba
│   └── requirements.txt
│
├── frontend/                    # React Dashboard
│   ├── src/
│   │   ├── components/         # Componentes React
│   │   ├── services/           # Cliente API
│   │   └── charts/             # Visualizaciones (Chart.js/Recharts)
│   └── public/
│
├── docker/                      # Contenedores (por confirmar)
│   └── docker-compose.yml
│
├── docs/                        # Documentación
│   ├── architecture.md
│   └── setup.md
│
└── README.md
```
