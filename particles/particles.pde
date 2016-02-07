floater f;
floater g;
ArrayList<floater> list;
int radius = 20;
int NumberOfParticles = 80;
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

}

void draw(){
  background(200);

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

class floater{
  PVector velocity = new PVector(random(-1, 1), random(-1, 1));
  PVector position = new PVector(random(width), random(height));
  PVector temp = new PVector();
  PVector temp2 = new PVector();
  PVector accel = new PVector();
  color colour = color(random(360), 40, 80);

  floater(){

  }

  void live(){
      //orbit part
      accel.set(mouse);
      accel.sub(position);
      accel.mult(-0.01);
      accel.set(accel.x*abs(accel.x), accel.y*abs(accel.y));
      accel.setMag(.01/accel.mag());
      accel.limit(.1);
      velocity.add(accel);

      
      
    
      position.add(velocity);
      
      if(position.x > width|| position.x < 0){
          velocity.x = velocity.x * -.9;
          position.x = max(1,min(width - 1,position.x));
  }
     if(position.y > height || position.y < 0){
          velocity.y = velocity.y * -.9;
          position.y = max(0,min(height,position.y));
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