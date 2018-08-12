require "GameObject"
require "PlantTile"

Plant = GameObject:extend()

function Plant:new(row, col)
    self.layer = map:addLayer('plant')
    self.rootTile =  PlantTile(Tile(self.layer, row, col, 'Plants/Plant_start_anim', true))
    self.tiles = { self.rootTile }
end

function Plant:load()
    for _, tile in pairs(self.tiles) do
        tile:load()
    end
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