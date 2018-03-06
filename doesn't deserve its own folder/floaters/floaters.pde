ArrayList<airParticle> a = new ArrayList<airParticle>();
boolean mousemoved = false;
int framesSinceMouseMoved;
int TotalMouseMovedFrames;
void setup(){
  size(1400, 800);
  colorMode(HSB, 360, 100, 100, 100);
  textSize(50);
  textAlign(CENTER,CENTER);
}


void draw(){
  print(frameRate + "\n");

  a.add(new airParticle((int)random(width), (int)random(height), random(-5,5), random(-5,5)));
  background(70);
  noStroke();
    fill(color(0,0,80,(TotalMouseMovedFrames - 1300) / 8));
    text("You Add the color to my life", width/2, height/2);
  for(int i = a.size(); i >0; i--){
    a.get(i - 1).live();
    if(a.get(i - 1).isOffScreen()) a.remove(i - 1);
  }
  framesSinceMouseMoved++;
  if(framesSinceMouseMoved > 10)
  mousemoved = false;
  
}
void mousePressed(){
  a.add(new airParticle(mouseX, mouseY, random(-5,5), random(-5,5)));
}
void mouseMoved(){
  mousemoved = true;
  framesSinceMouseMoved = 0;
  TotalMouseMovedFrames++;
}

class airParticle{
  PVector position;
  PVector velocity = new PVector(0,0);
  int age;
  int fadein = 50;
  int randomSeed1;
  int randomSeedx;
  int randomSeedy;
  float size;
  color col;
  airParticle(int posX, int posY, float velX, float velY){
    position = new PVector(posX, posY);
    //velocity.set(velX, velY);
    randomSeed1 = (int)random(-50000000, 50000000);
    randomSeedx = (int)random(-50000000, 50000000);
    randomSeedy = (int)random(-50000000, 50000000);
    size = (random(0.2, 1)); //bias towards small
    size = size *30;
    col = color(0,0,100,0);
    
  }
  void live(){
    //fuck, I wrote this yesterday and I've already forgotten how it works
    
    position.add(velocity);
    //okay this is the wind movement
    position.add(10.0*noise((randomSeedx + frameCount) / 100.0) - 5, 10.0*noise((randomSeedy + frameCount) / 100.0) - 5);
    //this is the mouse repel
    if(mousemoved && position.dist(new PVector(mouseX, mouseY)) < 150){
      PVector tempVel = velocity.copy();
      //the fact that these are being computed seperately is fucking shit up. Fixed with the above if statement
      velocity.add(constrain((8.0/(position.x - mouseX)), -.1, .1), constrain((8.0/(position.y - mouseY)), -.1, .1));
      tempVel.sub(velocity);
      //if(tempVel.mag() > 1){
        col = color((degrees(tempVel.heading()) + frameCount / 10.0) % 360, saturation(col) + tempVel.mag()*23, 100, 0);
      //}
    }
    float brightness = min(10.0*age, noise((randomSeed1 + frameCount) / 30.0)*200.0 - 50.0);
    col = color(hue(col), saturation(col) - 0.5, 100, brightness);
    fill(col);
    ellipse(position.x,position.y,size/2 + constrain(brightness,0,100)*size/200, size/2 + constrain(brightness,0,100)*size/200);
    age++;
  }
  boolean isOffScreen(){
    if(position.x > width + 100 || position.x < -1  -100 || position.y > height + 100 || position.y < -100) return true;
    else return false;
  }
}