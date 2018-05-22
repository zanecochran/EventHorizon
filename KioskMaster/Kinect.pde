import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;    // Create Kinect Object
PImage depthMap;  // PImage to store depth map

// Depth Calibration Values - Used to constrain narrow depth changes in membrane
boolean depthCalib = true;  // Use distance calibration to constrain depthMap
int maxD = 210;  // Max distance from Kinect (AVG val + 10)
int minD = 190;  // Min distance from Kinect (AVG val - 10)

// Calibration Window - Used to crop out the edges of the depth map
int windowX = 75;      // Min x Value in Window
int windowY = 15;      // Min y Value in Window
int windowSize = 500;  // Window size
boolean showCrop = true; // Show Cropped Image

// Initialize Kinect and depthMap Image
void initKinect(){
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableIR(true);
  depthMap = new PImage(windowSize, windowSize, RGB);
}

// Fetch Depth Map Values from Kinect and Normalize
void loadDepth(){
  depthMap.copy(kinect.getDepthImage(), windowX, windowY, windowX + windowSize, windowY + windowSize, 0, 0, windowSize, windowSize);
  
  if(depthCalib){  // User maxD and minD to contstrain distance values of depthMap image
    depthMap.loadPixels();
    for (int x = 0; x < depthMap.width; x++){
      for (int y= 0; y < depthMap.height; y++){
        int index = x + (y * depthMap.width);
        float b = brightness(depthMap.pixels[index]);
        color c = color(map(b, minD, maxD, 0, 255));
        depthMap.pixels[index] = c;
      }
    }
    depthMap.updatePixels();
  }
  
}

// Display the Depth Map Image
void showDepth(){
  if(showCrop){
    image(depthMap, (width - depthMap.width)/2, (height - depthMap.height)/2);
  }
  else{image(kinect.getDepthImage(), 0, 0);}
}

// Returns the X/Y Coordinate of lowest point on Kinect
PVector kinectPoint(){
  depthMap.loadPixels();
  PVector pos = new PVector(0, 0);
  float maxD = 0.0;
  
  for (int x = 0; x < depthMap.width; x++){
    for (int y = 0; y < depthMap.height; y++){
      int index = x + (y * depthMap.width);
      float thisD = brightness(depthMap.pixels[index]);
      if (thisD > maxD){
        maxD = thisD;
        pos.x = x;
        pos.y = y;
      }
    }
  }
  return pos;
}
