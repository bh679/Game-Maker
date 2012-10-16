global.X = x
global.Y = y

with(argument0)
{
    if InBox(global.Y,global.X,self.x+self.width/2,self.y+self.height/2,self.x-self.width/2,self.y-self.height/2)
        return true
}

return false
