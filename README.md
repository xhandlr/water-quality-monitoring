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


## Arquitectura de App Móvil

```
lib/
├── main.dart
├── core/                          # Cosas transversales
│   ├── config/
│   │   ├── theme.dart
│   │   └── routes.dart
│   ├── widgets/                   # Widgets globales reutilizables
│   │   ├── loading_indicator.dart
│   │   └── error_message.dart
│   └── utils/
│       └── validators.dart
│
├── features/                      # Cada feature es una carpeta
│   ├── auth/                      # Todo lo de autenticación junto
│   │   ├── pages/
│   │   │   ├── login_page.dart
│   │   │   └── register_page.dart
│   │   ├── widgets/
│   │   │   └── auth_form_field.dart
│   │   └── services/
│   │       └── auth_service.dart
│   │
│   ├── dashboard/                 # Dashboard principal
│   │   ├── pages/
│   │   │   └── dashboard_page.dart
│   │   └── widgets/
│   │       ├── summary_card.dart
│   │       └── quick_stats.dart
│   │
│   ├── monitoring/                # Gráficos en tiempo real
│   │   ├── pages/
│   │   │   └── monitoring_page.dart
│   │   ├── widgets/
│   │   │   ├── water_quality_chart.dart
│   │   │   └── sensor_status.dart
│   │   └── services/
│   │       └── sensor_service.dart
│   │
│   ├── reports/                   # Reportes y métricas
│   │   ├── pages/
│   │   │   ├── reports_page.dart
│   │   │   └── report_detail_page.dart
│   │   ├── widgets/
│   │   │   └── report_card.dart
│   │   └── services/
│   │       └── report_service.dart
│   │
│   └── profile/                   # Perfil de usuario
│       ├── pages/
│       │   ├── profile_page.dart
│       │   └── settings_page.dart
│       └── widgets/
│           └── profile_avatar.dart
│
├── shared/                        # Shared entre features
│   ├── layouts/
│   │   ├── main_layout.dart       # Layout con bottom nav
│   │   └── auth_layout.dart       # Layout sin nav (para login)
│   ├── models/
│   │   ├── user.dart
│   │   ├── sensor_data.dart
│   │   └── report.dart
│   └── services/
│       └── api_service.dart       # HTTP client base
```
