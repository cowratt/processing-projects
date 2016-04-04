node[] n = new node[100];
void setup(){
    size(500,500);
    for(int i = 0; i < n.length; i++){
        n[i] = new node(200, 2*PI*i/n.length);
    }
    strokeWeight(3);
}

void draw(){
    background(100);
    for(node n : n){
        point(n.x + width/2, n.y + height/2);
        n.live();
    }
}

class node extends PVector{
    int len = 0;
    node(int Length, float rot){
        len = Length;
        this.set(Length, 0);
        this.rotate(rot);
    }
    
    void live(){
        if (mousePressed) this.setMag(this.mag()*0.95);
        else this.setMag(this.mag() + len/this.mag());
    }
        
}