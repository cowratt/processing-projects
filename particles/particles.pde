floater f;
floater g;
ArrayList<floater> list;
int radius = 20;
int NumberOfParticles = 50;
void setup(){
    list = new ArrayList<floater>();
    size(800,800);
    for(int i=0; i<NumberOfParticles; i++){
        list.add(new floater());
    }
    f = new floater();
    g = new floater();
}

void draw(){
  background(150);

  
  for(int i=0; i<NumberOfParticles; i++){
      floater Q = list.get(i);
      Q.live();
      for(int j=i; j< NumberOfParticles; j++){
          floater R = list.get(j);
          Q.collide(R);
      }
  }
text(frameRate, 40, 40);

}

class floater{
  PVector velocity = new PVector(random(-5, 5), random(-5, 5));
  PVector position = new PVector(random(width), random(height));
  PVector temp = new PVector();
  color colour = color(random(255), random(255), random(255));

  floater(){

  }

  void live(){
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
          temp.set(collider.velocity);
          collider.velocity.set(velocity);
          velocity.set(temp);

  }
  }
}