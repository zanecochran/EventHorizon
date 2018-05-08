import processing.net.*;

Server s;
Client c;
String input;
int data[];
int boxes[] = new int[100];

void setup() 
{
  size(100, 100);
  frameRate(5); // Slow it down a little
  s = new Server(this, 12345); // Start a simple server on a port
  for (int i = 0; i < 100; i++){
    boxes[i] = 0; 
  }
}

void draw() 
{
  background(0);
  
  for (int x = 0; x < 10; x++){
    for (int y = 0; y < 10; y++){
      int index = x + (y * 10);
      fill(boxes[index]);
      rect(x * 10, y * 10, 10, 10);
    }
  }
  
  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    data = int(split(input, ' ')); // Split values into an array
    arrayCopy(data, boxes);
  }
}