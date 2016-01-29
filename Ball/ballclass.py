class object:
    def __init__(self):
        self.position = PVector(random(1, width), random(1, height))
        self.velocity = PVector(0,0)
    def orbit(self, follow, strength):
        if keyPressed:
            self.decay = 1.0
        else:
            self.decay = 0.9
        self.velocity.x = (follow.x - self.position.x + self.velocity.x) * self.decay
        self.velocity.y = (follow.y - self.position.y + self.velocity.y) * self.decay
        self.position.add(0.1 * strength * self.velocity)
        ellipse(self.position.x, self.position.y, 75, 75)
    def chase(self, follow2, strength):
        self.velocity = follow2
        self.velocity.sub(self.position)
        self.velocity.mult(0.1*strength)
        self.position.add(self.velocity)
        ellipse(self.position.x, self.position.y, 75, 75)