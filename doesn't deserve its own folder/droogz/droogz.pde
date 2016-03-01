
boolean part1 = true;
boolean part2 = false;
void setup(){
    size(600,600);
    colorMode(HSB,360,100,100);
    
    
}
void draw(){
    if (part2 == true){
        doshit();
        text("Droooooogzzzzzz",width/2,height/2);
        part2 = false;
    }
    if (part1 == true){
        textAlign(CENTER, CENTER);
        textSize(width/10);
        fill(0, 0, 0);
        stroke(0, 0, 0);
        text("wait for it...",width/2,height/2);
        part1 = false;
        part2 = true;
    }
}
void doshit(){
    for(int x = 1; x < width;x++){
        for(int y = 1;y < width;y++){
            stroke(Colour(x,y));
            point(x,y);
        }
    }
}

color Colour(float x, float y){
    return color(int(int(sin(x*sin(y/65.0)/20.0)*15.0 + x*30.0/y)*5) % 360.0,100, 100);
}