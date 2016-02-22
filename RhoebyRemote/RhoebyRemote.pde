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
int globalScale;
String directiontext = "";
float pointing;
button gggbutton;
button startscannerbutton;
button stopscannerbutton;
button showdatabutton;
String RecievedData = "";
int mode = 1;
String hexStr = "";
int noot = 0;
void setup(){
  size(displayWidth,displayHeight);
  orientation(PORTRAIT);
  position = new PVector(width/2,height/2);
  globalScale = min(width,height) * 9 / 10;
  textSize(globalScale/10);
  textAlign(CENTER,CENTER);
  radius = globalScale *2/ 5;
  gggbutton = new button("\"GGG\"",width/5,height/6,globalScale/3,globalScale/6);
  startscannerbutton = new button("START", width/5,5*height/6,globalScale/3,globalScale/6);
  stopscannerbutton = new button("STOP", 4*width/5,5*height/6,globalScale/3,globalScale/6);
  showdatabutton = new button("DATA", 4*width/5,height/6,globalScale/3,globalScale/6);
  
}

void draw(){
  if(mode==0) runapp();
  else if(mode==1) startup();
  else if(mode==2) showData();

}
void showData(){
  background(150);
  textSize(globalScale/20);
  text(RecievedData, width/2,height/2,width/2,height/2);
  if(!mousePressed) {mode = 0;textSize(globalScale/10);frameRate(60);}
}


void startup(){
  background(20);
  if (bt.getDiscoveredDeviceNames().size() > 0){
      klist = new KetaiList(this, bt.getDiscoveredDeviceNames());
      mode = 0;
}
   else if (bt.getPairedDeviceNames().size() > 0){
      klist = new KetaiList(this, bt.getPairedDeviceNames());
      mode = 0;
   }
}

void runapp(){
  background(150);
  fill(200);
  noStroke();
  ellipse(width/2,height/2,globalScale,globalScale);
  gggbutton.Draw();
  startscannerbutton.Draw();
  stopscannerbutton.Draw();
  showdatabutton.Draw();
  if(showdatabutton.clicked) mode=2;
  if(pickedup){
    position.set(mouseX - offset.x, mouseY - offset.y);
    circlelocation.set(position.x - width/2, position.y - height/2);
    if (circlelocation.mag() > globalScale/2 - radius/2)
    {
      circlelocation.setMag(globalScale/2 - radius/2);
      position.set(circlelocation.x + width/2, circlelocation.y + height/2);
    }
    
  }
  else circlelocation.set(position.x - width/2, position.y - height/2);
  stroke(190);
  strokeWeight(globalScale/6);
  line(width/2, height/2 + globalScale * 4 / 10, width/2, height/2 - globalScale*4/10);
  line(width/2 + globalScale * 4 / 10, height/2 , width/2 - globalScale*4/10, height/2 );
  //return to center gently
  if(!pickedup){
    position.x = position.x - (position.x - width/2)/5;
    position.y = position.y - (position.y - height/2)/5;
  }
  stroke(99);
  strokeWeight(globalScale/100);
  fill(180);
  ellipse(position.x, position.y,radius,radius);
  fill(50);
  //text((pointing + 3.141)*180/3.141, width/2, height/7);
  //text(frameRate, width/2, height/7);
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
  if(circlelocation.mag() < globalScale / 12)  directiontext = "NEUTRAL";
  else if(-0.785 > pointing && -2.35 < pointing) directiontext = "UP";
  else if(abs(pointing) > 2.35)directiontext = "LEFT";
  else if(abs(pointing) < 0.785)directiontext = "RIGHT";
  else if(0.785 < pointing && 2.35 > pointing)directiontext = "DOWN";
  //potential speedbost from only setting up byte array when needed
  
  
  
  
  
  //text(directiontext, width/2, height*6/7);
  
  if(last!=directiontext){
    byte[] Data = {(byte)0xFF,(byte)0xFF,(byte)0 , (byte)0,(byte)0};
    if(directiontext == "DOWN")Data[2] = (byte)0x81;
    else if(directiontext == "UP") Data[2] = (byte)0x80;
    else if(directiontext == "LEFT")Data[2] = (byte)0x82;
    else if(directiontext == "RIGHT")Data[2] = (byte)0x83;
    else if(directiontext == "NEUTRAL") Data[2] = (byte)0x84;
    Data[4] = (byte)~(Data[0] + Data[1] + Data[2] + Data[3]);
    
    for(int i=1;i<11;i++){
    bt.broadcast(Data);
    }
    
  }
  if(gggbutton.clicked){
    byte[] Data = {0x67,0x67,0x67};
    bt.broadcast(Data);    
  }
  if(startscannerbutton.clicked){
    byte[] Data = {(byte)0xFF, (byte)0xFF, (byte)0x00, (byte)0x00, (byte)0x00};
    Data[4] = (byte)~(Data[0] + Data[1] + Data[2] + Data[3]);
    bt.broadcast(Data);
  }
  if(stopscannerbutton.clicked){
    byte[] Data = {(byte)0xFF, (byte)0xFF, (byte)1, (byte)0x00, (byte)0x00};
    Data[4] = (byte)~(Data[0] + Data[1] + Data[2] + Data[3]);
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

//---------------------recieve data

void onBluetoothDataEvent(String who, byte[] data){
  if(mode==2 && noot < 2){
    for(int i=1; i<50;i++){
      RecievedData += hex(data[i]);
    }
    noot+=1;
  }
}


//------------------------button class
class button {
    String label;
    float x;        // center x position
    float y;        // center y position
    float w;        // width of button
    float h;        // height of button
    boolean clicked = false;
    boolean pressed = false;
    button(String labelB, float xpos, float ypos, float widthB, float heightB) {
        label = labelB;
        x = xpos;
        y = ypos;
        w = widthB;
        h = heightB;
        rectMode(CENTER);
        textAlign(CENTER,CENTER);
    }
    void Draw() {
        if(clicked==true) clicked=false;
        mouse();
        if(pressed) fill(200);
        else fill(100);
        rect(x,y,w,h,10);
        fill(150);
        text(label,x,y);
    }
    void mouse(){
      if (mousePressed && pressed==false && abs(mouseX - x) < w/2 && abs(mouseY - y) < h/2){
        pressed = true;
        clicked = true;
      }
     else if(!mousePressed) pressed=false;
    }
}