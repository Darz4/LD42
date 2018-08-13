require "GameObject"
require "Tile"

Tile.default = Tile(nil, TileTypes.default, 0, 0)

Layer = GameObject:extend()


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Constructor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function Layer:new(name, isTiled, width, height)
    self.name = name
    self.isTiled = isTiled
    self.width = width
    self.height = height
    self.entities = {}
    self.tiles = {}

    if self.isTiled then
        for i = 1, self.height do
            local row = {}
            for j = 1, self.width do
                table.insert(row, Tile(nil, TileTypes.default, i, j))
            end
            table.insert(self.tiles, row)
        end
    end
end

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function Layer:load()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:load()
        end
    end

    for _,entity in pairs(self.entities) do
        entity:load()
    end
end

function Layer:update(dt)
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:update(dt)
        end
    end

    for _,entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function Layer:draw()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:draw()
        end
    end

    for _,entity in pairs(self.entities) do
        entity:draw()
    end
end

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Entities Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function Layer:addEntity(entity)
    table.insert(self.entities, entity)
end

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Tiles Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function Layer:setTile(row, col, tile)
    if not self.isTiled then
        print('Layer:setTile : Layer ' .. self.name .. ' is not tiled')
        return
    end
    if row < 1 or row > self.height or col < 1 or col > self.width then
        print('Layer:setTile : Layer ' .. self.name .. ' : row or col are out of bounds')
        return
    end
    self.tiles[row][col] = tile
end

function Layer:getTile(row, col)
    if not self.isTiled then
        print('Layer:getTile : Layer ' .. self.name .. ' is not tiled')
    end
    if row < 1 or row > self.height or col < 1 or col > self.width then
        return Tile.default
    end
    return self.tiles[row][col]
end

function Layer:clear()
    if self.isTiled then
        for i = 1, self.height do
            for j = 1, self.width do
                if self.tiles[i][j].type ~= TileTypes.default then
                    self.tiles[i][j].type = TileTypes.default
                end
            end
        end
    end
end

function Layer:getTileNeighbours(row, col)
    if not self.isTiled then
        print('Layer:getTileNeighbours : Layer ' .. self.name .. ' is not tiled')
        return
    end
    return
    {
        self:getTile(row, col - 1),
        self:getTile(row - 1, col),
        self:getTile(row, col + 1),
        self:getTile(row + 1, col),
    }
end

