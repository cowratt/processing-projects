/*
coded by Conrad Menchine
criticism and pull requests encouraged
(i have no idea how pull requests work, though)
please credit me if you post this anywhere
*/

//--------------------- Setting up non-canvas-dependant variables

boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
float radius = 40;

ArrayList balls;
orbital ogb;

button startbutton;
color bg = #C7D5E8;



button strengthup;
button strengthdown;
button rangedown;
button rangeup;
button ballsup;
button ballsdown;


//---------------------- Setting up canvas and canvas-dependant variables
void setup(){
    size( 1280, 720);
    background(bg);
    strokeWeight(1);
    textSize(15);
    frameRate(60);
    
    balls = new ArrayList();
    balls.add(new orbital(color(random(255), random(255), random(255)), 1));
    ogb = (orbital) balls.get(0);

    
    startbutton = new button("start", width/2, height*0.8, width/4, width/8);
    ballsup = new button("+", 19*width/20, height/5, width/20, height/10);
    ballsdown = new button("-", 18*width/20, height/5, width/20, height/10);
    
    strengthup = new button("+", 19*width/20, 2*height/5, width/20, height/10);
    strengthdown = new button("-", 18*width/20, 2*height/5, width/20, height/10);
    rangedown = new button("+", 19*width/20, 3*height/5, width/20, height/10);
    rangeup = new button("-", 18*width/20, 3*height/5, width/20, height/10);
}




//------------------------- The draw function: shows splash screen and program
void draw(){
    

    if(started){
        program();
    }
    else{
        splash();
    }
    
}

//------------------------- The startup splash screen
void splash(){
    int scale = min(width,height);
    background(bg);
    textAlign(CENTER, CENTER);
    textSize(scale/18);
    text("Conrad's REAL orbital dynamics simulator", width/2, height/3);
    textSize(scale/22);
    text("(all balls orbit the mouse)", width/2, height/2);
    text("click to draw", width/2, height*0.6);
    cursor(ARROW);
    startbutton.Draw();
    if(startbutton.clicked()){
        
        started = true;
    }
    
//------------------------- The actual program
}
void program(){
    textSize(min(width,height)/26);
    if( !mousePressed){
        background(bg);
    }
    mouse.set(mouseX, mouseY);
    stroke(0);
    ogb.orbit(mouse);
    
    for(int i=1; i<balls.size();i++){
        orbital b = (orbital) balls.get(i);
        orbital b0 = (orbital) balls.get(i-1);
        b.orbit(mouse);
    }
    

    ballbuttons();
    gravitybuttons();
    rangebuttons();
    warnings();
}

//---------------------- Buttons to control strength

float strength = 0.4;
void gravitybuttons(){

  if(strengthup.pressed()){
      strength = min(2,strength*1.05);
      background(bg);
  }
  if(strengthdown.pressed()){
      strength = max(0.1, strength*0.95);
      background(bg);
  }
  fill(0);
  
  text("gravity: " + nf(strength, 1, 2), 9*width/10, 6*height/20);
  cursor(ARROW);
  strengthup.Draw();
  strengthdown.Draw();
}

//----------------- range buttons
float range = 1.0;
void rangebuttons(){

  if(rangeup.pressed()){
    range = max(0.2, range*0.96);
    background(bg);
      
  }
  if(rangedown.pressed()){
      
      range = min(4,range*1.05);
      background(bg);
  }
  fill(0);
  
  text("Speed: " + nf(range, 1, 2), 9*width/10, height/2);
  cursor(ARROW);
  rangedown.Draw();
  rangeup.Draw();
}

//----------------- warnings for sage
void warnings(){
    fill(80);
    
    if(6 < balls.size() && balls.size()< 10){
      text("this is a bad idea...", width/2, 19*height/20);
    }
    if(9 < balls.size() && balls.size()< 20){
      text("seriously though", width/2, 19*height/20);
    }
    if(19 < balls.size() && balls.size()< 30){
      text("omg. pls stahp", width/2, 19*height/20);
    }
    if(29 < balls.size() && balls.size()< 40){
      text("This is getting ridiculous", width/2, 19*height/20);
    }
    if(39 < balls.size() && balls.size()< 50){
      text("You have a problem.", width/2, 19*height/20);
    }
    if(balls.size() == 50){
      text("I'm cutting you off", width/2, 19*height/20);
    }
  
  
  
}
//-----------------change size buttons

//-----------------add balls (if balls > 2)

void ballbuttons(){

  if(ballsup.clicked() && balls.size() < 50){
      balls.add(new orbital(color(random(255), random(255), random(255)), 0.9));
      background(bg);
  }
  if(ballsdown.clicked() && balls.size() > 1){
      balls.remove(balls.size() - 1);
      background(bg);
  }
  fill(0);
  
  text("balls: " + balls.size(), 9*width/10, height/20);
  cursor(ARROW);
  ballsup.Draw();
  ballsdown.Draw();
}



//-----------------skew of ball accelerations (*skew^numberofball)


//------------------- classes orbital and button

class orbital {
    PVector rad = new PVector(0,0);
    PVector position = new PVector(random(width),random(height));
    PVector pi;
    PVector velocity = new PVector(0,0);
    PVector accel = new PVector(0,0);
    //Don't judge. I use the other spelling to differentiate between the class and the private object
    color colour;
    float delay;
    float mult;
    float radmag;
    float distance;
    PVector follow = new PVector(0,0);
    
    orbital(color doot, float mul) {
        colour = doot;
        mult = mul;


    }
    void orbit(PVector follo){
        delay = range;
        if(keyPressed){
            delay = 1;
        }
        follow.set(follo);
        follow.sub(position);
        distance = follow.mag();
        rad.set(follow);
        rad.mult(0.02);
        //square radius
        rad.x = (rad.x * abs(rad.x));
        rad.y = (rad.y * abs(rad.y));
        radmag = (40*strength) / rad.mag();
        rad.setMag(radmag);
        accel.set(rad);
        accel.limit(1);
        accel.mult(3*range);
        velocity.add(accel);
        position.add(velocity);
        if(position.x > width || position.x < 0){
          velocity.x = velocity.x * -0.6;
        }
        if(position.y > height || position.y < 0){
          velocity.y = velocity.y * -0.6;
        }
        
        //velocity.x = (50/(follow.x - position.x) + velocity.x) * delay * mult;
        //velocity.y = (50/(follow.y - position.y) + velocity.y) * delay * mult;
        //tempvel.set(velocity);
        //tempvel.mult(0.1*strength);
       // position.add(tempvel);
        fill(colour);
        ellipse(position.x, position.y, radius, radius);
    }
}

class button {
    String label;
    float x;        // center x position
    float y;        // center y position
    float w;        // width of button
    float h;        // height of button
    boolean laststep = false;
    boolean buffer = true;
    button(String labelB, float xpos, float ypos, float widthB, float heightB) {
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
            fill(180);
        }
        stroke(141);
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