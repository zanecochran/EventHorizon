// Control Program Flow in Kiosk

PVector controlPoint;         // Center Point for initializing mode changes in kiosk
PVector controlCenter;        // Absolute center point to compare with control point
float centerTolerance = 50; // Distance from control center to initialize change
long controlTimer = 0;        // Timer for Control
long controlDuration = 300;  // 3 seconds at Center Point to initialize mode change
float controlEase = 0.1;      // Gradually adjust centerpoint


// Initialze Control Variables
void initControls(){
  controlPoint = new PVector(width/2, height/2);   
  controlCenter = new PVector(width/2, height/2);   
}

// Checks user controls
void checkControls(){
  centerPoint();  // Fetch centerpoint from Kinect
  transitionCounter();
  
}

void transitionCounter(){
  PVector t = new PVector(controlPoint.x + windowX, controlPoint.y + windowY);
  float d = PVector.dist(t, controlCenter);
  if (d < centerTolerance){controlTimer++;}
  else{controlTimer = 0;}
  
  if (controlTimer > controlDuration){
    controlTimer = 0;
    mode = (mode + 1) % 6;
  }
}

// Find and ease centerpoint
void centerPoint(){
  PVector newCenter = kinectPoint();

  float dx = newCenter.x - controlPoint.x;
  controlPoint.x += dx * controlEase;
  
  float dy = newCenter.y - controlPoint.y;
  controlPoint.y += dy * controlEase;
  
  ellipse(controlCenter.x, controlCenter.y, centerTolerance, centerTolerance);
  ellipse(controlPoint.x + windowX, controlPoint.y + windowY, 10, 10);
}

// Admin Key Commands
void keyPressed(){
  switch(key){
    case 'c': showCrop = !showCrop; println("showCrop: " + showCrop); break; 
  }
}
