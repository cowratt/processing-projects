class button():
    def __init__(self, x, y, Width, Height, Text):
        self.x = x
        self.y = y
        self.Width = Width
        self.Height = Height
        self.Text = Text
        pass
    def Draw(self):
        fill(100)
        rect(self.x,self.y,self.Width,self.Height)
        fill(200)
        text(self.Text, self.x,self.y)
        
def setup():
    rectMode(RADIUS)
    textAlign(CENTER, CENTER)
    textSize(20)
    size(500,500)
    global b
    b = button(100,100, 50, 50,"noot noot")
    
def draw():
    b.Draw()
        