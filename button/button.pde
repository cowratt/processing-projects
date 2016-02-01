class Button {
    String label;
    float x;        // center x position
    float y;        // center y position
    float w;        // width of button
    float h;        // height of button
    boolean laststep = false;
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
    boolean clicked(){
        if(!pressed() && laststep){
            laststep = false;
            return true;
        }
        else{
            laststep = pressed();
            return false;
        }
        
    }
 }

/*

void setup(){
  size(400, 400);
  
}
Button b = new Button("Click Me!", 200, 200, 100, 100);
int n = 5;
void draw(){
  background(200);
  if( b.clicked()){
    background(#CB5858);
    n = n + 1;
  }
  if(b.pressed()){
    background(#68D0F5);
  }
  b.Draw();
  text(n, 100, 100);
}
*/