int Color = 0;
int sat = 255;
int brightness = 255;
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
        
        
        if(mouseY > 18*height/20 && mouseY < 19*height/20) sat = mouseX;
        else if(mouseY > 17*height/20 && mouseY < 18*height/20) brightness = mouseX;
        else if(mouseY > 19*height/20) Color = mouseX;
        else ellipse(mouseX,mouseY,width/15,width/15);
        
        
    }
    
    //draw spectrum
    
    for(int i = 0;i <= width;i++){
        stroke(360*i/width, 230, 255);
        line(i,height*19/20,i,height);
    }
    for(int i = 0;i <= width;i++){
        stroke(360*Color/width, i*255/width, 255);
        line(i,height*18/20,i,height*19/20);
    }
    for(int i = 0;i <= width;i++){
        stroke(360*Color/width, 230, i*255/width);
        line(i,height*17/20,i,height*18/20);
    }
    
    
    
    //draw triangle
    noStroke();
    fill(100);
    triangle(Color - width/40, height, Color + width/40, height, Color, height*19/20);
    triangle(sat - width/40, 19*height/20, sat + width/40, 19*height/20, sat, height*18/20);
    triangle(brightness - width/40, 18*height/20, brightness + width/40, 18*height/20, brightness, height*17/20);
    fill(360*Color/width, 255*sat / width, 255*brightness / width);
    
}