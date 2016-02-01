//--------------------- Setting up non-canvas-dependant variables

boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
float decay = 0.9;
float radius = 50;
orbital b;
button startbutton;
color bg = #989898;
button strengthup;
button strengthdown;


//---------------------- Setting up canvas and canvas-dependant variables
void setup(){
    size(1000,600);
    background(33, 141, 155);
    strokeWeight(2);
    textSize(15);
    fill(125, 218, 229);
    frameRate(120);
    b = new orbital(#C93939);
    startbutton = new button("start", width/2, height*0.8, width/4, width/8);
    strengthup = new button("+", 19*width/20, width/10, width/20, height/10);
    strengthdown = new button("-", 18*width/20, width/10, width/20, height/10);
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
    textSize(scale/15);
    text("orbital dynamics simulator", width/2, height/3);
    textSize(scale/22);
    text("Use space to negate gravitational decay", width/2, height/2);
    text("click to \"draw\"", width/2, height*0.6);
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
    b.orbit(mouse);
    gravitybuttons();
}

//---------------------- Buttons to control strength

float strength = 0.4;
void gravitybuttons(){

  if(strengthup.pressed()){
      strength = min(2,strength*1.01);
      background(bg);
  }
  if(strengthdown.pressed()){
      strength = max(0.1, strength*0.99);
      background(bg);
  }
  fill(0);
  
  text("strength:" + nf(strength, 1, 2), 9*width/10, height/20);
  cursor(ARROW);
  strengthup.Draw();
  strengthdown.Draw();
}

//----------------- decay buttons
void decaybuttons(){
}






//------------------- classes orbital and button

class orbital {
    PVector position = new PVector(0,0);
    PVector velocity = new PVector(0,0);
    PVector tempvel = new PVector(0,0);
    float decay = 1.0;
    //Don't judge. I use the other spelling to differentiate between the class and the private object
    color colour;
    button strengthup;
    button strengthdown;
    
    orbital(color doot) {
        colour = doot;


    }
    void orbit(PVector follow){
        decay = 0.95;
        if(keyPressed){
            decay = 1;
        }
        follow.set(follow);
        velocity.x = (follow.x - position.x + velocity.x) * decay;
        velocity.y = (follow.y - position.y + velocity.y) * decay;
        tempvel.set(velocity);
        tempvel.mult(0.1*strength);
        position.add(tempvel);
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
        rect(x, y, w, h, 10);
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