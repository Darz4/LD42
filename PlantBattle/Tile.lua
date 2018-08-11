require "GameObject"
Tile = GameObject:extend()

Tile.size = 40

function Tile:new(x, y, color, image)
    self.x = x
    self.y = y
    self.image = image
    self.color = color
end

function Tile:update(dt)
end

function Tile:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.rectangle("fill", self.x - camera.x, self.y - camera.y, Tile.size, Tile.size)
end