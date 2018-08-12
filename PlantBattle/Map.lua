require "GameObject"
require "Tile"
require "Layer"

Map = GameObject:extend()


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

Colors =
{
    blue  = {r = 0.40, g = 0.80, b = 1.00},
    brown = {r = 0.83, g = 0.61, b = 0.14},
}

sprites = {}
spritesDir = 'graphics/tiles'
spriteGroups =
{
    floor1 = { 'Tile_herbground_1', 'Tile_herbground_3' },
    floor2 = { 'Tile_herbground_2', 'Tile_herbground_4' },
}


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]


function Map:new()
    self.x = 0
    self.y = 0
    self.height = 50
    self.width = 100
    self.layers = {}
end

function Map:load()
    local fileNames = love.filesystem.getDirectoryItems(spritesDir)

    for _, fileName in pairs(fileNames) do
        print('loading ' .. fileName)
        sprites[fileName] = love.graphics.newImage(spritesDir .. '/' .. fileName)
    end

    self:generateBackground()
end

function Map:update(dt)
    for _,layer in pairs(self.layers) do
        layer:update()
    end
end

function Map:draw()
    for _,layer in pairs(self.layers) do
        layer:draw()
    end
end

function Map:generateBackground()
    local layer = Layer()
    local groundRow = math.floor(self.height / 2)

    -- Sky
    for i = 0, groundRow - 1 do
        local row = {}
        for j = 0, self.width - 1 do
            local spriteNameSuffix = groundRow - i
            if spriteNameSuffix > 6 then spriteNameSuffix = 6 end
            table.insert(row, Tile(j * Tile.size, i * Tile.size, 'Tile_sky' .. spriteNameSuffix))
        end
        table.insert(layer.tiles, row)
    end

    -- Floor
    local row = {}
    for j = 0, self.width - 1 do
        if j % 2 == 0 then
            table.insert(row, Tile(j * Tile.size, groundRow * Tile.size, spriteGroups.floor1))
        else
            table.insert(row, Tile(j * Tile.size, groundRow * Tile.size, spriteGroups.floor2))
        end
    end
    table.insert(layer.tiles, row)

    -- Ground
    for i = groundRow + 1, self.height - 1 do
        local row = {}
        for j = 0, self.width - 1 do
            local spriteNameSuffix = (j % 2) + 1
            table.insert(row, Tile(j * Tile.size, i * Tile.size, 'Tile_ground_' .. spriteNameSuffix))
        end
        table.insert(layer.tiles, row)
    end

    table.insert(self.layers, layer)
end