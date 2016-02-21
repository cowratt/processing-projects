import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import oscP5.*;
KetaiBluetooth bt;
KetaiList klist;
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}
//ArrayList<String> devicesDiscovered = new ArrayList();


PVector circlelocation = new PVector(0,0);
PVector position;
PVector offset = new PVector();
int radius;
boolean pickedup = false;
int circleydircle;
String directiontext = "";
float pointing;
boolean starting = true;

void setup(){
  size(displayWidth,displayHeight);
  orientation(PORTRAIT);
  position = new PVector(width/2,height/2);
  circleydircle = min(width,height) * 9 / 10;
  textSize(circleydircle/10);
  textAlign(CENTER,CENTER);
  radius = circleydircle *2/ 5;
  //frameRate(60);
}

void draw(){
  if(!starting)
    runapp();
  else startup();

}

void startup(){
  background(20);
  if (bt.getDiscoveredDeviceNames().size() > 0){
      klist = new KetaiList(this, bt.getDiscoveredDeviceNames());
      starting = false;
}
   else if (bt.getPairedDeviceNames().size() > 0){
      klist = new KetaiList(this, bt.getPairedDeviceNames());
      starting = false;
   }
}

void runapp(){
  background(150);
  fill(200);
  noStroke();
  ellipse(width/2,height/2,circleydircle,circleydircle);
  
  if(pickedup){
    position.set(mouseX - offset.x, mouseY - offset.y);
    circlelocation.set(position.x - width/2, position.y - height/2);
    if (circlelocation.mag() > circleydircle/2 - radius/2)
    {
      circlelocation.setMag(circleydircle/2 - radius/2);
      position.set(circlelocation.x + width/2, circlelocation.y + height/2);
    }
    
  }
  else circlelocation.set(position.x - width/2, position.y - height/2);
  stroke(190);
  strokeWeight(circleydircle/6);
  line(width/2, height/2 + circleydircle * 4 / 10, width/2, height/2 - circleydircle*4/10);
  line(width/2 + circleydircle * 4 / 10, height/2 , width/2 - circleydircle*4/10, height/2 );
  //return to center gently
  if(!pickedup){
    position.x = position.x - (position.x - width/2)/5;
    position.y = position.y - (position.y - height/2)/5;
  }
  
  stroke(99);
  strokeWeight(circleydircle/100);
  fill(180);
  ellipse(position.x, position.y,radius,radius);
  fill(50);
  //text((pointing + 3.141)*180/3.141, width/2, height/7);
  text(frameRate, width/2, height/7);
  direction();
}



void mousePressed(){
  offset.set(mouseX - position.x,mouseY - position.y);
  if(sq(mouseX - position.x) + sq(mouseY - position.y) < sq(radius/2)){
    pickedup = true;
  }
}
void mouseReleased(){
  pickedup = false;
}
//------------------- gets information from the remote and broadcasts it
void direction()
{
  String last = directiontext;
  pointing = circlelocation.heading();
  if(circlelocation.mag() < circleydircle / 12)  directiontext = "NEUTRAL";
  else if(-0.785 > pointing && -2.35 < pointing) directiontext = "UP";
  else if(abs(pointing) > 2.35)directiontext = "LEFT";
  else if(abs(pointing) < 0.785)directiontext = "RIGHT";
  else if(0.785 < pointing && 2.35 > pointing)directiontext = "DOWN";
  //potential speedbost from only setting up byte array when needed
  
  text(directiontext, width/2, height*6/7);
  
  if(last!=directiontext){
    byte[] Data = {(byte)0xFF,(byte)0xFF,(byte)0 , (byte)0,(byte)0};
    if(directiontext == "DOWN")Data[2] = (byte)0x81;
    else if(directiontext == "UP") Data[2] = (byte)0x80;
    else if(directiontext == "LEFT")Data[2] = (byte)0x82;
    else if(directiontext == "RIGHT")Data[2] = (byte)0x83;
    else if(directiontext == "NEUTRAL") Data[2] = (byte)0x84;
    bt.broadcast(Data);
    
    
    
  }
  
}
//--------------------- List to select device to connect to
void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();
  bt.connectToDeviceByName(selection);

  //dispose of list for now
  klist = null;
}