def setup():
    colorMode(HSB, 360, 100, 100)
    textSize(20)
    size(500,500)
    global listOfBalls
    listOfBalls = []
    for x in range(10):
        listOfBalls.append(ball())

def draw():
    
    global listOfBalls
    background(200)
    text(frameRate, 0, 20)
    
    #this goes through the list and draws each ball once, and collides each ball with every other ball exactly once. No duplicate collisions, because it uses the handshake idea that we learned in algebra with nCr and shit
    for a in range(0,len(listOfBalls)):
        ba = listOfBalls[a]
        ba.Draw()
        for b in range(a,len(listOfBalls)):
            bb = listOfBalls[b]
            ba.collide(bb)
            
    
class ball():
    def __init__(self):
        #p = position, v = velocity, c = color
        
        self.p = PVector(random(width),random(height))
        self.v = PVector(random(-10,10),random(-10,10))
        self.c = color(random(360),100,100)
        
    def Draw(self):
        # add velocity to position ( x = x + v)
        self.p.add(self.v)
        
        #bounce on edges
        if not (0 < self.p.x < width) or not (0 < self.p.y < height):
            if not (0 < self.p.x < width):
                self.v.x *=-1
            if not (0 < self.p.y < height):
                self.v.y *=-1
            self.p.set(min(max(self.p.x, 0), width), min(max(self.p.y, 0), height))
            
        #draw
        fill(self.c)
        ellipse(self.p.x,self.p.y,30,30)
        
    def collide(self, collidee):
        # WRITE SOME SHIT RITE HERE MOTHERFUCKER
        pass
        # ^   AND GET RID OF THIS WHEN YOU DO