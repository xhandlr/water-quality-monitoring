<div align="center">

<img src="app-mobile/assets/global/banner-aurix.png" alt="Aurix Banner" width="100%"/>

### Sistema Inteligente de Monitoreo y Filtración de Agua IoT

*Filtro nano-tecnológico con monitoreo en tiempo real*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![MQTT](https://img.shields.io/badge/MQTT-660066?style=for-the-badge&logo=mqtt&logoColor=white)](https://mqtt.org)
[![Arduino](https://img.shields.io/badge/Arduino-00979D?style=for-the-badge&logo=arduino&logoColor=white)](https://www.arduino.cc/)

[Características](#-características-principales) • [Arquitectura](#-arquitectura-del-sistema) • [Instalación](#-instalación) • [Uso](#-uso)

</div>

---

## 🎯 Descripción del Proyecto

**Aurix** es un proyecto académico desarrollado para "Taller de Empresas Tecnológicas" en la Universidad de La Frontera (2025), inspirado en las bases del concurso **Smart Temuco 2025**.

### 💡 Contexto y Alcance

El concepto original propone una solución integral que combina un **filtro físico microestratificado** con un **sistema de monitoreo IoT**. 

**Desarrollo Actual:**
Este repositorio contiene la implementación funcional de la **infraestructura de monitoreo IoT y software**, centrada en:
- **Diseño de Interfaz Móvil**: App en Flutter con visualización avanzada.
- **Integración IoT**: Conexión con sensores mediante Arduino y protocolo MQTT.
- **Simulación en Tiempo Real**: Motor en Python para pruebas de flujo de datos.

### 🔬 Sobre el Filtro (Concepto)

El filtro físico propuesto utiliza capas **micro-estratificadas** que combinan:
- **Biochar modificado** para adsorbción de contaminantes.
- **Nanopartículas de hierro de valencia cero (nZVI)** para remoción de metales pesados.
- **Proceso químico** que fija nZVI sobre biochar de mayor granulometría.

---

## ✨ Características Principales

### 📱 Aplicación Móvil
- 🎛️ **Dashboard en tiempo real** con sistema de semáforo visual (Verde/Amarillo/Rojo).
- � **Gráficos de tendencia temporal** con históricos reales.
- 🔔 **Sistema de alertas** basado en umbrales críticos configurables.
- � **Estadísticas automáticas** (promedio, máximo, mínimo).

### 🌐 Monitoreo IoT & Simulación
- **Sensores**: pH, Turbidez, Conductividad eléctrica y Flujo.
- 📡 Transmisión **MQTT** mediante broker Mosquitto/HiveMQ.
- 🧪 **Simulador IoT**: Script de Python (`iot-simulator`) para generar datos realistas.

---

## 🏗️ Arquitectura del Sistema

<div align="center">
<img src="app-mobile/assets/global/arquitecture-aurix.png" alt="Arquitectura Aurix" width="100%"/>
</div>

---

## 🛠️ Stack Tecnológico

### 📱 Frontend (Aplicación Móvil)
| Tecnología | Propósito |
|------------|-----------|
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | Framework multiplataforma |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | Lenguaje de programación |
| `fl_chart` | Visualización de gráficos |

### ⚙️ IoT & Simulación
| Tecnología | Propósito |
|------------|-----------|
| ![MQTT](https://img.shields.io/badge/MQTT-660066?style=flat&logo=mqtt&logoColor=white) | Protocolo de comunicación IoT |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Simulador de datos y Gateway Serial |
| ![Arduino](https://img.shields.io/badge/Arduino-00979D?style=flat&logo=arduino&logoColor=white) | Firmware de sensores |

---

## 📂 Estructura del Proyecto

```
app-mobile/       # Aplicación móvil en Flutter
firmware/         # Código Arduino y Gateway Serial-MQTT
iot-simulator/    # Simulador de datos en Python (antes ml-engine)
frontend/         # Prototipo web (React)
```

---

## 📦 Instalación

### 1. Aplicación Móvil
```bash
cd app-mobile
flutter pub get
flutter run
```

### 2. Simulador de Datos
```bash
cd iot-simulator
pip install -r requirements.txt
python models/mqtt_simulator.py
```

---

## 🎨 Diseño y Paleta de Colores

```dart
// Colores principales
Primary:    #1E88E5  // Azul principal
Background: #000E22  // Azul oscuro profundo
Success:    #4CAF50  // Verde (valores normales)
Warning:    #FF9800  // Naranja (precaución)
Critical:   #F44336  // Rojo (alerta crítica)
```

---

## 📝 Licencia e Integridad Académica

⚠️ **AVISO DE INTEGRIDAD ACADÉMICA**

Este proyecto fue desarrollado para "Taller de Empresas Tecnológicas" en la Universidad de La Frontera (2025). Presentar este trabajo como propio puede constituir una falta de conducta académica.

---

[![License: Custom](https://img.shields.io/badge/License-Custom-blue.svg)](LICENSE)

Este proyecto utiliza una **licencia personalizada** que permite uso comercial pero prohíbe específicamente participación en competiciones. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

## 👥 Autor

Desarrollado con 💙 por [xhandlr](https://github.com/xhandlr)

---

<div align="center">

**Aurix** - Agua limpia, datos claros, futuro sostenible 💧

</div>

