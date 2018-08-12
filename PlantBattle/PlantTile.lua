require "GameObject"
require "Tile"
PlantTile = GameObject:extend()


function PlantTile:new(tile, flags)
    self.tile = tile
    self.flags = { false, false, false, false }
end

function PlantTile:load()
    self.tile:load()
end

function PlantTile:update(dt)
    self.tile:update(dt)
end

function PlantTile:draw()
    self.tile:draw()
end

function PlantTile:getSpriteName()
    return flagsSprites[getFlagsString(self.flags)]
end