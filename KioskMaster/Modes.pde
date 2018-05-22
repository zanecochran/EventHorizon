// Mode 0 - Startup & Initialize

void startup(){
  if (isChange){
    msg = "0";
    sendData();
    
    isChange = false; 
  }
  else {
    mode = 1;
  }
}
