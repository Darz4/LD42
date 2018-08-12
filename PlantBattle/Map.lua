require "GameObject"
require "Tile"
require "Layer"
require "Plant"

Map = GameObject:extend()


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

graphDirs = { 'tiles', 'cloud', 'Plants', 'Plants/Roots' }
sprites = {}
spriteGroups =
{
    floor1 = { 'tiles/Tile_herbground_1', 'tiles/Tile_herbground_3' },
    floor2 = { 'tiles/Tile_herbground_2', 'tiles/Tile_herbground_4' },
}
plant = nil


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]


function Map:new()
    self.x = 0
    self.y = 0
    self.height = 50
    self.width = 100
    self.layers = {}
    self.floorRow = math.floor(self.height / 2)
end

function Map:load()
    for _, graphDir in pairs(graphDirs) do
        local fullGraphDir = 'graphics/' .. graphDir
        local fileNames = love.filesystem.getDirectoryItems(fullGraphDir)

        for _, fileName in pairs(fileNames) do
            local fileInfo = love.filesystem.getInfo(fullGraphDir .. '/' .. fileName)
            if fileInfo.type == 'file' then
                print('loading ' .. fullGraphDir .. '/' .. fileName)
                sprites[graphDir .. '/' .. fileName] = love.graphics.newImage(fullGraphDir .. '/' .. fileName)
            end
        end
    end

    self:generateBackground()
    self:generatePlant()

    for _,layer in pairs(self.layers) do
        layer:load()
    end

    plant:load()
end

function Map:update(dt)
    for _,layer in pairs(self.layers) do
        layer:update(dt)
    end

    plant:update(dt)
end

function Map:draw()
    for _,layer in pairs(self.layers) do
        layer:draw()
    end

    plant:draw()
end

function Map:addLayer(layerName)
    self.layers[layerName] = Layer(layerName, self.width, self.height)
    return self.layers[layerName]
end

function Map:generatePlant()
    local row = self.floorRow
    local col = self.width / 2
    plant = Plant(row, col)
end

function Map:generateBackground()
    local layer = self:addLayer('background1')

    -- Sky
    for i = 1, self.floorRow do
        local row = {}
        for j = 1, self.width do
            local spriteNameSuffix = self.floorRow - i
            if spriteNameSuffix > 11 then spriteNameSuffix = 11 end
            Tile(layer, TileTypes.sky, i, j, 'tiles/Tile_sky' .. spriteNameSuffix)
        end
    end

    -- Floor
    local row = {}
    for j = 1, self.width do
        if j % 2 == 0 then
            Tile(layer, TileTypes.floor, self.floorRow, j, spriteGroups.floor1)
        else
            Tile(layer, TileTypes.floor, self.floorRow, j, spriteGroups.floor2)
        end
    end

    -- Ground
    for i = self.floorRow + 1, self.height do
        local row = {}
        for j = 1, self.width do
            local spriteNameSuffix = (j % 2) + 1
            Tile(layer, TileTypes.ground, i, j, 'tiles/Tile_ground_' .. spriteNameSuffix)
        end
    end
end