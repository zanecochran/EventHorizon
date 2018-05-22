// Client-Server Commands

import processing.net.*;
Client c;
String msg;  // Message to send server
String ipAddress = "127.0.0.1";
int port = 12345;

// Initialize Client-Server Communication
void initClient(){
  c = new Client(this, ipAddress, port); // Replace with your server's IP and port
}

// Send data from msg to the server
void sendData(){
  try{c.write(msg);}
    catch (NullPointerException e){
      println("Couldn't connect to server.");
    }
  if(debug){println("Sending Server: " + msg);}
  msg = "";      // Clear message string
}
