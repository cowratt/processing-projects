class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  void Draw() {
    rectMode(CENTER);
    if(pressed()){
      fill(200);
    }
    else if(MouseIsOver()){
    fill(210);
    }
    else{
      fill(180);
    }
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x, y);
  }
  
  boolean MouseIsOver() {
    if (mouseX + w/2 > x && x > mouseX - w/2 && mouseY + h/2 > y && mouseY - h/2 < y) {
      return true;
    }
    return false;
  }
  boolean pressed() {
    if(MouseIsOver() && mousePressed){
      return true;
    }
    return false;
  }
 // boolean clicked(){
    
 // }
}

void setup(){
  size(400, 400);
  
}
Button b = new Button("Click Me!", 200, 200, 100, 100);

void draw(){
  background(200);
  if( b.pressed()){
    background(#CB5858);
  }
  b.Draw();
}