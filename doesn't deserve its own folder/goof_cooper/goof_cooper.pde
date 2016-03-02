button b;
int i = 20;
void setup() {
    PFont f = createFont("Arial Bold", 28);
    textFont(f);
    size(600, 600);
    b = new button("CLICK ME MOTHERFUCKER", width/2, height/2, 400, 100);
    noStroke();
    a +="/bit.";

}
String a = "http:/";
void draw() {
    b.Draw();
    
    if(i < 10){
        String s = a + bo;
        s = s + "1o045fn3_" + i;
        link(s, "_new");
        i +=1;
    }
    
}
void mouseReleased(){
    if (b.pressed){
        i = 1;
        
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