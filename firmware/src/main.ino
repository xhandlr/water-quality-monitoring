#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// Configuración OLED
Adafruit_SSD1306 display = Adafruit_SSD1306(128, 32, &Wire);

// Sensor de flujo de agua YF-S201 (o similar)
const int pinSensor = 2;  // Pin del sensor - debe ser pin 2 o 3 para interrupciones en Uno
volatile int contadorPulsos = 0;  // Contador de pulsos
float factorCalibracion = 7.5;  // Pulsos por litro (ajustar según tu sensor)
float flujoLitrosMin = 0;
float volumenTotal = 0;
unsigned long tiempoAnterior = 0;
unsigned long ultimaActualizacionOLED = 0;

// Sensor de pH - Pin analógico A0
const int pinPH = A0;
float valorPH = 7.0;
// Calibración del sensor de pH (ajustar según tu sensor específico)
const float voltajeReferencia = 5.0;  // Voltaje de referencia del Arduino
const float offsetPH = 0.0;  // Offset de calibración (ajustar en calibración)
const float pendientePH = 3.5;  // Pendiente de calibración (ajustar en calibración)

void setup() {
  Serial.begin(9600);
  
  // Inicializar OLED
  Serial.println("Inicializando OLED...");
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C); // Address 0x3C para 128x32
  
  display.display();
  delay(1000);
  
  // Limpiar buffer
  display.clearDisplay();
  display.display();
  
  // Configurar texto
  display.setTextSize(1);
  display.setTextColor(WHITE);
  
  // Configurar sensor de flujo
  pinMode(pinSensor, INPUT_PULLUP);

  // Configurar sensor de pH
  pinMode(pinPH, INPUT);

  // Interrupción en el pin 2 (INT0 en Arduino Uno)
  attachInterrupt(digitalPinToInterrupt(pinSensor), contarPulso, RISING);

  Serial.println("=== Sistema OLED + Sensores ===");
  Serial.println("Sensores: Flujo + pH");
  Serial.println("Esperando datos...");
  
  // Mostrar mensaje inicial en OLED
  mostrarMensajeInicial();
}

void loop() {
  // Calcular flujo cada segundo
  if (millis() - tiempoAnterior > 1000) {

    // Desactivar interrupciones temporalmente para cálculos
    detachInterrupt(digitalPinToInterrupt(pinSensor));

    // Calcular flujo en litros/minuto
    flujoLitrosMin = (contadorPulsos / factorCalibracion);

    // Calcular volumen total en litros
    volumenTotal += (flujoLitrosMin / 60);

    // Leer sensor de pH
    valorPH = leerPH();

    // Mostrar resultados en Serial (formato JSON)
    Serial.print("{\"flujo\":");
    Serial.print(flujoLitrosMin, 2);
    Serial.print(",\"volumen\":");
    Serial.print(volumenTotal, 2);
    Serial.print(",\"ph\":");
    Serial.print(valorPH, 2);
    Serial.println("}");

    // Reiniciar contador
    contadorPulsos = 0;
    tiempoAnterior = millis();

    // Reactivar interrupción
    attachInterrupt(digitalPinToInterrupt(pinSensor), contarPulso, RISING);
  }

  // Actualizar OLED cada 500ms (para mejor visualización)
  if (millis() - ultimaActualizacionOLED > 500) {
    actualizarOLED();
    ultimaActualizacionOLED = millis();
  }
}

// Función de interrupción para contar pulsos
void contarPulso() {
  contadorPulsos++;
}

// Función para leer el sensor de pH
float leerPH() {
  // Tomar múltiples lecturas para promediar y reducir ruido
  int numLecturas = 10;
  float sumaLecturas = 0;

  for (int i = 0; i < numLecturas; i++) {
    sumaLecturas += analogRead(pinPH);
    delay(10);
  }

  // Calcular promedio
  float lecturaPromedio = sumaLecturas / numLecturas;

  // Convertir lectura analógica a voltaje (0-1023 -> 0-5V)
  float voltaje = lecturaPromedio * (voltajeReferencia / 1024.0);

  // Convertir voltaje a pH usando la calibración
  // Fórmula típica: pH = 7 - ((voltaje - 2.5) / pendiente)
  // Ajusta la fórmula según tu sensor específico
  float ph = 7.0 + ((2.5 - voltaje + offsetPH) / (0.18 * pendientePH));

  // Limitar el valor de pH al rango válido (0-14)
  if (ph < 0) ph = 0;
  if (ph > 14) ph = 14;

  return ph;
}

// Función para mostrar mensaje inicial en OLED
void mostrarMensajeInicial() {
  display.clearDisplay();
  display.setCursor(0, 0);
  display.println("Sistema de Monitoreo");
  display.setCursor(0, 10);
  display.println("Flujo + pH");
  display.setCursor(0, 20);
  display.println("Inicializando...");
  display.display();
  delay(2000);
}

// Función para actualizar la pantalla OLED
void actualizarOLED() {
  display.clearDisplay();

  // Línea 1: Flujo
  display.setCursor(0, 0);
  display.print("Flujo:");
  display.print(flujoLitrosMin, 1);
  display.println(" L/min");

  // Línea 2: Volumen
  display.setCursor(0, 10);
  display.print("Vol:");
  display.print(volumenTotal, 2);
  display.println(" L");

  // Línea 3: pH
  display.setCursor(0, 20);
  display.print("pH: ");
  display.print(valorPH, 2);

  // Indicador visual del pH
  // pH < 7: ácido, pH = 7: neutro, pH > 7: básico
  display.setCursor(70, 20);
  if (valorPH < 6.5) {
    display.print("[ACIDO]");
  } else if (valorPH > 7.5) {
    display.print("[BASICO]");
  } else {
    display.print("[NEUTRO]");
  }

  // Barra inferior de actividad si hay flujo
  if (flujoLitrosMin > 0.1) {
    int anchoBarra = map(constrain(flujoLitrosMin * 10, 0, 100), 0, 100, 0, 128);
    display.fillRect(0, 31, anchoBarra, 1, WHITE);
  }

  display.display();
}