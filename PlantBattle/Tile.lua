require "GameObject"
Tile = GameObject:extend()

Tile.size = 40

function Tile:new(layer, row, col, spriteNames, isAnimated, color)
    self.layer = layer
    self.row = row
    self.col = col
    self.x = col * Tile.size
    self.y = row * Tile.size
    self.color = color
    self.pickingState = 0
    self.isAnimated = isAnimated
    self.spriteNames = spriteNames
    self.currentFrame = 1
end

function Tile:load()
    if type(self.spriteNames) == 'table' then
        self.spriteNames = { self.spriteNames[math.random(1, #self.spriteNames)] }
    else
        self.spriteNames = { self.spriteNames }
    end

    if self.isAnimated then
        local spriteNames = {}
        for spriteName, _ in pairs(sprites) do
            print('checking ' .. spriteName .. ' / ' .. self.spriteNames[1])
            if startsWith(spriteName, self.spriteNames[1]) then
                table.insert(spriteNames, spriteName)
            end
        end
        self.spriteNames = spriteNames
        self.isAnimated = #spriteNames > 1
    else
        self.spriteNames[1] = self.spriteNames[1] .. '.png'
    end
end

function Tile:update(dt)
    if self.isAnimated then
        self.currentFrame = self.currentFrame + 2 * dt
        if self.currentFrame >= #self.spriteNames + 1 then
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