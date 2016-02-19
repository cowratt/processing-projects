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
  background(80);
  text(Text,width/2,height/2);
  textSize(width/6);
  text(meaning,width/2,height*2/3);
  textSize(width/10);
  text(test,width/2,height*3/4);
}

void onBluetoothDataEvent(String who, byte[] data){
  Text = "";
  for (byte b : data) {
    Text+=(Integer.toBinaryString(b & 255 | 256).substring(1));
    //Text+="\n";
  }
  test = Integer.parseInt(Text,2);
  if(test==128){meaning="FORWARD";}
  else if(test==129){meaning="BACKWARD";}
  else if(test==130){meaning="LEFT";}
  else if(test==131){meaning="RIGHT";}
  else if(test==132){meaning="STOP";}
  else{meaning="PANIC!";}
  
  
}