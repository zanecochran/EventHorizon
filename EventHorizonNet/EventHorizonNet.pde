float netSpace = 2.4;
float scale = 2;
float netSize = 242.4;

boolean isFrame = true;
boolean isNet = true;
boolean isPixel = true;
boolean isAnchor = true;
boolean isAttachment = true;

int totalLEDs = 0;
int ledsPerRow = 0;
int totalAnchors = 0;
int totalAttachments = 0;

void setup(){
  size(600, 600);
}

void draw(){
  ellipseMode(CENTER);
  translate(abs(netSize * 2 - width)/2 , abs(netSize * 2 - width)/2);
  background(0);
  
  noFill();
  stroke(255);
  
  // Frame
  if(isFrame){rect(0, 0, netSize * scale, netSize * scale);}

  // Netting
  if (isNet){
    stroke(50);
    for(int x = 1; x < 100; x++){
      for (int y = 1; y < 100; y++){
        rect(x * netSpace * scale, y * netSpace * scale, netSpace * scale, netSpace * scale);
      }
    }
  }

  // Pixel
  if (isPixel){
    totalLEDs = 0;
    ledsPerRow = 0;
    stroke(255, 0, 0);
    for(int x = 3; x < 99; x++){
      ledsPerRow++;
      for (int y = 3; y < 99; y++){
        point(x * netSpace * scale, y * netSpace * scale);
        totalLEDs++;
      }
    }
  }
  
  // Anchor
  if (isAnchor){
    totalAnchors = 0;
    stroke(0, 255, 0);
    for(int x = 10; x < 100; x+=10){
      for (int y = 10; y < 100; y+=10){
        ellipse(x * netSpace * scale, y * netSpace * scale, 2, 2);
        totalAnchors++;
      }
    }
  }
  
  // Attatchment
  if (isAttachment){
    totalAttachments = 0;
    
    stroke(0, 0, 255);
    for(int x = 0; x < 11; x++){ellipse(x * (netSize/10) * scale, 0, 5, 5); totalAttachments++;}
    for(int x = 0; x < 11; x++){ellipse(x * (netSize/10) * scale, netSize * scale, 5, 5); totalAttachments++;}
    for(int y = 1; y < 10; y++){ellipse(0, y * (netSize/10) * scale, 5, 5); totalAttachments++;}
    for(int y = 1; y < 10; y++){ellipse(netSize * scale, y * (netSize/10) * scale, 5, 5); totalAttachments++;}
  }

  
}

void showStats(){
  println("******************************");
  println("Total LEDs: " + totalLEDs); 
  println("LEDs per Row: " + ledsPerRow); 
  println("Total Anchors: " + totalAnchors); 
  println("Total Attachments: " + totalAttachments); 
  println("******************************");
}

void keyPressed(){
  switch(key){
    case '1': isNet = !isNet; break;
    case '2': isPixel = !isPixel; break;
    case '3': isAnchor = !isAnchor; break;
    case '4': isAttachment = !isAttachment; break;
    case '5': isFrame = !isFrame; break;
    case 'p': showStats(); break;
  }
}