int Color = 0;
void setup(){
    size(800,800);
    colorMode(HSB, 360, 255, 255);
    background(200);
    textAlign(CENTER, CENTER);
    textSize(width/20);
    text("Press space to clear", width/2, height/10);
    textSize(width/30);
    text("[the spectrum]",width/2, height*17/20);
    fill(0, 230, 255);
    frameRate(120);
    
}

void draw(){
    if( keyPressed){
        background(200);
    }
    
    //draw paintbrush when mouse clicked
    
    if(mousePressed){
        noStroke();
        
        if(mouseY > 9*height/10) Color = mouseX;
        else ellipse(mouseX,mouseY,width/15,width/15);
    }
    
    //draw spectrum
    
    for(int i = 0;i <= width;i++){
        stroke(360*i/width, 230, 255);
        line(i,height*9/10,i,height);
    }
    
    //draw triangle
    noStroke();
    fill(100);
    triangle(Color - width/40, height, Color + width/40, height, Color, height*19/20);
    fill(360*Color/width, 230, 255);
    
}