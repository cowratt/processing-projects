color stroke1, stroke2, stroke3 = color(0);
void setup(){
    size(400,400, P3D);
    rectMode(CENTER);
    noFill();
    stroke(0);
    strokeWeight(2);
    strokeCap(PROJECT);
    colorMode(HSB, 100, 255, 255);
}
void draw(){
    if(!mousePressed) background(20);
    translate(width/2, height/2);
    stroke(stroke1);
    rotateX(sin(frameCount / 100.0)* PI);
    rotateY(cos(frameCount / 100.0)* PI);
    box(100, 100, 100);
    stroke(stroke2);
    rotateZ(sin(frameCount / 100.0 + 50)* PI);
    rotateX(cos(frameCount / 100.0 + 50)* PI);
    box(200,200,200);
    stroke(stroke3);
    rotateY(sin(frameCount / 100.0 + 120)* PI);
    rotateZ(cos(frameCount / 100.0 + 120)* PI);
    box(50,50,50);
}

void keyPressed(){
    stroke1 = color(random(100), 240, 240);
    stroke2 = color(random(100), 240, 240);
    stroke3 = color(random(100), 240, 240);
}