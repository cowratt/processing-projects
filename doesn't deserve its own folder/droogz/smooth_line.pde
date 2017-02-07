ArrayList<container> floop = new ArrayList<container>();

void setup() {
  size(600,600);
  background(150);
  smooth();
  noFill();
  stroke(0);
  strokeWeight(5);
  frameRate(60);
}


void draw(){
  if(mousePressed){
      floop.add(new container(mouseX,mouseY));
      point(mouseX,mouseY);
  }
}
void mouseReleased(){
      strokeWeight(5);
      if(floop.size() > 0){
      beginShape();
      curveVertex(floop.get(0).x, floop.get(0).y);
      for (container c : floop){
          curveVertex(c.x, c.y);
      }
      curveVertex(floop.get(floop.size() - 1).x, floop.get(floop.size() - 1).y);
      
      
      endShape();
      floop = new ArrayList<container>();
    }
    
}
void keyPressed(){
    background(150);
    floop = new ArrayList<container>();
}
void mousePressed(){
    strokeWeight(4);
}

class container{
    int x = 0;
    int y = 0;
    container(int X,int Y){
        x = X;
        y = Y;
    }
}