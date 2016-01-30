from ballclass import object
def setup():

    size(1600, 900)
    background(0)
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
    ball3.orbit(ball2.position, .1)
    ball2.orbit(ball.position, .2)
    ball.orbit(mouse, .3)
    
    
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
        
        
        
        