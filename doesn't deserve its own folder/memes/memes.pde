void setup(){
  size(600,600);
  textAlign(CENTER, CENTER);
  textSize(width/10);
  colorMode(HSB, 360, 100, 100);
}
void draw(){
  textSize(width/10);
  for(int i = 0;i <= width; i++){
    stroke((i*360/width + 2* frameCount) % 360, 90,90);
    line(i,0,i,height);
    
  }
  text("memes", width/2,height/2);
  if (mousePressed){
    fill((mouseX*360/width + 2* frameCount) % 360, 90,90);
  }
  else{
    fill((frameCount) % 360, 90,90);
  }
}