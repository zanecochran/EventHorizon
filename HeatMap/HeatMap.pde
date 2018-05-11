PImage scatterImage;
ArrayList<pixel> scatter;
float tol = 20;

void setup(){
  size(96, 96);
  scatterImage = new PImage(96, 96, RGB);
  initPixels();
}

void  draw(){
  background(0);

  checkPixels();
  fillImage();
  image(scatterImage, 0, 0);
}