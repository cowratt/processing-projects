floater f;
floater g;
ArrayList<floater> list;
int radius = 25;
int NumberOfParticles = 100;
PVector mouse = new PVector();
void setup(){
    colorMode(HSB, 360, 100, 100);
    list = new ArrayList<floater>();
    size(1280, 720);
    for(int i=0; i<NumberOfParticles; i++){
        list.add(new floater());
    }
    f = new floater();
    g = new floater();
    stroke(1);

}

void draw(){
  
  if(!mousePressed){
  background(200);
  }
  mouse.set(mouseX, mouseY);
  for(int i=0; i<NumberOfParticles; i++){
      floater Q = list.get(i);
      Q.live();
      for(int j=i; j< NumberOfParticles; j++){
          floater R = list.get(j);
          Q.collide(R);
      }
  }

}
void mousePressed(){
  noStroke();
  background(200);
}
void mouseReleased(){
  stroke(1);
}

class floater{
  PVector velocity = new PVector(random(-1, 1), random(-1, 1));
  PVector position = new PVector(random(width), random(height));
  float flote;
  PVector temp = new PVector();
  PVector temp2 = new PVector();
  PVector accel = new PVector();
  color colour;

  floater(){
    colour = color(random(360), 40, 80);

  }

  void live(){
      //orbit part
      if(!keyPressed){
      accel.set(mouse);
      accel.sub(position);
      accel.mult(-0.01);
      accel.x = accel.x*abs(accel.x);
      accel.y = accel.y*abs(accel.y);
      flote = 0.04 / accel.mag();
      accel.setMag(flote);
      accel.limit(.4);
      velocity.add(accel);
      }

      
      
    
      position.add(velocity);
      
      if(position.x > width + radius|| position.x < 0 - radius){
          velocity.x = velocity.x * -.9;
          position.x = max(0 - radius,min(width + radius,position.x));
  }
     if(position.y > height + radius|| position.y < 0 - radius){
          velocity.y = velocity.y * -.9;
          position.y = max(0 - radius,min(height + radius,position.y));
      }
      fill(colour);
      ellipse(position.x, position.y, radius, radius);
  
  }
  void collide(floater collider){
      temp.set(position);
      temp.sub(collider.position);
      if(temp.mag() < radius){
          temp2.set(collider.velocity);
          collider.velocity.set(velocity);
          velocity.set(temp2);
          //THIS SHIT IS FUCKING GENIUS! GIVE ME A NOBEL PRIZE FOR THIS SHIT!
          //IT GETS RID OF STICKY COLLISIONS!
          //FUCK YEAH!
          
          temp.setMag(temp.mag() - radius);
          position.sub(temp);
          collider.position.add(temp);
          
      }
      
  }
}