//changing hella stuff in order to force an update

button b;
void setup() {
    PFont f = createFont("Arial Bold", 28);
    textFont(f);
    size(600, 600);
    b = new button("CLICK ME MOTHERFUCKER", width/2, height/2, 400, 100);
    noStroke();
    a +="/bit.";
}
/*
Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
*/

String a = "http:/";
void draw() {
    b.Draw();
    
}
void mouseReleased(){
    if (b.pressed){
        for(int i = 1; i < 10;i++){
            String s = a + bo;
            s = s + "1o045fn3_" + i;
            link(s, "_new");
        }
        
    }
}

String bo = "ly/";
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
        
        if(pressed) fill(#AF2727);
        else if(abs(mouseX - x) < w/2 && abs(mouseY - y) < h/2) fill(#D85757);
        else fill(#F53939);
        rect(x,y,w,h,10);
        fill(240);
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
