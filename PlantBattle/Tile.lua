require "GameObject"
Tile = GameObject:extend()

Tile.size = 40

function Tile:new(x, y, spriteNames, isAnimated, color)
    self.x = x
    self.y = y
    self.color = color
    self.pickingState = 0
    self.isAnimated = isAnimated
    self.spriteNames = spriteNames
    self.currentFrame = 1
end

function Tile:load()
    if type(self.spriteNames) == 'table' then
        self.spriteNames = { self.spriteNames[math.random(1, #self.spriteNames)] .. '.png' }
    else
        self.spriteNames = { self.spriteNames .. '.png' }
    end

    if self.isAnimated then
        local spriteNames = {}
        for spriteName, _ in pairs(sprites) do
            if startsWith(spriteName, self.spriteNames[1]) then
                table.insert(spriteNames, spriteName .. '.png')
            end
        end
        self.spriteNames = spriteNames
        self.isAnimated = #spriteNames > 1
    end
end

function Tile:update(dt)
    if self.isAnimated then
        self.currentFrame = self.currentFrame + 10 * dt
        if self.currentFrame >= #self.spriteNames then
            self.currentFrame = 1
        end
    end
end

function Tile:draw()
    if self.color then
        love.graphics.setColor(self.color.r, self.color.g, self.color.b)
        love.graphics.rectangle('fill', self.x - camera.x, self.y - camera.y, Tile.size, Tile.size)
    end

    love.graphics.setColor(1, 1, 1)
    if startsWith(self.spriteNames[1], 'tiles/Tile_herb') then
        love.graphics.draw(sprites['tiles/Tile_sky0.png'], self.x - camera.x, self.y - camera.y) -- ugly, just for floor tiles background
    end

    local spriteName = self.spriteNames[math.floor(self.currentFrame)]
    love.graphics.draw(sprites[spriteName], self.x - camera.x, self.y - camera.y)
end