


color bg;
button b;
void setup(){
  size(400, 400);
  b = new button("Click Me!", 200, 200, 100, 100);
  
}

int n = 5;
void draw(){
  background(200);
  if( b.clicked()){
    n = n + 1;
    bg = color(random(255),random(255),random(255));
  }
  if(b.pressed()){
    background(bg);
  }
  cursor(ARROW);
  b.Draw();
  text(n, 100, 100);
}

class button {
    String label;
    float x;        // center x position
    float y;        // center y position
    float w;        // width of button
    float h;        // height of button
    boolean laststep = false;
    boolean buffer = true;
    boolean mousewasntpressed = false;
    button(String labelB, float xpos, float ypos, float widthB, float heightB) {
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
            cursor(HAND);
        }
        else if(MouseIsOver()){
            fill(210);
            cursor(HAND);
        }
        else{
            fill(180);
        }
        stroke(141);
        rect(x, y, w, h);
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
        
        if(MouseIsOver() && mousePressed && mousewasntpressed){
            
            return true;
        }
        mousewasntpressed = !mousePressed;
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