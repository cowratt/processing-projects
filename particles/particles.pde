dividor d;
ArrayList<floater> list;
int radius = 30;
int NumberOfParticles = 100;
PVector mouse = new PVector();
Button button;
boolean slideron = false;


void setup(){
    colorMode(HSB, 360, 100, 100);
    list = new ArrayList<floater>();
    size(1280, 720);
    for(int i=0; i<NumberOfParticles; i++){
        list.add(new floater());
    }
    d = new dividor();
    stroke(1);
    frameRate(120);
    rectMode(CENTER);
    button = new Button("dividor", 18*width/20, 9*height/10, width/10, height/10);

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
      if(slideron){
      d.bonk(Q);
      }
  }
  if(slideron){
  d.live(); //<>//
  }
  toggle();

}
void mousePressed(){
  noStroke();
  background(200);
}
void mouseReleased(){
  stroke(1);
}

void toggle(){
  cursor(ARROW);
  if (button.clicked()){
    slideron = !slideron;
  }
  button.Draw();
}


class floater{
  PVector velocity = new PVector(random(-1, 1), random(-1, 1));
  PVector position = new PVector(random(width), random(height));
  float flote;
  PVector temp = new PVector();
  PVector temp2 = new PVector();
  PVector accel = new PVector();
  color colour;
  boolean exempt = false;
  boolean align;

  floater(){
    colour = color(random(360), 40, 80);
    if(position.x > width/2){
      align = true;
    }
    else{
      align = false;
    }
      

  }

  void live(){
      //orbit part
      if(!keyPressed){
      accel.set(mouse);
      accel.sub(position);
      accel.mult(-0.01);
      accel.x = accel.x*abs(accel.x);
      accel.y = accel.y*abs(accel.y);
      flote = 0.05 / accel.mag();
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

          //removes sticky collisions
          temp.setMag(temp.mag() - radius);
          position.sub(temp);
          collider.position.add(temp);
          
      }
      
  }
  
}
class dividor{
  float position = width/2;
  float velocity = 0;
  boolean temp = false;
  
  dividor(){}
  
  void bonk(floater f){
    temp = f.exempt;
    if(f.position.x - position > -15 && f.position.x - position < 15 && !f.exempt){
      f.exempt = true;
      velocity = f.velocity.x;
      f.velocity.x*= -1;
    }
    if(temp){
      f.exempt = false;
    }
    if(f.position.x < position && f.align){
      //f.position.set(random(position, width), random(0, height));
      //f.velocity.x += 0.2;
    }
    if(f.position.x > position && !f.align){
      //f.position.set(random(0,position),random(0,height));
      //f.velocity.x += 0.2;
    }
      
      
    }

  void live(){
    position+=velocity;
    velocity/=2;
    rect(position, height/2, 15, height);
  }


}

class Button {
    String label;
    float x;        // center x position
    float y;        // center y position
    float w;        // width of Button
    float h;        // height of Button
    boolean laststep = false;
    boolean buffer = true;
    Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
        label = labelB;
        x = xpos;
        y = ypos;
        w = widthB;
        h = heightB;
    }
    void Draw() {
        
        rectMode(CENTER);
        if(pressed()){
            fill(200);
            cursor(HAND);
        }
        else if(MouseIsOver()){
            fill(210);
            cursor(HAND);
        }
        else{
            fill(0, 0, 80, 50);
        }

        rect(x, y, w, h);
        textAlign(CENTER, CENTER);
        fill(0);
        text(label, x, y);
        
    }
    boolean MouseIsOver() {
        if (mouseX + w/2 > x && x > mouseX - w/2 && mouseY + h/2 > y && mouseY - h/2 < y) {
            return true;
        }
        return false;
    }
    boolean pressed() {
        
        if(MouseIsOver() && mousePressed){
            
            return true;
        }
        
        return false;
    }
    boolean clicked(){
        if(!pressed() && laststep){
            laststep = false;
            return true;
        }
        else{
            laststep = pressed();
            return false;
        }
        
    }
 }