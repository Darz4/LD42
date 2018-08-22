require "GameObject"
require "Tile"
require "Layer"
require "Plant"
require "Globals"

Map = GameObject:extend()


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Constructor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]


function Map:new(width, height)
    self.width = width
    self.height = height
    self.layers = {}
    self.floorRow = math.floor(self.height / 2)

    self:addLayer('sky', true)
    self:addLayer('ground', true)
    self:addLayer('plant', true)
    self:addLayer('roots', true)
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function Map:load()
    self:loadSprites()
    self:generateBackgroundLayers()
    
    plant = Plant(self.floorRow, self.width / 2)

    for _,layer in ipairs(self.layers) do
        layer:load()
    end

    plant:load()
end

function Map:update(dt)
    for _,layer in ipairs(self.layers) do
        layer:update(dt)
    end

    plant:update(dt)
end

function Map:draw()
    for _,layer in ipairs(self.layers) do
        layer:draw()
    end

    plant:draw()
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function Map:loadSprites()
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
end

function Map:generateBackgroundLayers()
    -- Sky
    for i = 1, self.floorRow do
        local row = {}
        for j = 1, self.width do
            local spriteNameSuffix = self.floorRow - i
            if spriteNameSuffix > 11 then spriteNameSuffix = 11 end
            Tile(self.layers['sky'], TileTypes.sky, i, j, 'tiles/Tile_sky' .. spriteNameSuffix)
        end
    end

    -- Clouds
    local skyWpx = self.width * Tile.size
    local skyHpx = self.floorRow * Tile.size

    for i = 1, 10 do
        -- generate clouds
    end

    -- Floor
    local row = {}
    for j = 1, self.width do
        if j % 2 == 0 then
            Tile(self.layers['ground'], TileTypes.floor, self.floorRow, j, spriteGroups.floor1)
        else
            Tile(self.layers['ground'], TileTypes.floor, self.floorRow, j, spriteGroups.floor2)
        end
    end

    -- Ground
    for i = self.floorRow + 1, self.height do
        local row = {}
        for j = 1, self.width do
            local spriteNameSuffix = (j % 2) + 1
            Tile(self.layers['ground'], TileTypes.ground, i, j, 'tiles/Tile_ground_' .. spriteNameSuffix)
        end
    end
end

function Map:addLayer(layerName, isTiled)
    if not isTiled then isTiled = false end
    local newLayer = Layer(layerName, isTiled, self.width, self.height)
    table.insert(self.layers, newLayer)
    self.layers[layerName] = newLayer
    return self.layers[layerName]
end

function Map:getTile(row, col)
    local result = {}
    for k, v in pairs(self.layers) do
        if v.isTiled then
            result[k] = v:getTile(row, col)
        end
    end
    return result
end

function Map:getTileNeighbours(row, col)
    local result = {}
    for k, v in pairs(self.layers) do
        if v.isTiled then
            result[k] = v:getTileNeighbours(row, col)
        end
    end
    return result
end