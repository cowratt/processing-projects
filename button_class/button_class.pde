


color bg;
button b;
void setup(){
  size(400, 400);
  b = new button("Click Me!", 200, 200, 100, 100);
  
}

int n = 5;
void draw(){
  background(200);
  if( b.clicked){
    n = n + 1;
    bg = color(random(255),random(255),random(255));
  }
  if(b.pressed){
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
    boolean clicked = false;
    boolean pressed = false;
    button(String labelB, float xpos, float ypos, float widthB, float heightB) {
        label = labelB;
        x = xpos;
        y = ypos;
        w = widthB;
        h = heightB;
        rectMode(CENTER);
        textAlign(CENTER,CENTER);
    }
    void Draw() {
        if(clicked==true) clicked=false;
        mouse();
        if(pressed) fill(200);
        else fill(100);
        rect(x,y,w,h,10);
        fill(150);
        text(label,x,y);
    }
    void mouse(){
      if (mousePressed && pressed==false && abs(mouseX - x) < w/2 && abs(mouseY - y) < h/2){
        pressed = true;
        clicked = true;
      }
     else if(!mousePressed) pressed=false;
    }
}