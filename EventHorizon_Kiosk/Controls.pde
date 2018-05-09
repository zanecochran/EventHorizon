void keyPressed(){
  switch(key){
    case ' ': isGrid = !isGrid; break;
    case '=': break;
  }
}

void mousePressed(){
  int index = mouseX + (mouseY * width);
  depthMap.loadPixels();
  float b = brightness(depthMap.pixels[index]);
  println(b);
}