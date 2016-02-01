boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
float decay = 0.9;
float radius = 50;
orbital b = new orbital(#C93939);
button startbutton  = new button("start", width/2, height*0.8, 100, 50);
color bg;


void setup(){
    size(800,600);
    background(33, 141, 155);
    strokeWeight(3);
    textSize(15);
    fill(125, 218, 229);
    startbutton = new button("start", width/2, height*0.8, width/4, width/8);
    bg = #989898;
    
}





void draw(){

    if(started){
        program();
    }
    else{
        splash();
    }
}


void splash(){
    int scale = min(width,height);
    background(bg);
    textAlign(CENTER, CENTER);
    textSize(scale/15);
    text("orbital dynamics simulator", width/2, height/3);
    textSize(scale/22);
    text("Use space to negate gravitational decay", width/2, height/2);
    text("click to \"draw\"", width/2, height*0.6);
    startbutton.Draw();
    if(startbutton.clicked()){
        started = true;
    }
    

}
void program(){
    if( !mousePressed){
        background(bg);
    }
    mouse.set(mouseX, mouseY);
    stroke(0);
    b.orbit(mouse, 1);

}








//classes orbital and button

class orbital {
    PVector position = new PVector(0,0);
    PVector velocity = new PVector(0,0);
    PVector tempvel = new PVector(0,0);
    float decay = 1.0;
    //Don't judge. I use the other spelling to differentiate between the class and the private object
    color colour;
    
    orbital(color doot){
        colour = doot;
    }
    void orbit(PVector follow, float strength){
        decay = 0.9;
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
        }
        else if(MouseIsOver()){
            fill(210);
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