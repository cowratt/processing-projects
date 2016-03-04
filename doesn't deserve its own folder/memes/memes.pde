void setup(){
  size(800,400, P2D);
  textAlign(CENTER, CENTER);
  textSize(width/10);
  colorMode(HSB, 360, 100, 100);
}
void draw(){
  for(int i = 0;i <= width; i++){
    stroke((i*360/width + 2* frameCount) % 360, 90,90);
    line(i,0,i,height);
    text("memes",400,200);
  }

  if (mousePressed){
    fill((mouseX*360/width + 2* frameCount) % 360, 90,90);
  }
}