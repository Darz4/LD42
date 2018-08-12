require "GameObject"
require "Tile"
PlantTile = GameObject:extend()

function PlantTile:new(tile)
    self.tile = tile
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