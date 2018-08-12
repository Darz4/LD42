require "GameObject"

Plant = GameObject:extend()

rootFlags =
{
    ['Plants/Roots/Root_10'] = { false, true, false, false },
    ['Plants/Roots/Root_11']= { true, false, false, false },
    ['Plants/Roots/Root_12'] = { false, false, true, false },
    ['Plants/Roots/Root_20'] = { true, false, false, true },
    ['Plants/Roots/Root_21'] = { false, false, true, true },
    ['Plants/Roots/Root_22'] = { false, true, true, false },
    ['Plants/Roots/Root_23'] = { true, true, false, false },
    ['Plants/Roots/Root_30'] = { true, false, true, false },
    ['Plants/Roots/Root_31'] = { false, true, false, true },
    ['Plants/Roots/Root_40'] = { true, false, true, true },
    ['Plants/Roots/Root_41'] = { true, true, true, false },
    ['Plants/Roots/Root_42'] = { true, true, false, true },
    ['Plants/Roots/Root_43'] = { false, true, true, true },
    ['Plants/Roots/Root_50a'] = { true, true, true, true },
    ['Plants/Roots/Root_50b'] = { true, true, true, true },
}

flagsSprites = {}


function Plant:new(row, col)
    self.layer = map:addLayer('plant')
    local plantBase = Tile(self.layer, TileTypes.plantBase, row, col, 'Plants/Plant_start_anim', true)
    
    for k,v in pairs(rootFlags) do
        local flagsKey = getFlagsKey(v)
        if not flagsSprites[flagsKey] then
            flagsSprites[flagsKey] = {}
        end
        table.insert(flagsSprites[flagsKey], k)
    end

    local test = Tile(self.layer, TileTypes.root, row + 1, col, 'Plants/Roots/Root_base_D')
    test:setFlag(2, true)
end

function Plant:load()
end

function Plant:update(dt)
end

function Plant:draw()
end