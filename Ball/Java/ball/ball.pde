boolean started = false;
PVector mouse = new PVector(mouseX, mouseY);
float decay = 0.9;
float size = 50;
orbital b = new orbital(#C93939);
void setup(){
    size(500,500);
    background(33, 141, 155);
    strokeWeight(3);
    textSize(15);
    fill(125, 218, 229);
}
void draw(){
    if( !mousePressed){
        background(33, 141, 155);
    }
    mouse.set(mouseX, mouseY);
    b.orbit(mouse, 1);


}

class orbital {
    PVector position = new PVector(0,0);
    PVector velocity = new PVector(0,0);
    PVector tempvel = new PVector(0,0);
    float decay = 1.0;
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
        ellipse(position.x, position.y, size, size);
    }
    
}