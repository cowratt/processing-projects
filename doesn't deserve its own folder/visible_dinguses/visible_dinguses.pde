color stroke1, stroke2, stroke3 = color(0);
float help = 1;
void setup(){
    size(400,400, P3D);
    rectMode(CENTER);
//    noFill();
    stroke(0);
    strokeWeight(2);
    //strokeCap(PROJECT);
    colorMode(HSB, 100, 255, 255);
    float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
    perspective(PI/3.0, width/height, cameraZ*10.0, cameraZ/10.0);
}
void draw(){
    background(20);
    translate(width/2, height/2);
    stroke(stroke1);
    rotateX(sin(frameCount / 100.0)* PI*help);
    rotateY(cos(frameCount / 100.0)* PI*help);
    box(150, 150, 150);
        /*
    stroke(stroke2);
    rotateZ(sin(frameCount / 100.0 + 50)* PI);
    rotateX(cos(frameCount / 100.0 + 50)* PI);
    box(200,200,200);
    stroke(stroke3);
    rotateY(sin(frameCount / 100.0 + 120)* PI);
    rotateZ(cos(frameCount / 100.0 + 120)* PI);
    box(50,50,50);
    */
}

void keyPressed(){
    fill(random(100), 240, 240);

}
void mouseReleased(){
    float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
    perspective(PI/3.0, width/height, cameraZ*10.0, cameraZ/10.0);
    help = 1;
}
void mousePressed(){
    ortho();
    help = -1;
}