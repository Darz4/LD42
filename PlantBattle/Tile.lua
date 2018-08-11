require "GameObject"
Tile = GameObject:extend()

Tile.size = 40

function Tile:new(x, y, spriteGroup, color)
    self.x = x
    self.y = y
    self.color = color
    self.pickingState = 0

    if spriteGroup then
        self.spriteFileName = spriteGroup[math.random(1, #spriteGroup)] .. '.png'
    end
end

function Tile:update(dt)
end

function Tile:draw()
    if self.color then
        love.graphics.setColor(self.color.r, self.color.g, self.color.b)
        love.graphics.rectangle("fill", self.x - camera.x, self.y - camera.y, Tile.size, Tile.size)
    end

    if self.spriteFileName then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(sprites[self.spriteFileName], self.x - camera.x, self.y - camera.y)
    end
end