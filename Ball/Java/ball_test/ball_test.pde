/*
coded by Conrad Menchine
criticism and pull requests encouraged
(i have no idea how pull requests work, though)
please credit me if you post this anywhere
*/
//import java.util.LinkedList;
//--------------------- Setting up non-canvas-dependant variables

boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
float radius = 40;

ArrayList<Orbital> balls;
Orbital ogb;

Button startButton;
color bg = #D1D1D1;
//#D1D1D1
//#C7D5E8

Button strengthup;
Button strengthdown;
Button decayup;
Button decaydown;
Button ballsup;
Button ballsdown;
Button sizebutton;
Button allcbutton;
Button lightcbutton;
Button fastbutton;
Button menubutton;
Button outlinesbutton;

Button trailsbutton;
boolean sizechange = false;
boolean smoothLine = false;
boolean showMenu = false;
boolean fastSpeed = false;
boolean outlines = true;
String sizetext = "off";


//---------------------- Setting up canvas and canvas-dependant variables
void setup(){
    size( 1280, 720);
    background(bg);
    //noStroke();
    //strokeWeight(1);
    textSize(15);
    frameRate(60);
    colorMode(HSB, 360, 100, 100);
    balls = new ArrayList<Orbital>();
    balls.add(new Orbital(color(random(360), random(70,100), random(70,100)), 1));
    ogb = (Orbital) balls.get(0);

    
    startButton = new Button("start", width/2, height*0.8, width/4, width/8);
    ballsup = new Button("+", 19*width/20, height/5, width/20, height/10);
    ballsdown = new Button("-", 18*width/20, height/5, width/20, height/10);
    
    strengthup = new Button("+", 19*width/20, 2*height/5, width/20, height/10);
    strengthdown = new Button("-", 18*width/20, 2*height/5, width/20, height/10);
    decayup = new Button("+", 19*width/20, 3*height/5, width/20, height/10);
    decaydown = new Button("-", 18*width/20, 3*height/5, width/20, height/10);
    
    sizebutton = new Button("On/Off", 18.5*width/20, 4*height/5, width/10, height/10);
    
    allcbutton = new Button("Contrast", width/15, 23*height/40, width/10, height/20);
    lightcbutton = new Button("light", width/15, 25*height/40, width/10, height/20);
    
    menubutton = new Button("menu", 19*width/20, 19.5*height/20, width/10, height/20);
    
    fastbutton = new Button("On/Off", width/15, height/5, width/10, height/10);
    
    outlinesbutton = new Button("On/Off", width/15, 2*height/5, width/10, height/10);
    
    trailsbutton = new Button("On/Off", width/15, 4*height/5, width/10, height/10);
}




