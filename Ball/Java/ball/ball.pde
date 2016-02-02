//--------------------- Setting up non-canvas-dependant variables

boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
float radius = 40;

int balls = 1;
orbital b;
orbital b2;
orbital b3;
orbital b4;
orbital b5;
orbital b6;

button startbutton;
color bg = #989898;



button strengthup;
button strengthdown;
button decayup;
button decaydown;
button ballsup;
button ballsdown;


//---------------------- Setting up canvas and canvas-dependant variables
void setup(){
    size( $(window).width(), $(window).height() - 300);
    background(33, 141, 155);
    strokeWeight(2);
    textSize(15);
    fill(125, 218, 229);
    frameRate(120);
    
    b = new orbital(#C93939, 1);
    b2 = new orbital(#30D858, 0.9);
    b3 = new orbital(#412BDE, 0.9);
    b4 = new orbital(#F7D50C, 0.9);
    b5 = new orbital(#28D6DB, 0.9);
    b6 = new orbital(#BD1BE3, 0.9);
    
    startbutton = new button("start", width/2, height*0.8, width/4, width/8);
    ballsup = new button("+", 19*width/20, height/5, width/20, height/10);
    ballsdown = new button("-", 18*width/20, height/5, width/20, height/10);
    
    strengthup = new button("+", 19*width/20, 2*height/5, width/20, height/10);
    strengthdown = new button("-", 18*width/20, 2*height/5, width/20, height/10);
    decayup = new button("+", 19*width/20, 3*height/5, width/20, height/10);
    decaydown = new button("-", 18*width/20, 3*height/5, width/20, height/10);
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
    if(balls>1){
        b2.orbit(b.position);
        if(balls>2){
            b3.orbit(b2.position);
            if(balls>3){;
                b4.orbit(b3.position);
                if(balls>4){
                    b5.orbit(b4.position);
                    if(balls>5){
                        b6.orbit(b5.position);
                    }
                }
            }
        }
    }
    ballbuttons();
    gravitybuttons();
    decaybuttons();
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
  
  text("gravity: " + nf(strength, 1, 2), 9*width/10, 6*height/20);
  cursor(ARROW);
  strengthup.Draw();
  strengthdown.Draw();
}

//----------------- decay buttons
float decay = 0.95;
void decaybuttons(){

  if(decayup.pressed()){
      decay = min(0.99,decay*1.005);
      background(bg);
  }
  if(decaydown.pressed()){
      decay = max(0.2, decay*0.995);
      background(bg);
  }
  fill(0);
  
  text("drag: " + nf(decay, 1, 2), 9*width/10, height/2);
  cursor(ARROW);
  decayup.Draw();
  decaydown.Draw();
}


//-----------------change size buttons

//-----------------add balls (if balls > 2)
void ballbuttons(){

  if(ballsup.clicked()){
      balls = min(6,balls+1);
      background(bg);
  }
  if(ballsdown.clicked()){
      balls = max(1, balls-1);
      background(bg);
  }
  fill(0);
  
  text("balls: " + balls, 9*width/10, height/20);
  cursor(ARROW);
  ballsup.Draw();
  ballsdown.Draw();
}



//-----------------skew of ball accelerations (*skew^numberofball)


//------------------- classes orbital and button

class orbital {
    PVector position = new PVector(0,0);
    PVector velocity = new PVector(0,0);
    PVector tempvel = new PVector(0,0);
    //Don't judge. I use the other spelling to differentiate between the class and the private object
    color colour;
    button strengthup;
    button strengthdown;
    float delay;
    float mult;
    
    orbital(color doot, float mul) {
        colour = doot;
        mult = mul;


    }
    void orbit(PVector follow){
        delay = decay;
        if(keyPressed){
            delay = 1;
        }
        follow.set(follow);
        velocity.x = (follow.x - position.x + velocity.x) * delay * mult;
        velocity.y = (follow.y - position.y + velocity.y) * delay * mult;
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