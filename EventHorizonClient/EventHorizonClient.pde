import processing.net.*;

Client c;
String input;
String serverIP = "127.0.0.1";
int boxes[] = new int[100];
boolean sendData = false;

void setup() 
{
  size(100, 100);
  frameRate(30); // Slow it down a little
  c = new Client(this, serverIP, 12345); 
  for (int i = 0; i < 100; i++) {
    boxes[i] = 0;
  }
}

void draw() 
{
  for (int x = 0; x < 10; x++) {
    for (int y = 0; y < 10; y++) {
      int index = x + (y * 10);
      fill(boxes[index]);
      rect(x * 10, y * 10, 10, 10);
    }
  }

  if (sendData) {
    String msg = "";
    for (int i = 0; i < 100; i++) {
      if (i == 0) {
        msg += "" + boxes[0];
      } else {
        msg += " " + boxes[i];
      }
    }
    c.write(msg + "\n");
    sendData = false;
  }

  if (mousePressed) {
    int x = mouseX/10;
    int y = mouseY/10;
    int index = x + (y * 10);
    try {
      boxes[index] = (boxes[index] + 25) % 255;
    } 
    catch(Exception e) {
    }
    sendData = true;
  }
}