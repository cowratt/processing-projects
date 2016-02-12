class slider:
    def __init__(self, x, y,Range, Size):
        rectMode(CENTER)
        self.x = x
        self.y = y
        self.MaxMin = Range
        self.Size = float(abs(Size))
        self.pos = x
        self.lock = x
        self.pickedup = False
    def live(self):
        #this draws it
        strokeWeight(3)
        line(self.x - self.Size, self.y, self.x + self.Size, self.y)
        strokeWeight(1)
        rect(self.pos, self.y, self.Size/5, self.Size/3)
        #this makes it pick-up able
        if self.Size / -5 < self.pos - mouseX < self.Size / 5 and self.Size / -5 < self.y - mouseY < self.Size / 5 and mousePressed:
            self.pickedup = True
        if mousePressed and self.pickedup == True:
            self.pos = mouseX - self.lock
            fill(115)
        else:
            self.lock = mouseX - self.pos
            self.pickedup = False
            fill(55)
        #adds bounds
        self.pos = max(self.x - self.Size,min(self.x + self.Size, self.pos))
    def eval(self):
        a = (self.pos - self.x) * (self.MaxMin / self.Size)
        return(a)
        
        
def setup():
    global s
    s = slider(500,500,20,300)
    size(1000,1000)
    textAlign(CENTER, CENTER)
    textSize(30)
def draw():
    background(200)
    s.live()
    text(s.eval(), width/2, 300)
        