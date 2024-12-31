import processing.serial.*;

Serial myPort; // Declare a Serial object
String data = ""; // Raw data from ESP8266
int iAngle = 0; // Parsed angle
int iDistance = 0; // Parsed distance
float pixsDistance = 0; // Distance in pixels

void setup() {
  size(1200, 700);
  smooth();
  myPort = new Serial(this, "COM6", 115200); // Update COM port
  myPort.bufferUntil('.'); // Read data until a '.' is encountered
}

void draw() {
  background(0); // Clear the screen
  drawSonar();   // Draw the sonar grid
  drawObject();  // Draw detected objects
  drawLine();    // Draw the moving line
  drawText();    // Display text
   fill(255);
   textSize(30);
   text("SONAR RADAR USING ESP8266", 700, 50);
   textSize(26);
   text("Contributers : ", 700, 80);
   text("YourName", 700, 105);
   text("YourName", 700, 130);
   text("YourName", 700, 155);
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.'); // Read incoming data
  if (data != null) {
    data = trim(data); // Remove unwanted characters
    int index1 = data.indexOf(",");
    if (index1 != -1) {
      try {
        iAngle = int(data.substring(0, index1)); // Parse angle
        iDistance = int(data.substring(index1 + 1)); // Parse distance
      } catch (Exception e) {
        println("Parsing Error: " + e.getMessage());
      }
    }
  }
}

void drawSonar() {
  int r;
  pushMatrix();
  translate(width / 2, height - height * 0.1);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  for ( r = 1; r <= 4; r++) {
    float radius = r * 150;
    arc(0, 0, radius, radius, PI, TWO_PI);
  }
  for (int angle = 0; angle <= 180; angle += 30) {
    line(0, 0, 300 * cos(radians(angle)), -300 * sin(radians(angle)));
    textSize(22);
    fill(0,255,0);
    text(angle+"°",300 * cos(radians(angle))-10, -300 * sin(radians(angle))-10);
  }
   r = 40;
  for(int k = 0 ; k<4; k+=1,r-=10)
  {
    text(r+"cm", -300 + (k*75), 30);
  }
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.1);
  noStroke();
  fill(255, 10, 10); // Red color for detected object
  pixsDistance = iDistance * 8; // Scale distance to pixels
  if (iDistance > 0 && iDistance < 200) {
    float x = pixsDistance * cos(radians(iAngle));
    float y = -pixsDistance * sin(radians(iAngle));
    ellipse(x, y, 20, 20); // Draw the object
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  translate(width / 2, height - height * 0.1);
  strokeWeight(2);
  stroke(98, 245, 31);
  line(0, 0, 300 * cos(radians(iAngle)), -300 * sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  fill(255);
  textSize(26);
  if (iDistance > 0 && iDistance < 200) {
    text("Angle: " + iAngle + "°", 50, 30);
    text("Distance: " + iDistance + " cm", 50, 50);
  } else {
    text("No object detected", 50, 30);
  }
}
