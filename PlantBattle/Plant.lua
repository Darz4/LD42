require "GameObject"

Plant = GameObject:extend()


function Plant:new(row, col)
    self.row = row
    self.col = col
    self.basePlant = Tile(map.layers['plant'], TileTypes.seed, row, col, 'Plants/Plant_start_anim', true)
    self.baseRoot = Tile(map.layers['roots'], TileTypes.root, row, col, 'Plants/Roots/Root_base_D')
end

function Plant:load()
    self.basePlant:setFlag(2, true)
    self.baseRoot:setFlag(4, true)
end

function Plant:update(dt)
end

function Plant:draw()
end