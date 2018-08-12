require "GameObject"
require "Tile"
require "Layer"
require "Plant"

Map = GameObject:extend()


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

Colors =
{
    blue  = {r = 0.40, g = 0.80, b = 1.00},
    brown = {r = 0.83, g = 0.61, b = 0.14},
}

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
    self.groundRow = math.floor(self.height / 2)
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
    local row = self.groundRow
    local col = self.width / 2
    plant = Plant(row, col)
end

function Map:generateBackground()
    local layer = self:addLayer('background1')

    -- Sky
    for i = 0, self.groundRow - 1 do
        local row = {}
        for j = 0, self.width - 1 do
            local spriteNameSuffix = self.groundRow - i
            if spriteNameSuffix > 11 then spriteNameSuffix = 11 end
            table.insert(row, Tile(layer, i, j, 'tiles/Tile_sky' .. spriteNameSuffix))
        end
        table.insert(layer.tiles, row)
    end

    -- Floor
    local row = {}
    for j = 0, self.width - 1 do
        if j % 2 == 0 then
            table.insert(row, Tile(layer, self.groundRow, j, spriteGroups.floor1))
        else
            table.insert(row, Tile(layer, self.groundRow, j, spriteGroups.floor2))
        end
    end
    table.insert(layer.tiles, row)

    -- Ground
    for i = self.groundRow + 1, self.height - 1 do
        local row = {}
        for j = 0, self.width - 1 do
            local spriteNameSuffix = (j % 2) + 1
            table.insert(row, Tile(layer, i, j, 'tiles/Tile_ground_' .. spriteNameSuffix))
        end
        table.insert(layer.tiles, row)
    end
end