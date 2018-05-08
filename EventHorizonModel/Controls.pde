float zoom = 1.8;

void view(){
   translate((width/4), (height/4));
   rotateX(map(mouseY, 0, height, 0, PI));
   rotateZ(map(mouseX, 0, height, 0, PI));
   scale(zoom);
}

void keyPressed(){
  switch(key){
    case '-': zoom-=0.1; break;
    case '=': zoom+=0.1; break;
    case '[': netSpeed-=0.1; break;
    case ']': netSpeed+=0.1; break;
    case ' ': fade = !fade; break;
    case 'n': net = !net; break;
    case 't': trans = !trans; break;
  }
}