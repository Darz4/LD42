require "GameObject"

Tile = GameObject:extend()

TileTypes =
{
    default = 0,
    sky = 1,
    floor = 2,
    ground = 3,
    plant = 4,
    plantBase = 5,
    root = 6,
}

Tile.size = 40


function Tile:new(layer, tileType, row, col, spriteNames, isAnimated)
    self.layer = layer
    self.type = tileType
    self.row = row
    self.col = col
    self.x = (col - 1) * Tile.size
    self.y = (row - 1) * Tile.size
    self.pickingState = 0
    self.isAnimated = isAnimated
    self.spriteNames = spriteNames
    self.currentFrame = 1
    self.flags = { false, false, false, false }

    if layer then
        layer:setTile(row, col, self)
    end
    
    if self.type == TileTypes.default then
        return
    end

    if type(self.spriteNames) == 'table' then
        self.spriteNames = { self.spriteNames[math.random(1, #self.spriteNames)] }
    else
        self.spriteNames = { self.spriteNames }
    end

    if self.isAnimated then
        local spriteNames = {}
        for spriteName, _ in pairs(sprites) do
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

function Tile:load()
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
    if self.type == TileTypes.default then
        return
    end

    love.graphics.setColor(1, 1, 1)
    if startsWith(self.spriteNames[1], 'tiles/Tile_herb') then
        love.graphics.draw(sprites['tiles/Tile_sky0.png'], self.x - camera.x, self.y - camera.y) -- ugly, just for floor tiles background
    end

    local spriteName = self.spriteNames[math.floor(self.currentFrame)]

    if sprites[spriteName] then
        love.graphics.draw(sprites[spriteName], self.x - camera.x, self.y - camera.y)
    end
end

function Tile:setFlag(index, value)
    if self.type == TileTypes.root then
        self.flags[index] = value
        local flagsKey = getFlagsKey(self.flags)
        local flagsSpritesTab = flagsSprites[flagsKey]

        if flagsSpritesTab and #flagsSpritesTab > 0 then
            self.spriteNames = { flagsSpritesTab[math.random(1, #flagsSpritesTab)] .. '.png' }
        end
    end
end