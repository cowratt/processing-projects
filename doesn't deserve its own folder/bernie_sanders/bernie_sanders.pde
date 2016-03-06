import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioInput input;

PImage sanders, weed, glasses;
int scale, glassesclock = 0;
void setup(){
    size(800,800);
    imageMode(CENTER);
    sanders = loadImage("sanders.png");
    weed = loadImage("no-flowering-marijuana.jpg");
    glasses = loadImage("dealwithit.png");
    scale = min(width,height);
    colorMode(HSB, 360, 100, 100, 100);
    textAlign(CENTER,CENTER);
    textSize(scale/4);
    minim = new Minim(this);
    player = minim.loadFile("Willie Hutch - I Choose You.mp3");
    input = minim.getLineIn();
    
}

void draw(){
    background(100);
    if(glassesclock > height/2) image(weed,width/2, height/2, scale, scale);
    image(sanders, width/2, max(height/2,height - (scale/150)*frameCount + scale/3), scale, scale);
    if( height - (scale/150)*frameCount + scale/3 < height/2){
        image(glasses, 6*width/16, min(height/2,glassesclock), 2*scale/3, scale/9);
        glassesclock +=(scale/230);
    }
    if(glassesclock > height/2){
        
        
        fill(frameCount*2 % 360, 100, 100, 40); 
        rect(-1,-1,width+1,height+1);
        fill((frameCount*2 + 180) % 360, 100, 100, 100);
        text("MEMES", width/2, height/8);
        player.play();
    }
}