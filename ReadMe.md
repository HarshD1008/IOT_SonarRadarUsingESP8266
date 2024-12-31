# Sonar Radar IoT Project

This project is an IoT-enabled sonar radar system built using an ESP8266, an ultrasonic sensor, and a servo motor. It uses Blynk for remote monitoring and control, providing real-time distance data and visual feedback.

---

## Features
- **Distance Measurement:** Uses an ultrasonic sensor to measure distances of objects in its field of view.
- **Servo Scanning:** The servo motor sweeps the sensor across an angular range to detect objects.
- **Blynk Integration:** Sends real-time distance and angle data to a Blynk dashboard.
- **Visual and Audible Alerts:** Triggers a buzzer and visual indicators when objects are detected within a defined threshold.

---

## Hardware Requirements
- ESP8266 NodeMCU
- Ultrasonic sensor (HC-SR04 or similar)
- Servo motor (e.g., SG90)
- Buzzer
- Breadboard and jumper wires
- Power source

---

## Software Requirements
- Arduino IDE
- Blynk library
- Servo library
- ESP8266WiFi library

---

## Circuit Diagram
Connect the components as follows:
- **Trigger Pin (TRIG)**: GPIO4 (D2)
- **Echo Pin (ECHO)**: GPIO5 (D1)
- **Servo Motor**: GPIO12 (D6)
- **Buzzer**: GPIO14 (D5)

---

## Setup Instructions

### 1. Install Required Libraries
Ensure the following libraries are installed in your Arduino IDE:
- `Blynk`
- `Servo`
- `ESP8266WiFi`

### 2. Upload Code
1. Open the `main.ino` file in Arduino IDE.
2. Replace the placeholders with your Wi-Fi credentials and Blynk authentication token:
   ```cpp
   char ssid[] = "your_wifi_ssid";
   char pass[] = "your_wifi_password";
   char auth[] = "your_blynk_auth_token";
# Sonar Radar Visualization (Processing 4)

This Processing 4 script visualizes the data from the IoT sonar radar system in a real-time graphical interface. It shows the radar sweep and detected objects on a simulated radar display.

---

## Features
- **Radar Sweep Animation:** Simulates the rotation of the ultrasonic sensor.
- **Object Detection Visualization:** Marks the position of detected objects on the radar display.
- **Serial Communication:** Reads distance and angle data from the ESP8266 via a serial connection.

---

## Software Requirements
- [Processing 4](https://processing.org/download/)
- ControlP5 library (for graphical controls if needed):
  - Install via the Processing IDE: `Sketch > Import Library > Add Library... > Search "ControlP5"`

---

## Setup Instructions

### 1. Connect Your Hardware
- Ensure the ESP8266 is connected to your computer via USB or serial communication.
- Confirm the serial port used by your device (e.g., COM3, /dev/ttyUSB0).

### 2. Configure the Code
1. Open the `sonar_radar.pde` file in Processing 4.
2. Update the serial port name in the code:
   ```java
   import processing.serial.*;

   Serial myPort;

   void setup() {
       myPort = new Serial(this, "COM3", 9600); // Replace "COM3" with your device's port
   }
