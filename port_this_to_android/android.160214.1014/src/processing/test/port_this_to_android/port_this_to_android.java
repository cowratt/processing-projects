package processing.test.port_this_to_android;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class port_this_to_android extends PApplet {

PVector circlelocation = new PVector(0,0);
PVector position;
PVector offset = new PVector();
int radius;
boolean pickedup = false;
int circleydircle;
String directiontext = "";
float pointing;
public void setup(){
  
  position = new PVector(width/2,height/2);
  circleydircle = min(width,height) * 9 / 10;
  textSize(100);
  textAlign(CENTER,CENTER);
  radius = circleydircle / 3;
}

public void draw(){
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
  stroke(190);
  strokeWeight(50);
  line(width/2, height/2 + circleydircle * 4 / 10, width/2, height/2 - circleydircle*4/10);
  line(width/2 + circleydircle * 4 / 10, height/2 , width/2 - circleydircle*4/10, height/2 );
  
  
  stroke(0);
  strokeWeight(5);
  fill(150);
  ellipse(position.x, position.y,radius,radius);
  fill(50);
  text(circlelocation.heading(), width/2, height/7);
  //fill(#41A0B2);
  direction();
  
}
public void mousePressed(){
  offset.set(mouseX - position.x,mouseY - position.y);
  if(sq(mouseX - position.x) + sq(mouseY - position.y) < sq(radius/2)){
    pickedup = true;
  }
}
public void mouseReleased(){
  pickedup = false;
}

public void direction()
{
  pointing = circlelocation.heading();
  if(0.785f < pointing && 2.35f > pointing){directiontext = "DOWN";}
  if(-0.785f > pointing && -2.35f < pointing){directiontext = "UP";}
  if(abs(pointing) > 2.35f){directiontext = "LEFT";}
  if(abs(pointing) < 0.785f){directiontext = "RIGHT";}
  
  
  
  text(directiontext, width/2, height*6/7);
}
  public void settings() {  size(displayWidth,displayHeight); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "port_this_to_android" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
