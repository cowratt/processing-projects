float[] matrix;
int placeToDraw;
void setup(){
    textSize(30);
    size(500,500);
    matrix = new float[width/30];
    for(float i : matrix){
        i = random(height)*1.0;
    }
}

void draw(){
    placeToDraw = width/20;
    background(150);
    for (float i : matrix){
        i += 100;
        if(i > height) i = 0;
        text((char)int(random(37,120)),placeToDraw, i);
        placeToDraw+=width/20;
    }
}