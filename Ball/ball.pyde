from ballclass import object
import start_program
from start_program import startprogram
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
    if start_program.started == True:
        program()
    else:
        startprogram()
        
def program():

    if not mousePressed:
        background(33, 141, 155)
    global mouse
    mouse = PVector(mouseX,mouseY)
    
    ball.orbit(mouse, 1)
    ball2.chase(ball.position, 1)
    
    text("Framerate:" + str(frameRate), 10,15)
    text("Position:" + str(position), 10,40)
    text("Mouse:" + str(mouse), 10,65)


        