//------------------------- The draw function: shows splash screen and program
void draw(){
    

    if(started){
        program();
        if(fastSpeed)program();
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
    text("Conrad's Ball Thing", width/2, height/3);
    textSize(scale/22);
    text("Use space to mess with physics", width/2, height/2);
    text("click to draw", width/2, height*0.6);
    cursor(ARROW);
    startButton.Draw();
    if(startButton.clicked()){
        
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
    //stroke(0);
    ogb.orbit(mouse);
    /*
    Orbital previous = ogb;
    for(Orbital b : balls) {
      b.orbit(previous.position);
      previous = b;
    }
    */

    for(int i=1; i<balls.size();i++){
        Orbital b = balls.get(i);
        Orbital b0 = balls.get(i-1);
        b.orbit(b0.position);
    }
    cursor(ARROW);
    if(menubutton.clicked()) showMenu = !showMenu;
    menubutton.Draw();
    if(showMenu){
        ballButtons();
        gravityButtons();
        decayButtons();
        sizeButtons();
        trailsButton();
        colorButtons();
        speedButtons();
        outlinesButtons();
        warnings();
    }
    
}
//----------------------speed buttons
void speedButtons(){
    if(fastbutton.clicked()) fastSpeed = !fastSpeed;
    if(fastSpeed) text("2X Speed: on", width/15, height/10);
    else text("2X Speed: off", width/15, height/10);
    fastbutton.Draw();
}
//-----------------------outline buttons
void outlinesButtons(){
    if(outlinesbutton.clicked()) outlines = !outlines;
    if(outlines) text("Outlines: on", width/15, 3*height/10);
    else text("Outlines: off", width/15, 3*height/10);
    outlinesbutton.Draw();
}
//---------------------- Buttons to control strength

float strength = 0.4;
void gravityButtons(){

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
  
  strengthup.Draw();
  strengthdown.Draw();
}

//----------------- decay Buttons
float decay = 0.95;
void decayButtons(){

  if(decayup.pressed()){
    decay = max(0.2, decay*0.995);
    background(bg);
      
  }
  if(decaydown.pressed()){
      
      decay = min(0.99,decay*1.005);
      background(bg);
  }
  fill(0);
  
  text("drag: " + nf(1 - decay, 1, 2), 9*width/10, height/2);
  decayup.Draw();
  decaydown.Draw();
}

//-----------------trails button

void trailsButton(){
    String trailsText;
    if(trailsbutton.clicked()){
        smoothLine = !smoothLine;
        if(smoothLine == false)for(Orbital b : balls)b.lastLocs.clear();
    }
    if(smoothLine)trailsText = "on";
    else trailsText = "off";
    text("Trails:"+ trailsText, width/15, 14*height/20);
    trailsbutton.Draw();
}


//----------------- warnings
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
//-----------------change size Buttons
void sizeButtons(){
  if(sizebutton.clicked()){
    sizechange = !sizechange;
  }
  if(sizechange){
    sizetext = "on";
  }
  else{
    sizetext = "off";
  }
  text("velocity/size:"+ sizetext, 9*width/10, 14*height/20);
  sizebutton.Draw();
  
}
//-----------------add balls (if balls > 2)

void ballButtons(){ 

  if(ballsup.clicked() && balls.size() < 50){
      balls.add(new Orbital(color(random(360), random(70,100), random(70,100)), 0.9));
      background(bg);
  }
  if(ballsdown.clicked() && balls.size() > 1){
      balls.remove(balls.size() - 1);
      background(bg);
  }
  
  fill(0);
  text("balls: " + balls.size(), 9*width/10, height/20);
  ballsup.Draw();
  ballsdown.Draw();
}



//-----------------Color Buttons
void colorButtons(){
    if(allcbutton.clicked()){
        for(Orbital b : balls)b.recolor(true);
    }
    if(lightcbutton.clicked()){
        for(Orbital b : balls)b.recolor(false);
    }
    fill(0);
    text("New Colors:", width/15, height/2);
    allcbutton.Draw();
    lightcbutton.Draw();
}

//------------------- classes Orbital and Button

class Orbital {
    PVector position = new PVector(0,0);
    PVector velocity = new PVector(0,0);
    PVector tempvel = new PVector(0,0);
    //this should REALLY be a linked list
    ArrayList<PVector> lastLocs = new ArrayList<PVector>();
    //Don't judge. I use the other spelling to differentiate between the class and the private object
    color colour;
    float delay;
    float mult;
    
    Orbital(color doot, float mul) {
        colour = doot;
        mult = mul;


    }
    void recolor(boolean all){
        if(all) colour = color(random(360), random(100), random(100));
        else colour = color(random(360), random(70,100), random(70,100));
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
        if(sizechange){
        radius = max(15, min(70, (velocity.mag()) / 20));}
        else{radius = 40;}
        if(smoothLine){
            lastLocs.add(new PVector(position.x, position.y));
            while(lastLocs.size()>4)lastLocs.remove(0);
            
        }
        if(smoothLine && mousePressed && velocity.mag() > 150 && lastLocs.size()>3){
            if(outlines){
                strokeWeight(radius+2);
                stroke(0);
                curve(lastLocs.get(0).x, lastLocs.get(0).y, lastLocs.get(1).x, lastLocs.get(1).y, lastLocs.get(2).x, lastLocs.get(2).y, lastLocs.get(3).x, lastLocs.get(3).y);
            }
            strokeWeight(radius);
            stroke(colour);
            curve(lastLocs.get(0).x, lastLocs.get(0).y, lastLocs.get(1).x, lastLocs.get(1).y, lastLocs.get(2).x, lastLocs.get(2).y, lastLocs.get(3).x, lastLocs.get(3).y);
        }
        else{
            if(outlines){
                stroke(0);
                strokeWeight(1);
            }
            else noStroke();
            ellipse(position.x, position.y, radius, radius);
        }
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
            fill(180);
        }
        stroke(141);
        strokeWeight(1);
        rect(x, y, w, h);
        //noStroke();
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