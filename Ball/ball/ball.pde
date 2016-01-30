boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
PVector position = new PVector(0,0);
PVector velocity = new PVector(0,0);
PVector tempvel = new PVector(0,0);
float decay;

public void setup(){
  size(500,500);
  background(33, 141, 155);
  strokeWeight(3);
  textSize(15);  
  fill(125, 218, 229);
}
void draw(){
  if( !mousePressed){
    background(33, 141, 155);  
  }
  mouse.set(mouseX, mouseY);
  if(keyPressed){
    decay = 1.0;
  }
  else if(true){
    decay = 0.9;
  }
  velocity.x = (mouse.x - position.x + velocity.x) * decay;
  velocity.y = (mouse.y - position.y + velocity.y) * decay;
  tempvel.set(velocity);
  
  position.add(tempvel.mult(0.1));
  ellipse(position.x, position.y, 50, 50);
  text(frameRate, 30, 30);
  text(mouse.y, 30, 60);
  text(velocity.y, 30, 90);
  
}