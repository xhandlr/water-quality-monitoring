#define BLYNK_TEMPLATE_ID "TMPL2GG05gCkb"
#define BLYNK_TEMPLATE_NAME "TABLERO PLC"
#define BLYNK_AUTH_TOKEN "6qS9rM1KtRLAxDJj2mGjuBgurqt3IQEN"
#define BLYNK_PRINT Serial

#include <WiFi.h>
#include <WiFiClient.h>
#include <BlynkSimpleEsp32.h>
#include <DHT.h>

#define DHTPIN 4     // Pin conectado al sensor DHT22
#define DHTTYPE DHT22   // DHT 22 (AM2302)
#define TRIG_PIN 5   // Pin Trig conectado al GPIO 5
#define ECHO_PIN 18  // Pin Echo conectado al GPIO 18

DHT dht(DHTPIN, DHTTYPE);

char auth[] = BLYNK_AUTH_TOKEN;
char ssid[] = "Wokwi-GUEST";
char pass[] = "";

const int phPin = 35;
const int turbidezPin = 34;

void setup() {
  Serial.begin(115200);
  Blynk.begin(auth, ssid, pass);
  pinMode(phPin, INPUT);
  pinMode(turbidezPin, INPUT);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  dht.begin();
}

void loop() {
  // Medir distancia
  long duration, distance;
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  duration = pulseIn(ECHO_PIN, HIGH);
  distance = (duration / 2) / 29.1; // Convertir a cm

   // Leer temperatura del DHT22
  float temperature = dht.readTemperature();

  // Verificar si alguna lectura falló y salir temprano (para intentar nuevamente).
  if (isnan(temperature) || distance == 0) {
    Serial.println("¡Fallo al leer del sensor DHT o del sensor ultrasónico!");
  } else {
    Serial.print("Temperatura: ");
    Serial.print(temperature);
    Serial.print(" °C ");
    Serial.print("Distancia: ");
    Serial.print(distance);
    Serial.println(" cm");

    Blynk.virtualWrite(V7, temperature);  // Temperatura
    Blynk.virtualWrite(V9, distance);     // Distancia
  }

  int phValue = analogRead(phPin);
  int turbidezValue = analogRead(turbidezPin);

  float ph = map(phValue, 0, 4095, 0, 14);
  float turbidez = map(turbidezValue, 0, 4095, 0, 1000);

  Serial.print("Valor de PH: ");
  Serial.print(ph);
  Serial.print("\t Valor de Turbidez: ");
  Serial.print(turbidez);
  Serial.println(" ntu");

  Blynk.virtualWrite(V5, ph);  // ph
  Blynk.virtualWrite(V6, turbidez);  // turbidez
  Blynk.run();
  delay(2000); // Retraso de 2 segundos entre mediciones
}
