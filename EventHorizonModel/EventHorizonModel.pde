// EventHorizon
// Zane Cochran
// Interactive Art Installation


void setup(){
  size(800, 800, P3D);
  colorMode(HSB, 255);
  lights();
  initNodes();
}


void draw(){
  background(0);
  view();
  if(net){drawNets();}
  drawNodes();
}