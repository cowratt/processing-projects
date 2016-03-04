def setup():
    frameRate(120)
    size(600, 900)
    colorMode(HSB, 360, 255, 255)
    global CR
    CR = PVector(mouseX,mouseY)
    global ballz
    ballz= []
    for x in range(20):
        ballz.append(ball(random(width),random(height/2),0,0,color(random(360), random(200, 255), random(200, 255)), 40, False))

def draw():
    background(28, 35.7, 255)
    global CR
    CR.set(mouseX - width/2, height*.9 - mouseY)
    CR.setMag(60)
    noStroke()
    fill(200)
    ellipse(width/2, height * .9, 100, 100)
    strokeWeight(50)
    stroke(200)
    strokeCap(SQUARE)
    line(width/2, height * .9,width/2 + CR.x, height*0.9 - CR.y)
    
    for x in range(0,len(ballz) ):
        b = ballz[x]
        for y in range(x+1,len(ballz)):
            b2 = ballz[y]
            if (b.isabullet or b2.isabullet) and not (b.isabullet and b.isabullet):
                b.col(b2)
        b.doSomeShitYouStupidBitchHahaJustKidding()
    for b in ballz:
        if b.deleteme or b.p.x < 0 or b.p.x > width or b.p.y < 0 or b.p.y > height:
            if not b.isabullet:
                ballz.append(ball(random(width),random(height/2),0,0,color(random(360), random(200, 255), random(200, 255)), 40, False))
            ballz.remove(b)
            
            

def keyPressed():
    if (key == " "):
        ballz.append(ball(width/2, height * .9, CR.x / 10, CR.y / -10, color(0), 25, True))
    if (key == "r"):
        setup()

class ball():
    def __init__(self, posX, posY, velX, velY, floop, Size, isbullet):
        self.p = PVector(posX,posY)
        self.v = PVector(velX, velY)
        self.c = floop
        self.s = Size
        self.isabullet = isbullet
        self.deleteme = False
    
    def doSomeShitYouStupidBitchHahaJustKidding(self):
        self.p.add(self.v)
        noStroke()
        fill(self.c)
        ellipse(self.p.x,self.p.y,self.s, self.s)
        
    def col(self, bal):
        if sqrt(sq(self.p.x - bal.p.x) + sq(self.p.y - bal.p.y)) < (self.s + bal.s)/2:
            self.deleteme = True
            bal.deleteme = True