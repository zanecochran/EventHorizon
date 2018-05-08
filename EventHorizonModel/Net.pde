int netW = 240;
int netH = 240;
int netInt = 3;
int netMax = 48;
int netMin = 1;
float netSpeed = 0.3;
boolean fade = true;
boolean net = false;
boolean trans = false;

ArrayList<Node> nodes;

void initNodes(){
  nodes = new ArrayList<Node>(); 
  for (int x = 0; x < netW; x+=netInt){
    for (int y = 0; y < netH; y+=netInt){
      Node n = new Node(x, y, random(netMin, netMax));
      nodes.add(n);
      rect(x, y, netInt, netInt);
    }
  }
  println(nodes.size());
}

void drawNodes(){
  for (int i = 0; i < nodes.size(); i++){
    Node n = nodes.get(i);
    n.draw();
    n.move();
  }
}

void drawNets(){
  for (int i = 1; i < nodes.size(); i++){
    if(i % (netW/netInt) != 0){
      Node n1 = nodes.get(i);
      Node n2 = nodes.get(i - 1);    
      stroke(255, 0, 255, 20);
      line(n1.pos.x, n1.pos.y, n1.pos.z, n2.pos.x, n2.pos.y, n2.pos.z);
    }
  }
  
  for (int i = (netW/netInt); i < nodes.size(); i++){
    if(i % (netW/netInt) != 0){
      Node n1 = nodes.get(i);
      Node n2 = nodes.get(i - (netW/netInt));    
      stroke(255, 0, 255, 20);
      line(n1.pos.x, n1.pos.y, n1.pos.z, n2.pos.x, n2.pos.y, n2.pos.z);
    }
  }
    
}

class Node{
  PVector pos;
  float c;
  boolean dir;
  float speed;
  
  Node(float x, float y, float z){
    pos = new PVector(x, y, z);
    if(random(2) == 1){dir = false;}
    else{dir = true;}
    speed = random(-0.25, 0.25);
  }
  
  void draw(){
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      noStroke();
      if (trans){fill(c, 255, 255, c);}
      if (fade){fill(c, 255, c + 50);}
      else{fill(c, 255, 255);}
      box(1.5);
    popMatrix();
  }
  
  void move(){
    c = map(pos.z, netMin, netMax, 0, 200);
    if(dir){pos.z+=(netSpeed + speed);}
    else{pos.z-=(netSpeed + speed);}
    if (pos.z > netMax || pos.z < netMin){dir = !dir;}
  }
  
}

void drawNet(){
  for (int x = 0; x < netW; x+=netInt){
    for (int y = 0; y < netH; y+=netInt){
      noFill();
      stroke(255);
      rect(x, y, netInt, netInt);
    }
  }
}