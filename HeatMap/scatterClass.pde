void initPixels(){
  scatter = new ArrayList<pixel>();
  for (int x = 0; x < scatterImage.width; x++){
    for (int y = 0; y < scatterImage.height; y++){
      pixel p = new pixel(y, x);
      scatter.add(p);
    }
  }
}

void fillImage(){
  scatterImage.loadPixels();
  for (int i = 0; i < scatter.size(); i++){
    pixel p = scatter.get(i);
    colorMode(HSB, 255);
    scatterImage.pixels[i] = color(p.h, 255, 255);
  }
  scatterImage.updatePixels();
}

void checkPixels(){
  for (int i = 0; i < scatter.size(); i++){
    pixel p = scatter.get(i);
    float d = dist(mouseX, mouseY, p.pos.x, p.pos.y);
    if(d < tol){
      p.h = min((p.h + ((tol - d)*0.5)), 200);
    }
    else{
      p.h = max(p.h - 0.5, 0); 
    }
  }
}

class pixel{
  PVector pos;  // Position
  float h;    // Hue
  
  pixel(int x, int y){
    pos = new PVector(x, y);
    h = 0;
  }
  
  
  
  
}