//required for BT enabling on startup
import android.content.Intent;
import android.os.Bundle;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

import oscP5.*;
KetaiBluetooth bt;
String info = "";
KetaiList klist;
PVector remoteMouse = new PVector();

ArrayList<String> devicesDiscovered = new ArrayList();
boolean isConfiguring = true;
String UIText;

//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}

String test = "";
int scaler;
boolean once = true;
void setup(){
  size(displayWidth, displayHeight);
  orientation(PORTRAIT);
  textSize(24);
  scaler = min(width,height);
  fill(#E07A86);
  bt.start();
  bt.makeDiscoverable();
  bt.discoverDevices();
  textSize(50);
}
void draw(){
  background(150);
  if (test !=""){fill(#8FD3A4);}
  else{fill(#E07A86);}
  ellipse(width/2,height/2,scaler/3,scaler/3);
  text(test,width/2,height/6);
  if (bt.getDiscoveredDeviceNames().size() > 0 && once){
      klist = new KetaiList(this, bt.getDiscoveredDeviceNames());
      once = false;
}
   else if (bt.getPairedDeviceNames().size() > 0 && once){
      klist = new KetaiList(this, bt.getPairedDeviceNames());
      once = false;
   }
   test = "";
}
void mousePressed(){
  byte[] bytes = {0x67, 0x22};
  

  
  //bt.discoverDevices();
  bt.broadcast(bytes);
  
}


void onBluetoothDataEvent(String who, byte[] data)
{
for (byte b : data) {
    test = "";
    test+=(Integer.toBinaryString(b & 255 | 256).substring(1));
}
}
void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();
  bt.connectToDeviceByName(selection);

  //dispose of list for now
  klist = null;
}