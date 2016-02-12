from ballclass import object

def setup():

    size(1600, 900)
    background(0)
    rectMode(CENTER)
    #fill(125, 218, 229)
    strokeWeight(3)
    stroke(0, 0, 0, 255)
    textSize(15)
    colorMode(RGB)
    global started
    started = False
    global mouse
    mouse = PVector(mouseX, mouseY)
    global position
    position = PVector(width/2, height/2)
    global ball
    ball = object(255, 0, 0, 255)
    global ball2
    ball2 = object(0, 255, 0, 255)
    global ball3
    ball3 = object(0, 0, 255, 255) 
    global ball4
    ball4 = object(255, 255, 0, 255)
    global ball5
    ball5 = object(255,0,255,255)
    global ball6
    ball6 = object(0,255,255,255)
    global box
    box = physicsbox(width/2, height/2)
    
velocity = PVector(0, 0)

def draw():
    if started == True:
        program()
    else:
        startprogram()
        
def program():

    if not mousePressed:
        background(150)
    global mouse
    mouse = PVector(mouseX,mouseY)
    box.pickup()
    if box.pickedup:
        background(150)
    box.phys()
    box.show()
    ball6.orbit(ball5.position, .9)
    ball5.orbit(ball4.position, .5)
    ball4.orbit(ball3.position, .2)
    ball3.orbit(ball2.position, .2)
    ball2.orbit(ball.position, .2)
    ball.orbit(box.position, .3)
    
    
    fill(125, 218, 229)
    text("Framerate:" + str(frameRate), 10,15)
    text("Position:" + str(position), 10,40)
    text("Mouse:" + str(mouse), 10,65)


def startprogram():
    global started
    started = True
    background(33, 141, 155)
    textSize(80)
    text("Test: gravitation + decay", 280, 300)
    textSize(40)
    text("Click to draw, hit space to turn off gravitational decay", 230, 400)
    textSize(30)
    text("Press space to start", 630, 460)
    if keyPressed:
        started = True
        textSize(15)
        
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
            
        
        