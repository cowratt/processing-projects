class object:
    def __init__(self, r, g, b, a):
        self.position = PVector(random(1, width), random(1, height))
        self.velocity = PVector(0,0)
        self.tvelocity = PVector(0,0)
        self.follow = PVector(0,0)
        self.colour = color(r, g, b, a)
    def orbit(self, follow, strength):
        if keyPressed:
            self.decay = 1.0
        else:
            self.decay = 0.9
        self.follow.set(follow)
        self.velocity.x = (self.follow.x - self.position.x + self.velocity.x) * self.decay
        self.velocity.y = (self.follow.y - self.position.y + self.velocity.y) * self.decay
        self.tvelocity.set(self.velocity)
        self.tvelocity.mult(0.1*strength)
        self.position.add(self.tvelocity)
        fill(self.colour)
        ellipse(self.position.x, self.position.y, 75, 75)
    def chase(self, follow2, strength):
        self.follow.set(follow2)
        self.velocity = self.follow
        self.velocity.sub(self.position)
        self.velocity.mult(0.1*strength)
        self.position.add(self.velocity)
        fill(self.color)
        ellipse(self.position.x, self.position.y, 75, 75)