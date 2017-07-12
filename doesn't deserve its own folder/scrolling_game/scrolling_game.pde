ArrayList<repeller> r = new ArrayList<repeller>();
float cursorPosition;
int numNodes = 20;
int stdDst;
int margin = 40;
int cursorHeight;
boolean[] colors = new boolean[21];
float scrollSpeed = 0;
int nodeRadius = 30;

boolean carryingNode = false;
repeller carriedNode;

repeller closest;
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

void draw(){
    noStroke();
    cursorPosition += scrollSpeed;
    cursorPosition = max(nodeRadius/2, min(width-nodeRadius/2, cursorPosition));
    scrollSpeed *= 0.96;
    print(scrollSpeed + "\n");
    background(50);
    closest = null;
for (repeller a : r){
    if(abs(cursorPosition - a.position.x) <= stdDst) closest = a;
    fill(a.c);
    a.draw();
}
if(carryingNode){
    strokeWeight(5);
    fill(carriedNode.c);
    stroke(carriedNode.c);
    ellipse(cursorPosition, cursorHeight, 20, 20);
    line(cursorPosition, height/2, cursorPosition, cursorHeight);
}
else if(closest != null){
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
    //r.add(new repeller(mouseX, mouseY, int(random(300))));
    if(!carryingNode){
        int closestNode = 999;
        for(int i = 0; i < r.size(); i++){
            if(abs(cursorPosition - r.get(i).position.x) <= stdDst) closestNode = i;
        }
        if (closestNode != 999){
            carriedNode = r.get(closestNode);
            r.remove(carriedNode);
            carryingNode = true;
            for (int i = closestNode; i < r.size(); i++){
                r.get(i).position.x -=stdDst*2;
            }
        }
        
    }
    else{
        int highestNode = 0;
        for(int i = 0; i < r.size(); i++){
            if(r.get(i).position.x + r.get(i).displacement.x <cursorPosition) highestNode = i+1; 
        }
        carriedNode.position.x = r.get(highestNode).position.x;
        for(int i = highestNode; i < r.size(); i++){
            r.get(i).position.x += stdDst*2;
        }
        
        r.add(1,carriedNode);
        carriedNode = null;
        carryingNode = false;
    }
}

void mouseWheel(MouseEvent event){
    if(sign(event.getCount()) != sign(scrollSpeed) && scrollSpeed != 0) scrollSpeed = event.getCount()/3.0;
    
    else if(abs(scrollSpeed) > 8) scrollSpeed += event.getCount()*3;
    else if(abs(scrollSpeed) > 1) scrollSpeed += event.getCount()*2;
    else scrollSpeed += event.getCount();
    //print(scrollSpeed);
}
class repeller{
    PVector position;
    PVector displacement = new PVector(0,0);
    int value;
    color c;
    repeller(int x,int y, int col){
        position = new PVector (x, y);
        c = color(col, 90, 95);
        value = col;
    }
    void draw(){
        displacement.set(position.x - cursorPosition, 25);
            float dsp = 40*pow(2,-0.0002*displacement.magSq() + 1);
                displacement.setMag(dsp);
    ellipse(position.x + displacement.x, position.y, nodeRadius, nodeRadius);
    }
}
char sign(int f){
    if(abs(f) / f == 1) return '+';
    else return '-';
}
char sign(float f){
    if(abs(f) / f == 1) return '+';
    else return '-';
}