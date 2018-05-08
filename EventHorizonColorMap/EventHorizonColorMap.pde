PImage map;
float size = 30;
int colorScale = 255;

void setup(){
  size(96, 96);
  map = new PImage(96, 96, RGB);
  initImage();
}

void draw(){
  background(0);
  
  map.loadPixels();
  
  for (int i = 0; i < map.pixels.length; i++){
    int thisX = i % width;
    int thisY = i / width;
    float d = dist(mouseX, mouseY, thisX, thisY);
    color c = map.pixels[i];
    float h = (int)brightness(c);
    float newH = 0;
    
    if (d < size){newH = min(h + (size - d), colorScale);}
    else{newH = max(h - 1, 0);}
    
    color newC = color(newH);
    map.pixels[i] = newC;      
  }

  map.updatePixels();
  
  image(map, 0, 0, width, height);
  
}


void initImage(){
  map.loadPixels();
  for (int i = 0; i < map.pixels.length; i++){
    map.pixels[i] = color(0); 
  }
  map.updatePixels();
}