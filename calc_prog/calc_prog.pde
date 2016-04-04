PVector mouse = new PVector();
handle[] function = new handle[4];
void setup() {
    
    size(800,500);
    strokeWeight(3);
    
    function[0] = new handle(width/3, height/2);
    function[1] = new handle(width/2, height/3);
    function[2] = new handle(width/3, height/3);
    function[3] = new handle(width/2, height/2);
}
void draw() {
    background(100);
    mouse.set(mouseX, mouseY);
    noFill();
    bezier(85, 20, 10, 10, 90, 90, 15, 80);
    fill(255);
    int steps = 10;
    for (int i = 0; i <= steps; i++) {
        float t = i / float(steps);
        float x = bezierPoint(85, 10, 90, 15, t);
        float y = bezierPoint(20, 10, 90, 80, t);
        ellipse(x, y, 5, 5);
    }
    
    for(handle b : function) b.doStuff();
    noFill();
    bezier(function[0].position.x, function[0].position.y, function[1].position.x, function[1].position.y, function[2].position.x,function[2].position.y, function[3].position.x, function[3].position.y);
}

class handle{
    PVector position;
    boolean pickedUp = false;
    handle(int posX, int posY){
        position = new PVector(posX, posY);
    }
    void doStuff(){
        
        if(mousePressed && (mouse.dist(position) <= 20) | pickedUp){
            position.set(mouse);
            pickedUp = true;
        }
        else pickedUp = false;
        ellipse(position.x, position.y, 20, 20);
    }
}