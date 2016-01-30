from ballclass import object
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
    ball = object()
    global ball2
    ball2 = object() 
    
velocity = PVector(0, 0)

def draw():
    if started == True:
        program()
    else:
        startprogram()
        
def program():

    if not mousePressed:
        background(33, 141, 155)
    global mouse
    mouse = PVector(mouseX,mouseY)
    
    ball.chase(mouse, 1)
    ball2.chase(ball.position, 1)
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
        
        
        
        