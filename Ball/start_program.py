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