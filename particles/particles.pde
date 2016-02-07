floater f;
ArrayList<floater> list;
int radius = 20;
int NumberOfParticles = 20;
void setup(){
    list = new ArrayList<floater>();
    size(500,500);
    for(int i=0; i<NumberOfParticles; i++){
        list.add(new floater());
    }
    f = new floater();
}

void draw(){
  background(150);
  f.live();
  
  for(floater Q : list){
        Q.live();
    }


}

class floater{
  PVector velocity = new PVector(random(-5, 5), random(-5, 5));
  PVector position = new PVector(random(width), random(height));
  color colour;

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

      ellipse(position.x, position.y, radius, radius);
  
  }
  void collide(floater collider){
      if(position.sub(collider.position) < radius){
          



  }
  }