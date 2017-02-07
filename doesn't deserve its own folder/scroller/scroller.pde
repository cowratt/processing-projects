iconList l;
void setup(){
    size(1000,500);
    colorMode(HSB, 360, 100, 100);
    
    l = new iconList(50);
    
}

void draw(){
    if(mousePressed) print(l.size());
    l.draw();
}

class iconList{
    private ArrayList<icon> list = new ArrayList<icon>();
    float falloff = 0.9;
    private int margin = 20;
    private int heightDifferential = 3;
    private int widthDifferential = 8;
    private int minMargin = 5;
    private int displayDesnity;
    private int elementWidth = 10;

    public int size(){return list.size();}
    iconList(int s){
        for(int i = 0; i < s; i++){
            list.add(new icon(color(random(360), 100, 100)));
        }
    }
    void draw(){
        int midpoint = size()/2;
        int position = width/2;

        int distanceFree = ((width/2 - margin) - (size()-midpoint)*elementWidth*2);
        float startingval = 0.0;
        for (int i = 1; i<=midpoint; i++){
            startingval += 1/i;
        }
        startingval = distanceFree/startingval;
        

            for (int i = midpoint; i < size(); i++){
                icon ic = list.get(i);
                fill(ic.col);
                ellipse(position, height/2, elementWidth, elementWidth);
                position += int(startingval / ( i - midpoint + 3));
                
            }
    }
}

class icon{
    color col;
    icon(color c){
        col = c;
    }
}