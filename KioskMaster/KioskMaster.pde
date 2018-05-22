// Event Horizon Kiosk Master Program
// User Interface for Event Horizon Installation
// Zane Cochran


boolean debug = true;      // Turn on/off debugging messages
boolean isServer = false;  // Is there a connected server?

int mode = 0;              // Current state in program 
int lastMode = -1;         // Last state in program
boolean isChange = true;  // Did the state change?

void setup(){
  size(640, 520);
  
  initSerial();                // Initialize Serial Communication with Arduino
  initKinect();                // Initialize Kinect
  initControls();              // Initialize Control Variables
  if(isServer){initClient();}  // Initialize Client/Server Communication
  
}

void draw(){
  background(0);

  loadDepth();  // Load Depth Map Values from Kinect
  showDepth();  // Show the Depth Map
  
  checkControls();
  
  switch(mode){
    case 0: startup(); break;  // Startup & Initialize
    case 1: break;  // Neutral
    case 2: break;  // Wave
    case 3: break;  // User Topo
    case 4: break;  // Video
    case 5: break;  // User Draw
  }
  
  if (mode != lastMode){
    println("Current Mode: " + mode);
    lastMode = mode;
    sendLED(mode);
    isChange = true;
  }
  
}
