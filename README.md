<div align="center">

<img src="aurix/assets/global/banner-aurix.png" alt="Aurix Banner" width="100%"/>

### Sistema Inteligente de Monitoreo y Filtración de Agua IoT

*Filtro nano-tecnológico con monitoreo en tiempo real*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org)
[![MQTT](https://img.shields.io/badge/MQTT-660066?style=for-the-badge&logo=mqtt&logoColor=white)](https://mqtt.org)
[![TimescaleDB](https://img.shields.io/badge/TimescaleDB-FDB515?style=for-the-badge&logo=timescale&logoColor=white)](https://www.timescale.com/)

[Características](#-características-principales) • [Arquitectura](#-arquitectura-del-sistema) • [Instalación](#-instalación) • [Uso](#-uso)

</div>

---

## 🎯 Descripción del Proyecto

**Aurix** es un proyecto académico desarrollado para "Taller de Empresas Tecnológicas" en la Universidad de La Frontera (2025), inspirado en las bases del concurso **Smart Temuco 2025**.

### 💡 Contexto del Prototipo

El concepto original propone una solución integral que combina un **filtro físico microestratificado** con un **sistema de monitoreo IoT** para calidad de agua. Este repositorio desarrolla específicamente la **capa de software y monitoreo IoT** - la parte posterior al proceso de filtración.

### 🔬 Sobre el Filtro

El filtro físico propuesto utiliza capas **micro-estratificadas** que combinan:
- **Biochar modificado** para adsorbción de contaminantes
- **Nanopartículas de hierro de valencia cero (nZVI)** para remoción de metales pesados y contaminantes orgánicos
- **Proceso químico** que fija nZVI sobre biochar de mayor granulometría

### 💻 Desarrollo en Este Repositorio

Este proyecto implementa la **infraestructura de monitoreo IoT y software**, incluyendo:
- Sistema de adquisición de datos con sensores básicos de prueba
- Transmisión MQTT mediante broker Mosquitto
- Backend Node.js para procesamiento y almacenamiento
- Aplicación móvil Flutter para visualización en tiempo real
- Base de datos TimescaleDB optimizada para series temporales

---

## ✨ Características Principales

### 📱 Aplicación Móvil
- 🎛️ **Dashboard en tiempo real** con sistema de semáforo visual (Verde/Amarillo/Rojo)
- 📊 **Gráficos de tendencia temporal** con históricos configurables (24h, 7d, 30d)
- 🔔 **Sistema de alertas inteligente** con notificaciones push
- ⚙️ **Configuración de umbrales personalizados** por sensor
- 📈 **Estadísticas automáticas** (promedio, máximo, mínimo)
- 🤖 **Detección de anomalías con ML** (disponible después de 12 meses de datos)

### 🌐 Monitoreo IoT
- **Sensores básicos** para prototipo:
  - 🧪 **pH** - Acidez/alcalinidad del agua
  - 🌫️ **Turbidez** - Claridad y partículas suspendidas
  - ⚡ **Conductividad eléctrica** - Contenido de sales disueltas
  - 💧 **Flujo** - Caudal de agua filtrada
- 📡 Transmisión **MQTT** mediante broker Mosquitto
- ⏱️ Muestreo configurable en tiempo real
- 🔌 Arquitectura escalable para sensores industriales

### 🧠 Backend Inteligente
- 💾 **TimescaleDB** optimizada para series temporales
- 🔄 Suscripción MQTT permanente al broker Mosquitto
- 🌐 **API REST** con endpoints documentados
- 📊 Agregaciones y reportes para auditorías
- 🐍 **Módulo Python de ML** para detección predictiva de anomalías (planificado)

---

## 🏗️ Arquitectura del Sistema

<div align="center">
<img src="aurix/assets/global/arquitecture-aurix.png" alt="Arquitectura Aurix" width="100%"/>
</div>

---

## 🛠️ Stack Tecnológico

### 📱 Frontend (Aplicación Móvil)
| Tecnología | Propósito |
|------------|-----------|
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | Framework multiplataforma |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | Lenguaje de programación |
| `fl_chart` | Visualización de gráficos |
| `http` | Cliente REST API |
| `intl` | Internacionalización y formato de fechas |

### ⚙️ Backend (Servidor)
| Tecnología | Propósito |
|------------|-----------|
| ![Node.js](https://img.shields.io/badge/Node.js-339933?style=flat&logo=nodedotjs&logoColor=white) | Runtime del servidor |
| ![MQTT](https://img.shields.io/badge/MQTT-660066?style=flat&logo=mqtt&logoColor=white) | Protocolo IoT |
| ![TimescaleDB](https://img.shields.io/badge/TimescaleDB-FDB515?style=flat&logo=timescale&logoColor=white) | Base de datos temporal |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Machine Learning |
| Express.js | Framework REST API |

### 🔌 Hardware & IoT
| Componente | Especificación |
|------------|----------------|
| **Microcontrolador** | ESP32 con WiFi |
| **Sensores** | pH, Turbidez, Conductividad, Flujo (básicos para prototipo) |
| **Protocolo** | MQTT |
| **Broker** | Mosquitto |
| **Filtro** | Biochar + nZVI nano-estratificado (concepto) |

---

## 📂 Estructura del Proyecto

```
aurix/
├── android/                  # Configuración Android
├── ios/                      # Configuración iOS
├── assets/                   # Recursos estáticos
│   └── icon/                 # Iconos de la app
├── lib/
│   ├── core/                 # 🎨 Configuración global
│   │   ├── config/
│   │   │   └── theme.dart    # Tema y paleta de colores
│   │   └── widgets/
│   │       └── loading_indicator.dart
│   │
│   ├── features/             # 📦 Módulos por característica
│   │   ├── auth/             # 🔐 Autenticación
│   │   │   └── pages/
│   │   │       ├── splash_screen.dart
│   │   │       ├── login_page.dart
│   │   │       └── home_page.dart
│   │   │
│   │   └── monitoring/       # 📊 Monitoreo (Módulo principal)
│   │       ├── models/       # Modelos de dominio
│   │       │   ├── sensor_reading.dart
│   │       │   └── alert.dart
│   │       ├── pages/        # Pantallas
│   │       │   ├── main_navigation.dart
│   │       │   ├── dashboard_page.dart
│   │       │   ├── charts_page.dart
│   │       │   ├── alerts_page.dart
│   │       │   ├── devices_page.dart
│   │       │   ├── profile_page.dart
│   │       │   ├── settings_page.dart
│   │       │   └── sensor_detail_page.dart
│   │       └── widgets/      # Widgets reutilizables
│   │           └── sensor_card.dart
│   │
│   ├── shared/               # 🔄 Componentes compartidos
│   │   ├── layouts/
│   │   │   └── main_layout.dart
│   │   └── widgets/
│   │       └── custom_button.dart
│   │
│   └── main.dart             # 🚀 Entry point
│
├── pubspec.yaml              # Dependencias
└── README.md                 # Este archivo
```

---

## 📦 Instalación

### Prerequisitos

- Flutter SDK `>=3.5.4 <4.0.0`
- Dart SDK
- Android Studio / Xcode (para desarrollo móvil)
- Dispositivo físico o emulador

### Pasos de instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/water-quality-monitoring.git
cd water-quality-monitoring/aurix
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Verificar configuración de Flutter**
```bash
flutter doctor
```

4. **Ejecutar en modo desarrollo**
```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web (opcional)
flutter run -d chrome
```

5. **Compilar APK para producción**
```bash
flutter build apk --release
```

El APK generado estará en: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🚀 Uso

### Navegación Principal

La aplicación utiliza un sistema de navegación por pestañas con 5 secciones principales:

1. **🏠 Dashboard** (`/dashboard`)
   - Vista general de todos los sensores
   - Sistema de semáforo en tiempo real
   - Resumen de estado del sistema

2. **📊 Gráficos** (`/charts`)
   - Tendencias temporales configurables
   - Selección de rango: 24h, 7d, 30d
   - Estadísticas automáticas

3. **🔔 Alertas** (`/alerts`)
   - Historial completo de alertas
   - Filtrado por severidad
   - Notificaciones push

4. **📱 Dispositivos** (`/devices`)
   - Listado de dispositivos ESP32 conectados
   - Estado de conexión
   - Configuración por dispositivo

5. **👤 Perfil** (`/profile`)
   - Configuración de usuario
   - Umbrales personalizados
   - Preferencias de notificación

### Sistema de Estados

```dart
enum SensorStatus {
  good,      // 🟢 Verde - Valores normales
  warning,   // 🟡 Amarillo - Precaución
  critical   // 🔴 Rojo - Alerta crítica
}
```

---

## 🎨 Diseño y Paleta de Colores

```dart
// Colores principales
Primary:    #1E88E5  // Azul principal
Secondary:  #64B5F6  // Azul claro

// Estados
Success:    #4CAF50  // Verde (valores normales)
Warning:    #FF9800  // Naranja (precaución)
Critical:   #F44336  // Rojo (alerta crítica)

// Fondos
Background: #000E22  // Azul oscuro profundo
Surface:    #001B3D  // Azul oscuro medio
Card:       #0A2540  // Azul oscuro claro
```

---

## 📊 Modelos de Datos

### SensorReading
```dart
class SensorReading {
  final String id;
  final String name;
  final double value;
  final String unit;
  final SensorStatus status;
  final DateTime timestamp;
  final IconData icon;
  final double minThreshold;
  final double maxThreshold;
}
```

### Alert
```dart
class Alert {
  final String id;
  final String sensorName;
  final String message;
  final SensorStatus severity;
  final DateTime timestamp;
  final double value;
  final String unit;
  final bool isRead;
}
```

---

## 🧪 Machine Learning (Módulo Predictivo)

Disponible después de **12 meses de datos históricos**:

- **Detección de anomalías** mediante algoritmos de ML
- **Identificación de patrones estacionales** en la calidad del agua
- **Alertas predictivas** antes de alcanzar niveles críticos
- **Intervención preventiva** basada en desviaciones estadísticas

### Algoritmos utilizados
- Isolation Forest
- LSTM para series temporales
- Análisis de tendencias estacionales (SARIMA)

---

## 🗺️ Roadmap

### ✅ Fase 1 - Completado
- [x] Diseño UI/UX completo
- [x] Dashboard con sistema de semáforo
- [x] Gráficos de tendencia temporal
- [x] Sistema de alertas
- [x] Navegación entre pantallas

### 🚧 Fase 2 - En Desarrollo
- [ ] Integración con API REST del backend
- [ ] Almacenamiento local con SQLite
- [ ] Gestión de estado con Provider/Riverpod
- [ ] Autenticación JWT
- [ ] Notificaciones push locales

### 📋 Fase 3 - Planificado
- [ ] Sincronización en tiempo real (WebSockets)
- [ ] Modo offline completo
- [ ] Generación de reportes PDF
- [ ] Exportación de datos (CSV, Excel)
- [ ] Multi-dispositivo (varios filtros)

### 🔮 Fase 4 - Futuro
- [ ] Módulo ML de detección de anomalías
- [ ] Dashboard web (Flutter Web)
- [ ] Integración con sensores adicionales
- [ ] Sistema de suscripción y pagos

---

## 📝 Licencia

⚠️ **AVISO DE INTEGRIDAD ACADÉMICA**

Este proyecto fue desarrollado para "Taller de Empresas Tecnológicas" en la
Universidad de La Frontera (2025). Presentar este trabajo como propio en el mismo curso puede constituir una falta de conducta académica. 

Consulte las políticas de integridad académica de su institución y obtenga la autorización correspondiente antes de utilizar este trabajo en presentaciones académicas.

---

[![License: Custom](https://img.shields.io/badge/License-Custom-blue.svg)](LICENSE)

Este proyecto utiliza una **licencia personalizada** que permite uso comercial 
pero prohíbe específicamente participación en competiciones.

### 📄 Detalles Completos
Ver el archivo [LICENSE](LICENSE) para términos y condiciones completos.

---

## 👥 Autor

Desarrollado con 💙 por [xhandlr](https://github.com/xhandlr)

---

## 📞 Contacto

¿Preguntas? ¿Sugerencias? ¿Interesado en implementar Aurix?

- 🌐 Website: 
- 📱 Demo: [Ver video demostrativo](#)

---

<div align="center">

**Aurix** - Agua limpia, datos claros, futuro sostenible 💧

</div>
