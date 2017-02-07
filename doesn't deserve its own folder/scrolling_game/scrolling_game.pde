ArrayList<repeller> r = new ArrayList<repeller>();
int cursorPosition;
int numNodes = 20;
int stdDst;
int margin = 40;
int cursorHeight;
boolean[] colors = new boolean[21];
void setup(){
    size(1000,300);
    
        
        
    cursorPosition = width/2;
    cursorHeight = height/3;
    stdDst = (width - 2*margin)/ (numNodes*2);
    colorMode(HSB, 365, 100, 100);
    while(r.size() < numNodes){
        int c = int(random(21));
        if(colors[c] == false){
            colors[c] = true;
            r.add(new repeller(margin + stdDst + stdDst*2*r.size(), height/2, 15*c));
    }
    for (int i = 0; i <= numNodes; i++){
            
    }
}
}
repeller closest;
void draw(){
    noStroke();
    cursorPosition += scrollSpeed;
    background(50);
    closest = null;
for (repeller a : r){
    if(abs(cursorPosition - a.position.x) <= stdDst) closest = a;
    fill(a.c);
    a.draw();
}
if(closest != null){
    strokeWeight(5);
    fill(closest.c);
    stroke(closest.c);
    ellipse(cursorPosition, cursorHeight, 20, 20);
    line(closest.position.x + closest.displacement.x, closest.position.y, cursorPosition, cursorHeight);
}
else{
    fill(100);
    ellipse(cursorPosition, cursorHeight, 20, 20);
}
}
void mouseClicked(){
    r.add(new repeller(mouseX, mouseY, int(random(300))));
}
int scrollSpeed = 0;
void mouseWheel(MouseEvent event){
    if(nfp(event.getCount(),3).charAt(0) != nfp(scrollSpeed,3).charAt(0) && scrollSpeed != 0) scrollSpeed = 0;
    

    else if(abs(scrollSpeed) > 4) scrollSpeed += event.getCount()*2;
    else scrollSpeed += event.getCount();
    print(scrollSpeed);
}
class repeller{
    PVector position;
    PVector displacement = new PVector(0,0);
    color c;
    repeller(int x,int y, int col){
        position = new PVector (x, y);
        c = color(col, 90, 95);
    }
    void draw(){
        displacement.set(position.x - cursorPosition, 25);
            float dsp = 40*pow(2,-0.0002*displacement.magSq() + 1);
                displacement.setMag(dsp);
    ellipse(position.x + displacement.x, position.y, 30, 30);
    }
}