ArrayList<noot> matrix = new ArrayList<noot>();
void setup(){
    textSize(30);
    size(600,600);
    for(int i = 0; i < width/20; i++){
        matrix.add(new noot());
    }
    fill(#0CAA15);
    rect(-1, -1, width+1, height+1);
    frameRate(20);
}

void draw(){
    fill(#0F0F0F, 10);
    rect(-1, -1, width+1, height+1);
    fill(#0CAA15);
    for (noot i : matrix){
        i.comeDown();        
    }
}

class noot{
    float X = 0;
    float Y = 0;
    noot(){
        Y = random(height);
        X = random(width);
    }
    void comeDown(){
        Y+= random(3,20);
        text((char)int(random(33,96)),X, Y);
        if(Y > height){
            Y = 0;
            X = random(width);
        }
    }
}