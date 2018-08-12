require "GameObject"
require "PlantTile"

Plant = GameObject:extend()

rootFlags =
{
    Root_10 = { false, true, false, false },
    Root_1 = { true, false, false, false },
    Root_12 = { false, false, true, false },
    Root_20 = { true, false, false, true },
    Root_21 = { false, false, true, true },
    Root_22 = { false, true, true, false },
    Root_23 = { true, true, false, false },
    Root_30 = { true, false, true, false },
    Root_31 = { false, true, false, true },
    Root_40 = { true, false, true, true },
    Root_41 = { true, true, true, false },
    Root_42 = { true, true, false, true },
    Root_43 = { false, true, true, true },
    Root_50a = { true, true, true, true },
    Root_50b = { true, true, true, true },
}

flagsSprites = {}


function Plant:new(row, col)
    self.layer = map:addLayer('plant')
    self.rootTile =  PlantTile(Tile(self.layer, row, col, 'Plants/Plant_start_anim', true))
    self.tiles = { self.rootTile }
end

function Plant:load()
    for k,v in pairs(rootFlags) do
        local flagsString = getFlagsString(v)
        flagsSprites[flagsString] = k
    end

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