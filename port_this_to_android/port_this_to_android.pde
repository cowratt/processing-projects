PVector circlelocation = new PVector(0,0);
PVector position;
PVector offset = new PVector();
int radius;
boolean pickedup = false;
int circleydircle;
String directiontext = "";
float pointing;
void setup(){
  size(displayWidth,displayHeight);
  position = new PVector(width/2,height/2);
  circleydircle = min(width,height) * 9 / 10;
  textSize(100);
  textAlign(CENTER,CENTER);
  radius = circleydircle *2/ 5;
  frameRate(60);
}

void draw(){
  background(150);
  fill(200);
  noStroke();
  ellipse(width/2,height/2,circleydircle,circleydircle);
  circlelocation.set(position.x - width/2, position.y - height/2);
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
  strokeWeight(80);
  line(width/2, height/2 + circleydircle * 4 / 10, width/2, height/2 - circleydircle*4/10);
  line(width/2 + circleydircle * 4 / 10, height/2 , width/2 - circleydircle*4/10, height/2 );
  //return to center gently
  if(!pickedup){
    position.x = position.x - (position.x - width/2)/5;
    position.y = position.y - (position.y - height/2)/5;
  }
  
  stroke(0);
  strokeWeight(5);
  fill(150);
  ellipse(position.x, position.y,radius,radius);
  fill(50);
  text(circlelocation.heading(), width/2, height/7);
  //fill(#41A0B2);
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

void direction()
{
  pointing = circlelocation.heading();
  if(0.785 < pointing && 2.35 > pointing){directiontext = "DOWN";}
  if(-0.785 > pointing && -2.35 < pointing){directiontext = "UP";}
  if(abs(pointing) > 2.35){directiontext = "LEFT";}
  if(abs(pointing) < 0.785){directiontext = "RIGHT";}
  
  String str2 = "";
  if(circlelocation.mag() < circleydircle / 8){str2 = "";directiontext = "neutral";}
  if(circlelocation.mag() > circleydircle / 8){str2 = " speed 1";}
  if(circlelocation.mag() > circleydircle / 4){str2 = " speed 2";}
  
  
  text(directiontext + str2, width/2, height*6/7);
}