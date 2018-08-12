require "GameObject"
require "PlantTile"

Plant = GameObject:extend()

function Plant:new(row, col)
    self.layer = map:addLayer('plant')
    --self.rootTile =  PlantTile(Tile(self.layer, row, col, 'Plant_start_anim', true))
    --self.tiles = { self.rootTile }
    self.tiles = {}
end

function Plant:load()
end

function Plant:update(dt)
    for _, tile in pairs(self.tiles) do
        tile:update(dt)
    end
end

function Plant:draw()
    for _, tile in pairs(self.tiles) do
        tile:draw()
    end
end