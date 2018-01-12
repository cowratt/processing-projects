//used to generate dust textures. Also it looks cool if you stare at it for a while

void setup(){
  size(1000,1000);
  noFill();
  smooth();
  stroke(255);
  frameRate(10);

}
void draw(){

//frameRate(10);
mousePressed();
}
void mousePressed(){
  background(0);
  genDust(0.4,0.8,1000,1,1.5);
  //genDust(0.4,0.7,4000,1,1);
  //genDust(0.07,0.4,40000, 0.8,0.8);
  //genDust(0.06,0.2,200000,0.5, 0.5);
}
void genDust(float minSize, float maxSize, int numParticles, float maxSizeS, float maxSizeL){
  for(int i = 0; i < numParticles; i++){
    int x = (int)random(width);
    int y = (int)random(height);
    float scale = random(minSize,maxSize);
    //trend towards smaller dots
    scale = pow(scale,3);
    //make smaller dots have smaller stroke to eliminate just big dots everywhere
    if(scale < 0.4)strokeWeight(random(maxSizeS));
    else strokeWeight(random(0.1,maxSizeL));
    //the shape
    beginShape();
    vertex(x,y);
    bezierVertex(x + (scale * random(-50,50)), y + (scale * random(-50, 50)), x + (scale * random(-50, 50)), y + (scale * random(-50, 50)), x + (scale * random(-50, 50)), y + (scale * random(-50, 50)));
    endShape();
  }
}