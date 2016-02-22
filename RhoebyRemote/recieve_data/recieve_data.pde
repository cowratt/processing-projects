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
int test;
int totalpackets = 0;

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
String Text = "Nothing yet";
String meaning = "";

void setup(){
  size(displayWidth,displayHeight);
  orientation(PORTRAIT);
  textSize(width/10);
  fill(150);
  bt.start();
  bt.makeDiscoverable();
  textAlign(CENTER,CENTER);
}


void draw(){
  textSize(width/12);
  background(80);
  text(Text,width/2,height/2);
  textSize(width/6);
  text(meaning,width/2,height*4/5);
  textSize(width/10);
  text("Total packets:" + totalpackets,width/2,height/5);
}

void onBluetoothDataEvent(String who, byte[] data){
  Text = "";
  for(byte b : data){
  Text+=(Integer.toBinaryString(b & 255 | 256).substring(1));
  Text+="\n";
  }
  if(data[0]==(byte)0xFF && data[1] == (byte)0xFF && data[3] == (byte)0 && data[4] == (byte)0){
    
    if(data[2] == (byte)0x80) meaning="FORWARD";
    else if(data[2] == (byte)0x81) meaning="BACKWARD";
    else if(data[2] == (byte)0x82) meaning="LEFT";
    else if(data[2] == (byte)0x83) meaning="RIGHT";
    else if(data[2] == (byte)0x84) meaning="STOP";
  }
  else if(data[0] == 0x67 && data[1] == 0x67 && data[2] == 0x67) meaning="\"GGG\"";
  else meaning="PANIC!";
  totalpackets+=1;
}