import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;
PImage depthMap;

int maxB = 195;
int minB = 175;

float easing = 0.05;  // Gradually change colors (reduces jitter)
float[] grid = new float[100];

boolean isGrid = true;

void setup(){
  size(640, 520);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableIR(true);
  depthMap = new PImage(640, 520, RGB);
  initGrid();
}

void draw(){
  background(0);
  depthMap.copy(kinect.getDepthImage(), 0, 0, 640, 520, 0, 0, 640, 520);

  depthMap.loadPixels();
  
  for (int x = 0; x < width; x++){
    for (int y= 0; y < height; y++){
      int index = x + (y * width);
      float b = brightness(depthMap.pixels[index]);
      color c = color(map(b, minB, maxB, 0, 255));
      depthMap.pixels[index] = c;
    }
  }
  depthMap.updatePixels();
  
  if(isGrid){drawGrid();}
  else{image(depthMap, 0, 0);}
}

void drawGrid(){
  int xOff = 60;
  int yOff = 10;
  int gridSize = 50;
  stroke(255);
  noFill();

  // Sampling
  for (int x = 0; x < 10; x++){
    for (int y = 0; y < 10; y++){
      
      int rX = (x * gridSize) + xOff;
      int rY = (y * gridSize) + yOff;
      
      int gridIndex = x + (y * 10);
      float currentA = grid[gridIndex];
      float targetA = average(rX, rY, gridSize);
      float destA = targetA - currentA;
      float finalA = currentA + (destA * easing);
      grid[gridIndex] = finalA;
      
      fill(finalA);
      rect(rX, rY, gridSize, gridSize);
    }
  }
  
}

void initGrid(){
  for (int i = 0; i < 100; i++){
    grid[i] = 0; 
  }
}

// Given an x and y, returns a sample brightness of that defined sampleSize area
float average(int sX, int sY, int sample){
  float t = 0; // Running Total
  for (int x = sX; x < (sX + sample); x++){
    for (int y = sY; y < (sY + sample); y++){
      int index = x + (y * width);
      float b = brightness(depthMap.pixels[index]);
      t += b;
      //if (b != 0){t += b;}
    }
  }
  return t / (sample * sample);
}