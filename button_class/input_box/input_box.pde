textBox box;
void setup(){
    size(500,500);
    surface.setResizable(true);
    rectMode(CENTER);
    textAlign(CENTER,CENTER);
    box = new textBox(width/2,height/2, 100);
}
void draw(){
    box.show();
}

class textBox{
    int x,y,scale = 0;
    String words, prompt = "";
    boolean typing = false;
    textBox(int X, int Y, int Scale){
        x = X;
        y = Y;
        scale = Scale;
    }
    void show(){
        rect(x, y, scale, scale / 4);

        if(mousePressed && mouseX > x - scale && mouseX < x + scale && mouseY > y - scale/4 ** mouseY < y + scale/4;){
            typing = true;
        }
        else if(mousePressed) typing = false;
        if(typing){
            rect
        }
    }
    
    String getInput(){
        return "";
    }
}