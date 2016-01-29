
def setup():
    size(1600, 900)
    background(33, 141, 155)
    fill(125, 218, 229)
    strokeWeight(3)
    textSize(15)
    global started
    started = False
    global mouse
    mouse = PVector(mouseX, mouseY)
    global position
    position = PVector(width/2, height/2)
    global ball
    ball = orbital()
    global ball2
    ball2 = orbital()

    
velocity = PVector(0, 0)

def draw():
    if started == True:
        program()
    else:
        startprogram()
                
def startprogram():
    background(33, 141, 155)
    textSize(80)
    text("Test: gravitation + decay", 280, 300)
    textSize(40)
    text("Click to draw, hit space to turn off gravitational decay", 230, 400)
    textSize(30)
    text("Press space to start", 630, 460)
    if mousePressed:
        global started
        started = True
        textSize(15)
        
def program():

    if not mousePressed:
        background(33, 141, 155)
    global mouse
    mouse = PVector(mouseX,mouseY)
    
    ball.render(mouse, 1)
    ball2.render(mouse, 0.6)
    
    text("Framerate:" + str(frameRate), 10,15)
    text("Position:" + str(position), 10,40)
    text("Mouse:" + str(mouse), 10,65)

class orbital:
    def __init__(self):
        self.position = PVector(random(1, width), random(1, height))
        self.velocity = PVector(0,0)
    def render(self, follow, strength):
        if keyPressed:
            self.decay = 1.0
        else:
            self.decay = 0.9
        self.velocity.x = (follow.x - self.position.x + self.velocity.x) * self.decay
        self.velocity.y = (follow.y - self.position.y + self.velocity.y) * self.decay
        self.position.add(0.1 * strength * self.velocity)
        ellipse(self.position.x, self.position.y, 75, 75)
        