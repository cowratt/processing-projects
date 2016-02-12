def setup():
    size(500, 500)
    background(224, 219, 172)
    rectMode(CENTER)
    fill(55)
    global box1
    box1 = physicsbox(50, 50)
    global box2
    box2 = physicsbox(150, 150)

def draw():
    background(224, 219, 172)
    box1.pickup()
    box1.phys()
    box1.show()
    box2.pickup()
    box2.phys()
    box2.show()



class physicsbox():
    def __init__(self, x, y):
        self.position = PVector(x, y)
        self.velocity = PVector(0,0)
        self.mouselock = PVector(0,0)
        self.pickedup = False
        self.lastloc = PVector()
        self.lastloc.set(self.position)
        
    def pickup(self):
        
        if -25 < self.position.x - mouseX < 25 and -25 < self.position.y - mouseY < 25 and mousePressed:
            self.pickedup = True
        if mousePressed and self.pickedup == True:
            self.position.x = mouseX - self.mouselock.x
            self.position.y = mouseY - self.mouselock.y
            fill(115)
        else:
            self.mouselock.set(mouseX - self.position.x, mouseY - self.position.y)
            self.pickedup = False
            fill(55)
        
    def show(self):
        rect(self.position.x, self.position.y, 50, 50)
    def phys(self):
        if self.pickedup == False:
            self.velocity.mult(0.98)
            self.position.add(self.velocity)
            
        else:
            self.velocity.set(self.position)
            self.velocity.sub(self.lastloc)
            self.velocity.div(2)
            self.lastloc.set(self.position)
            
        #bounce on edges
        if self.position.x < 0 or self.position.x > width:
            self.velocity.x*=-0.9
        if self.position.y < 0 or self.position.y > height:
            self.velocity.y*=-0.9
        
        self.position.x = max(1, min(width, self.position.x))
        self.position.y = max(1, min(height, self.position.y))
            