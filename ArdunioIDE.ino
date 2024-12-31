#define BLYNK_TEMPLATE_ID "Template ID"
#define BLYNK_TEMPLATE_NAME "Template Name"
#define BLYNK_AUTH_TOKEN "Auth Token-"

#include <Servo.h>
#include <NewPing.h>
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

// Pin Definitions
#define ECHO_PIN 5
#define TRIG_PIN 4
#define SERVO_PIN 12
#define BUZZER_PIN 14
#define MAX_DISTANCE 60


// WiFi Credentials
char ssid[] = "SSID";
char pass[] = "PASS";

// Global Variables
Servo myServo;
NewPing sonar(TRIG_PIN, ECHO_PIN, MAX_DISTANCE);
int angle = 15;

// Blynk Authentication Token
char auth[] = BLYNK_AUTH_TOKEN;

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, pass);

  // Connect to WiFi
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  // Initialize Blynk
  Blynk.begin(auth, ssid, pass);

  // Setup hardware components
  myServo.attach(SERVO_PIN);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  myServo.write(angle); // Start at 15 degrees
}

void loop() {
  scanServo();
  Blynk.run();
}

void scanServo() {
  for (angle = 0; angle <= 180; angle += 15) {
    handleSonar(angle);
  }
  for (angle = 180; angle >= 0; angle -= 15) {
    handleSonar(angle);
  }
}

void handleSonar(int currentAngle) {
  myServo.write(angle);
  delay(200);

  // Measure distance
  unsigned int distance = sonar.ping_cm();

  // Send data to Processing and Blynk
  if (distance > 20 && distance < MAX_DISTANCE) {
    Blynk.virtualWrite(V0, distance);
    Blynk.virtualWrite(V1, HIGH); // LED ON
    Blynk.virtualWrite(V2, angle);
    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.println(".");
    digitalWrite(BUZZER_PIN, HIGH); // Turn buzzer ON
  } else {
    Serial.print(angle);
    Serial.print(",");
    Serial.println("0."); // Send 0 if out of range
    digitalWrite(BUZZER_PIN, LOW);  // Turn buzzer OFF
    Blynk.virtualWrite(V1, LOW);   // LED OFF
  }
}
