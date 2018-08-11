require "GameObject"
Tile = GameObject:extend()


function Tile:new(x, y, color, image)
    self.x = x
    self.y = y
    self.image = image
    self.size = 40
    self.color = color
end

function Tile:update(dt)
end

function Tile:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end